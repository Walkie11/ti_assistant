import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/authProvider.dart';
import 'package:ti_asistan/service/apiService.dart';

class ConnexionForm extends StatefulWidget {
  const ConnexionForm({super.key});

  @override
  State<ConnexionForm> createState() => _ConnexionFormState();
}

class _ConnexionFormState extends State<ConnexionForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _api = Apiservice();
  final _prov = Authprovider();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          TextFormField(
            controller: _userController,
            decoration: InputDecoration(labelText: "Nom d'utilisateur"),
            validator: (value) {
              if (value == null) {
                return "Veuillez saisir un nom d'utilisateur";
              } else if (value.length < 3) {
                return "Nom d'utilisateur trop court";
              }
              return null;
            },
          ),
          SizedBox(height: 50),
          TextFormField(
            controller: _passController,
            decoration: InputDecoration(
              labelText: "Mot de passe",
            ),
            obscureText: true,
            validator: (value) {
              if (value == null) {
                return "Veuillez saisir un Mot de passe";
              } else if (value.length < 3) {
                return "Mot de passe trop court";
              }
              return null;
            },
          ),
          SizedBox(height: 50),

          ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()) {
                await _prov.Connecter(
                  _userController.text,
                  _passController.text,
                );
                if (_prov.Connected) {
                  Navigator.popAndPushNamed(context, '/accueil');
                }
              }
            },
            child: const Text('Se connecter'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
