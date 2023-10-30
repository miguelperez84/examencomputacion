import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/categoria.dart';
import 'package:flutter_application_1/services/category_service.dart';
import 'package:provider/provider.dart';

class CategoryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CategoriaListado category;

  CategoryFormProvider(this.category);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
