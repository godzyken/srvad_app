import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  var givenName;
  var password;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16),children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CupertinoTextField(
              placeholder: "Utilisateur",
              clearButtonMode: OverlayVisibilityMode.editing,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                givenName = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CupertinoTextField(
              placeholder: "Password",
              clearButtonMode: OverlayVisibilityMode.editing,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          FlatButton.icon(
            onPressed: () {
              print(givenName);
              print(password);
              signup(givenName, password);
            },
            icon: Icon(Icons.save),
            label: Text('s\'enregistrer'),
          )
        ],),
      ),
    );
  }

  signup(givenName, password) async {
    var url = "http://127.0.0.1:5000";
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'utilisateur': givenName,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {

    } else {
      throw Exception('Erreur l\'or de lma création');
    }
  }
}
