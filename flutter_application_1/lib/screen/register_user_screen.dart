import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/register_form_provider.dart'; // Asegúrate de tener este archivo
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/ui/ui.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Registra una cuenta',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => RegisterFormProvider(),
                      child: RegisterForm(),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, 'login'),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.indigo.withOpacity(0.1)),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                      child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecortions.authInputDecoration(
                hinText: 'Ingrese su correo',
                labelText: 'Email',
                prefixIcon: Icons.email_outlined,
              ),
              onChanged: (value) => registerForm.email = value,
              validator: (value) => EmailValidator.validate(value ?? '')
                  ? null
                  : 'Ingrese un correo válido',
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecortions.authInputDecoration(
                hinText: '************',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => registerForm.password = value,
              validator: (value) => value != null && value.length >= 6
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres',
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              color: Colors.deepOrange,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  registerForm.isLoading ? 'Cargando...' : 'Registrar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              elevation: 0,
              onPressed: registerForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!registerForm.isValidForm()) return;
                      registerForm.isLoading = true;
                      final String? errorMessage =
                          await authService.create_user(
                              registerForm.email, registerForm.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                        // Mostrar mensaje de éxito
                      } else {
                        // Mostrar mensaje de error
                      }
                      registerForm.isLoading = false;
                    },
            )
          ],
        ),
      ),
    );
  }
}
