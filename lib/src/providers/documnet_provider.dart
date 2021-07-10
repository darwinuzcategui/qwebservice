import 'dart:convert';

import 'package:qwebdoc/src/models/document_model.dart';
import 'package:http/http.dart' as http;

class DocumnetProvider {
  //final String _url = 'http://192.168.0.5:8080';
  final String _url = 'http://70.36.114.168:8095';
  final String _qwebToken = '196-167-25-199-213-127-87-229';

  Future<bool> crearDocument(DocumentModel document) async {
    final url = '$_url/qweb/recibirDocumentoExternosWS.do';
    final pruebajson = {
      'nombreArchivo': document.nombreArchivo,
      'emailUsuarioRecibe': document.emailUsuarioRecibe,
      'archivo': [100, 97, 114, 119, 105, 110]
    };
    final resp = await http.post(url,
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
