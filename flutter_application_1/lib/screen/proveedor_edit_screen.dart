import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/proveedor.dart';
import 'package:flutter_application_1/services/proveedor_service.dart';
import 'package:provider/provider.dart';

class ProviderEditScreen extends StatelessWidget {
  final ProveedorListado provider;

  const ProviderEditScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    ProveedorListado editingProvider = provider ??
        providerService.selectedProvider ??
        ProveedorListado(
          proveedorId: 0,
          proveedorName: '',
          proveedorLastName: '',
          proveedorMail: '',
          proveedorState: '',
        );

    final nameController = TextEditingController(text: provider.proveedorName);
    final lastNameController =
        TextEditingController(text: provider.proveedorLastName);
    final emailController = TextEditingController(text: provider.proveedorMail);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            provider.proveedorId == 0 ? 'Crear Proveedor' : 'Editar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del Proveedor'),
            ),
            TextField(
              controller: lastNameController,
              decoration:
                  const InputDecoration(labelText: 'Apellido del Proveedor'),
            ),
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo del Proveedor'),
            ),
            ElevatedButton(
              child: const Text('Guardar'),
              onPressed: () {
                final newProvider = ProveedorListado(
                  proveedorId: provider.proveedorId,
                  proveedorName: nameController.text,
                  proveedorLastName: lastNameController.text,
                  proveedorMail: emailController.text,
                  proveedorState: provider.proveedorState,
                );
                providerService.editOrCreateProvider(newProvider);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
