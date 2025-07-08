import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
    case 201:
      onSuccess();
      break;
    case 400:
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bad Request: ${response.body}')));
      break;
    case 401:
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unauthorized: ${response.body}')));
      break;
    case 403:
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Forbidden: ${response.body}')));
      break;
    case 404:
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Not Found: ${response.body}')));
      break;
    case 500:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Internal Server Error: ${response.body}')),
      );
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected Error: ${response.body}')),
      );
  }
}
