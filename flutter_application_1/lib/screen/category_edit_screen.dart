import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/categoria.dart';
import 'package:flutter_application_1/services/category_service.dart';
import 'package:provider/provider.dart';

class CategoryEditScreen extends StatelessWidget {
  final CategoriaListado category;

  const CategoryEditScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    CategoriaListado editingCategory = category ??
        categoryService.selectedCategory ??
        CategoriaListado(categoriaId: 0, categoriaName: '', categoriaState: '');
    final nameController = TextEditingController(text: category.categoriaName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            category.categoriaId == 0 ? 'Crear Categoría' : 'Editar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre de la Categoría'),
            ),
            ElevatedButton(
              child: const Text('Guardar'),
              onPressed: () {
                final newCategory = CategoriaListado(
                  categoriaId: category.categoriaId,
                  categoriaName: nameController.text,
                  categoriaState: category.categoriaState,
                );
                categoryService.editOrCreateCategory(newCategory);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
