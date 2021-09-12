import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_commerce/app/provider/login_form_provider.dart';

import 'package:u_commerce/app/ui/input_decorations.dart';
import 'package:u_commerce/app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('¡Hola!', style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 30,),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text('o continua con'),
              SizedBox(height: 50),
            ],
          ),
        )
      )
   );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '123456789',
                labelText: 'Identificación',
                prefixIcon: Icons.perm_identity
              ),
              onChanged: (value) => loginForm.identificacion, 
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password,
            ),
            SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              color: Colors.deepPurple,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Espera...'
                  : 'Ingresa',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading ? null : () async{
                FocusScope.of(context).unfocus();
                if(!loginForm.isValidForm()) return;
                loginForm.isLoading = true;

                await Future.delayed(Duration(seconds: 2));
                loginForm.isLoading = false;
                Navigator.pushReplacementNamed(context, 'home');
              },
            )
          ],
        ),
      ),
    );
  }
}