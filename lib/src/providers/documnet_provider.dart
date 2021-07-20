import 'dart:convert';

//import 'package:flutter/widgets.dart';
import 'package:qwebdoc/src/models/document_model.dart';
import 'package:http/http.dart' as http;
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';

class DocumnetProvider {
  //final String _url = 'http://192.168.0.6:8080';
  final String _url = 'http://70.36.114.168:8095';
  var prefs = new PreferenceUserqweb();
  String get _qwebToken => prefs.token;

  Future<Map<String, dynamic>> crearDocument(DocumentModel document) async {
    final url = '$_url/qweb/recibirDocumentoExternosWS.do';
    String? nombreArchivoConExtesion = document.nombreArchivo!.trim() +
        "." +
        document.extensionArchivo!.trim();

    print(nombreArchivoConExtesion);

    final documenJson = {
      'nombreArchivo': nombreArchivoConExtesion,
      'emailUsuarioRecibe': document.emailUsuarioRecibe,
      'archivo': document.archivo
    };
    var client = http.Client();

    try {
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': _qwebToken,
          },
          body: json.encode(documenJson));
      if (resp.statusCode == 200) {
        //final resp = await http.post(url, body: documentModelToJson(document));
        print(documentModelToJson(document));
        print("*************************");
        print(json.encode(documenJson));
        final decodedData = json.decode(resp.body);
        print(decodedData);

        return {'ok': true, 'mensaje': "todo paso ok"};
      } else {
        print(resp.statusCode);
        print("Error en Peticion");
        return {
          'ok': false,
          'mensaje':
              'Error en peticion, Email no Registrado/Token No Valido /Datos Faltante '
        };
      }
    } catch (e) {
      print(e);
      return {'ok': false, 'mensaje': e.toString()};
    } finally {
      client.close();
    }
  }
}
