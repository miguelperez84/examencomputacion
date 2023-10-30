import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/proveedor.dart';

class ProviderService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';
  List<ProveedorListado> providers = [];
  ProveedorListado? selectedProvider;
  bool isLoading = true;
  bool isEditCreate = true;

  ProviderService() {
    loadProviders();
  }

  Future loadProviders() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'ejemplos/provider_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      final providersMap = Proveedor.fromJson(response.body);
      providers = providersMap.listadoProveedores;
      print("Respuesta del servidor: ${response.body}");
    } else {
      print('Error con la solicitud: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProvider(ProveedorListado provider) async {
    isEditCreate = true;
    notifyListeners();
    if (provider.proveedorId == 0) {
      await createProvider(provider);
    } else {
      await updateProvider(provider);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> createProvider(ProveedorListado provider) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
        body: json.encode({
          'provider_name': provider.proveedorName,
          'provider_last_name': provider.proveedorLastName,
          'provider_mail': provider.proveedorMail,
          'provider_state': provider.proveedorState,
        }),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      providers.add(provider);
      await loadProviders();
    } else {
      print('Error al agregar proveedor: ${response.statusCode}');
    }
    return '';
  }

  Future<String> updateProvider(ProveedorListado provider) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
        body: json.encode({
          'provider_id': provider.proveedorId,
          'provider_name': provider.proveedorName,
          'provider_last_name': provider.proveedorLastName,
          'provider_mail': provider.proveedorMail,
          'provider_state': provider.proveedorState,
        }),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      final index = providers
          .indexWhere((element) => element.proveedorId == provider.proveedorId);
      providers[index] = provider;
      await loadProviders();
    } else {
      print('Error al actualizar proveedor: ${response.statusCode}');
    }
    return '';
  }

  Future deleteProvider(ProveedorListado provider) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
        body: json.encode({'provider_id': provider.proveedorId}),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      providers.removeWhere(
          (element) => element.proveedorId == provider.proveedorId);
      await loadProviders();
    } else {
      print('Error al eliminar proveedor: ${response.statusCode}');
    }
    return '';
  }
}
