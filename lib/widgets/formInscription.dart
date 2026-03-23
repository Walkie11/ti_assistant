import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/authProvider.dart';

class InscriptionForm extends StatefulWidget {
  const InscriptionForm({super.key});

  @override
  State<InscriptionForm> createState() => _InscriptionFormState();
}

class _InscriptionFormState extends State<InscriptionForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _mailController = TextEditingController();
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
            controller: _mailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "exemple@mail.com",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez saisir votre email";
              }

              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegExp.hasMatch(value)) {
                return "Format d'email invalide";
              }

              return null;
            },
          ),
          SizedBox(height: 50),
          TextFormField(
            controller: _passController,
            decoration: InputDecoration(labelText: "Mot de passe"),
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
          TextFormField(
            controller: _passController,
            decoration: InputDecoration(labelText: "Confirmer le mot de passe"),
            obscureText: true,
            validator: (value) {
              if (value == null) {
                return "Veuillez saisir un Mot de passe";
              } else if (value != _passController.text) {
                return "Les mots de passe ne correspondent pas";
              }
              return null;
            },
          ),
          SizedBox(height: 50),

          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _prov.Inscrire(
                  _userController.text,
                  _mailController.text,
                  _passController.text,
                );
                if (_prov.estInscrit) {
                  Navigator.popAndPushNamed(context, '/');
                }
              }
            },
            child: const Text("S'inscrire"),
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
