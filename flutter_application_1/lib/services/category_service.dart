import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/categoria.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';
  List<CategoriaListado> categories = [];
  CategoriaListado? selectedCategory;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'ejemplos/category_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    //prueba de respuesta servidor
    print("Respuesta del servidor: ${response.body}");

    if (response.statusCode == 200) {
      final categoriesMap = Categoria.fromJson(response.body);
      print("Categorías cargadas: ${categoriesMap.listadoCategorias}");
      categories = categoriesMap.listadoCategorias;
    } else {
      print('Error con la solicitud: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateCategory(CategoriaListado category) async {
    isEditCreate = true;
    notifyListeners();
    if (category.categoriaId == 0) {
      await createCategory(category);
    } else {
      await updateCategory(category);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> createCategory(CategoriaListado category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
        body: json.encode({
          'category_name': category.categoriaName,
          'category_state': category.categoriaState,
        }),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      categories.add(category);
      await loadCategories();
    } else {
      print('Error al agregar categoría: ${response.statusCode}');
    }
    return '';
  }

  Future<String> updateCategory(CategoriaListado category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
        body: json.encode({
          'category_id': category.categoriaId,
          'category_name': category.categoriaName,
          'category_state': category.categoriaState,
        }),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      final index = categories
          .indexWhere((element) => element.categoriaId == category.categoriaId);
      categories[index] = category;
      await loadCategories();
    } else {
      print('Error al actualizar categoría: ${response.statusCode}');
    }
    return '';
  }

  Future deleteCategory(CategoriaListado category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url,
        body: json.encode({'category_id': category.categoriaId}),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      categories.removeWhere(
          (element) => element.categoriaId == category.categoriaId);
      await loadCategories();
    } else {
      print('Error al eliminar categoría: ${response.statusCode}');
    }
    return '';
  }
}
