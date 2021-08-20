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
    this.extensionArchivo,
    this.comentario,
    this.palabraClave,
    required this.archivo,
    // this.archivo,
  });

  String? nombreArchivo = '';
  String? emailUsuarioRecibe = 'darwin.uzcategui1973@gmail.com';
  String? extensionArchivo;
  String? comentario = "";
  String? palabraClave = "";
  List<int> archivo;

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        nombreArchivo: json["nombreArchivo"],
        emailUsuarioRecibe: json["emailUsuarioRecibe"],
        extensionArchivo: json["extensionArchivo"],
        comentario: json["comentario"],
        palabraClave: json["palabraClave"],
        archivo: List<int>.from(json["archivo"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nombreArchivo": nombreArchivo,
        "emailUsuarioRecibe": emailUsuarioRecibe,
        "extensionArchivo": extensionArchivo,
        "comentario": comentario,
        "palabraClave": palabraClave,
        "archivo": List<dynamic>.from(archivo.map((x) => x)),
      };
}
