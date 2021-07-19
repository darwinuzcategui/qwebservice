import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:qwebdoc/src/models/document_model.dart';
import 'package:http/http.dart' as http;
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';

class DocumnetProvider extends ChangeNotifier {
  final String _url = 'http://192.168.0.6:8080';
  //final String _url = 'http://70.36.114.168:8095';
  var prefs = new PreferenceUserqweb();
  String get _qwebToken => prefs.token;

  Future<bool> crearDocument(DocumentModel document) async {
    final url = '$_url/qweb/recibirDocumentoExternosWS.do';
    final pruebajson = {
      'nombreArchivo': document.nombreArchivo,
      'emailUsuarioRecibe': document.emailUsuarioRecibe,
      'archivo': document.archivo
    };
    print("***********************");
    print(_qwebToken);
    print("***********************");
    // Uri.parse('http://70.
    final resp = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': _qwebToken,
        },
        //body: documentModelToJson(document));

        body: json.encode(pruebajson));
    //final resp = await http.post(url, body: documentModelToJson(document));
    print(documentModelToJson(document));
    print("*************************");
    print(json.encode(pruebajson));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }
}
