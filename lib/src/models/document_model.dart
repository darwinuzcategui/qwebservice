// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) =>
    DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
  DocumentModel({
    this.nombreArchivo,
    this.emailUsuarioRecibe,
   // this.archivo,
  });

  String nombreArchivo = '';
  String emailUsuarioRecibe = 'darwin.uzcategui1973@gmail.com';
 // List<int> archivo;

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        nombreArchivo: json["nombreArchivo"],
        emailUsuarioRecibe: json["emailUsuarioRecibe"],
  //      archivo: List<int>.from(json["archivo"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nombreArchivo": nombreArchivo,
        "emailUsuarioRecibe": emailUsuarioRecibe,
    //    "archivo": List<dynamic>.from(archivo.map((x) => x)),
      };
}
