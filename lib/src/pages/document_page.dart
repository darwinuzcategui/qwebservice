//import 'dart:async';
//import 'dart:io';

//import 'dart:js';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:qwebdoc/src/models/document_model.dart';
import 'package:qwebdoc/src/providers/documnet_provider.dart';
import 'package:qwebdoc/src/utilis/utilis.dart' as utils;
// import 'package:rxdart/streams.dart';

class DocumentPage extends StatefulWidget {
  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final formKey = GlobalKey<FormState>();
  final documnetProvider = new DocumnetProvider();
  final nombreArchivoControler = TextEditingController();
  String nombreArchivo = "debe colocar un nombre archivo valido.sin extension";
  //nombreArchivoControler.text= nombreArchivo;

  DocumentModel document = new DocumentModel(archivo: []);

  // File? docuFile;

  _DocumentPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Service'),
        actions: <Widget>[
          IconButton(
              onPressed: _selectDocument, icon: Icon(Icons.document_scanner)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarDocuments(),
                _createNameFile(),
                _createComentario(),
                _createEmailUserWhoRecibeDocument(),
                SizedBox(width: 15.0, height: 15.0),
                _createButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createNameFile() {
    return TextFormField(
      controller: nombreArchivoControler,
      //initialValue: document.nombreArchivo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre Documento'),
      onSaved: (value) => document.nombreArchivo = value,
      validator: (value) {
        if (utils.isNombreArchivoSinExtesion(value!)) {
          return null;
        } else {
          return 'No debe tener caractres especiales y sin la Extesion';
        }
      },
    );
  }

  Widget _createEmailUserWhoRecibeDocument() {
    return TextFormField(
      initialValue: document.emailUsuarioRecibe,
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: 'Email Usuario que recibe Documento'),
      onSaved: (value) => document.emailUsuarioRecibe = value,
      validator: (value) {
        if (utils.isEmailQweb(value!)) {
          return null;
        } else {
          return 'Debe ser un Email Valido!';
        }
      },
    );
  }

  Widget _createButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        Icons.save_alt,
        color: Colors.black45,
        size: 24.0,
      ),
      label: Text('Guardar'),
      //snapshot.hasData ? () => _login(bloc, context) : null,
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
          primary: Colors.green.shade300,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          shadowColor: Colors.amberAccent),
    );
  }

  _submit() async {
    if (!formKey.currentState!.validate()) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (document.extensionArchivo == null) {
        utils.showAlertQweb(context, "Falta cargar el archivo!");
        print("Falta cargar el archivo!");

        setState(() {});
      }
      if (document.extensionArchivo != null) {
        //FocusScope.of(context).unfocus();
        Map info = await documnetProvider.crearDocument(document);
        //await userQwebProvider.userQweb(bloc.userNameQweb, bloc.passwordQwb);

        if (info["ok"]) {
          utils.showAlertQweb(context, "Todo OK Excelente");
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          utils.showAlertQweb(context, info["mensaje"]);
        }
      }

      // documnetProvider.crearDocument(document);
    }
  }

  Widget _mostrarDocuments() {
    if (document.extensionArchivo != null) {
      // ignore: todo
      //TODO: voy hacer esto luego
      //return Container();
      return Image(
        //Constants.ASSETS_IMAGES + "logo.png", "logo.png",
        image: AssetImage(
            'assets/' + document.extensionArchivo!.toLowerCase() + '.png'),
        height: 250.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/no-document.png'),
        height: 250.0,
        fit: BoxFit.cover,
      );
    }
  }

  _selectDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: [
        'docx',
        'doc',
        'xls',
        'xlsx',
        'pdf',
        'txt',
        'odt',
        'ods',
        'png',
        'jpg',
        'jpeg'
      ],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      Uint8List? fileBytes = file.bytes;
      String? fileExtension = file.extension;
      String nombreArchivo = file.name;
      nombreArchivo = nombreArchivo.split(".")[0];
      document.archivo = fileBytes!;
      document.extensionArchivo = fileExtension;
      nombreArchivoControler.text = nombreArchivo;
    } else {
      // User canceled the picker
    }

    setState(() {});
  }

  Widget _createComentario() {
    return TextFormField(
      initialValue: document.comentario,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(labelText: 'Comentario del Archivo Enviado'),
      onSaved: (value) => document.comentario = value,
      validator: (value) {
        if (utils.isComentario(value!)) {
          return null;
        } else {
          return 'Comentario debe Tener por Lo Menos 5 Caracteres y max 100!';
        }
      },
    );
  }
}
