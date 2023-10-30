import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/proveedor.dart';
import 'package:flutter_application_1/screen/loading_screen.dart';
import 'package:flutter_application_1/services/proveedor_service.dart';
import 'package:provider/provider.dart';

class ProviderListScreen extends StatelessWidget {
  const ProviderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    if (providerService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Proveedores'),
      ),
      body: ListView.builder(
        itemCount: providerService.providers.length,
        itemBuilder: (BuildContext context, int index) {
          final provider = providerService.providers[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/provider_default.png'), // Reemplaza con tu imagen o ícono
              ),
              title: Text(
                '${provider.proveedorName} ${provider.proveedorLastName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Correo: ${provider.proveedorMail}\nEstado: ${provider.proveedorState}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      providerService.selectedProvider = provider;
                      Navigator.pushNamed(
                        context,
                        'editProvider',
                        arguments: providerService.selectedProvider,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Eliminar Proveedor'),
                          content: Text(
                              '¿Estás seguro de querer eliminar al proveedor "${provider.proveedorName} ${provider.proveedorLastName}"?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Eliminar'),
                              onPressed: () {
                                providerService.deleteProvider(provider);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            'editProvider',
            arguments: ProveedorListado(
              proveedorId: 0,
              proveedorName: '',
              proveedorLastName: '',
              proveedorMail: '',
              proveedorState: 'Activo',
            ),
          );
        },
      ),
    );
  }
}
