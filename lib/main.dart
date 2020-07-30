import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const Request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=670d81ad";

void main() async {
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          ))));
}

Future<Map> getData() async {
  http.Response response = await http.get(Request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {
    print(text);
  }

  void _dolarChanged(String text) {
    print(text);
  }

  void _euroChanged(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: PreferredSize(
          child: AppBar(
            title: Text("Conversor",
                style: TextStyle(fontSize: 30.0, color: Colors.white)),
            backgroundColor: Colors.amber[700],
            centerTitle: true,
          ),
          preferredSize: Size.fromHeight(60.0)),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando dados",
                      style:
                          TextStyle(fontSize: 30.0, color: Colors.amber[700]),
                      textAlign: TextAlign.center),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar dados 😔",
                        style:
                            TextStyle(fontSize: 30.0, color: Colors.amber[700]),
                        textAlign: TextAlign.center),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 180, color: Colors.amber[700]),
                          Divider(),
                          buildTextField(
                              "Real", "RS \$", realController, _realChanged),
                          Divider(),
                          buildTextField("Dólar", "US \$ ", dolarController,
                              _dolarChanged),
                          Divider(),
                          buildTextField(
                              "Euro", "€ ", euroController, _euroChanged)
                        ],
                      ));
                }
            }
          }),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber[700]),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber[700], fontSize: 25),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
