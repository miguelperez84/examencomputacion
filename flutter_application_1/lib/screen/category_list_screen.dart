import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/categoria.dart';
import 'package:flutter_application_1/screen/loading_screen.dart';
import 'package:flutter_application_1/services/category_service.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Categorías'),
      ),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categoryService.categories[index];
          print("Nombre de la categoría: ${category.categoriaName}");
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Center(
                child: Text(
                  category.categoriaName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Center(
                child: Text(
                  'Estado: ${category.categoriaState}',
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      categoryService.selectedCategory = category;
                      Navigator.pushNamed(
                        context,
                        'editCategory',
                        arguments: categoryService.selectedCategory,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Confirmación de eliminación
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Eliminar Categoría'),
                          content: Text(
                              '¿Estás seguro de querer eliminar la categoría "${category.categoriaName}"?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Eliminar'),
                              onPressed: () {
                                categoryService.deleteCategory(category);
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
            'editCategory',
            arguments: CategoriaListado(
              categoriaId: 0,
              categoriaName: '',
              categoriaState: 'Activa',
            ),
          );
        },
      ),
    );
  }
}
