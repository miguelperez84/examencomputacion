import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/categoria.dart';
import 'package:flutter_application_1/models/proveedor.dart'; // Asegúrate de importar el modelo correcto

import 'package:flutter_application_1/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'list': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
    'categories': (BuildContext context) => const CategoryListScreen(),
    'editCategory': (BuildContext context) => CategoryEditScreen(
          category:
              ModalRoute.of(context)!.settings.arguments as CategoriaListado,
        ),
    // Agregando las rutas para proveedores
    'providers': (BuildContext context) => const ProviderListScreen(),
    'editProvider': (BuildContext context) => ProviderEditScreen(
          provider:
              ModalRoute.of(context)!.settings.arguments as ProveedorListado,
        ),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
