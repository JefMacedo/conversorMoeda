import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

const Request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=670d81ad";

void main() async {
  http.Response response = await http.get(Request);
  print(response.body);

  runApp(MaterialApp(home: Container()));
}
