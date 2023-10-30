import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/proveedor.dart';
import 'package:flutter_application_1/services/proveedor_service.dart';
import 'package:provider/provider.dart';

class ProviderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProveedorListado provider;

  ProviderFormProvider(this.provider);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
