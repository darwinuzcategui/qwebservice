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
  //final ImagePicker? imagePicker;

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
                _createEmailUserWhoRecibeDocument(),
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
      initialValue: document.nombreArchivo,
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
      print('Paso Ok');

      print(document.nombreArchivo);
      print(document.emailUsuarioRecibe);
      print(document.archivo);
      print(document.extensionArchivo);
      if (document.extensionArchivo == null) {
        utils.showAlertQweb(context, "Falta carga archivo");
        print("cargue archivo");

        setState(() {});
      }
      if (document.extensionArchivo != null) {
        //FocusScope.of(context).unfocus();
        Map info = await documnetProvider.crearDocument(document);
        //await userQwebProvider.userQweb(bloc.userNameQweb, bloc.passwordQwb);

        if (info["ok"]) {
          utils.showAlertQweb(context, "Todo OK excelente");
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
        image: AssetImage('assets/' + document.extensionArchivo! + '.png'),
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
    print("entro aqui************************");
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
        'ods'
      ],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      Uint8List? fileBytes = file.bytes;
      String? fileExtension = file.extension;
      document.archivo = fileBytes!;
      document.extensionArchivo = fileExtension;

      //print(file.name);
      print(fileBytes);
      //print(document.archivo);
      //  print(file.bytes);
//      print(file.size);
      print(fileExtension);
      print(file.name);
      // print(file.bytes);
      print(file.size);
      //print(file.extension);
      print(file.path);
      //    print(file.path);
    } else {
      // User canceled the picker
    }

    setState(() {});
  }
}



/*
 return ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.save_alt),
        label: Text('Guardar'));
*/
/*
class DocumentPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  // const DocumentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Service'),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: Icon(Icons.document_scanner_sharp)),
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _createNameFile(),
                _createEmailUserWhoRecibeDocument(),
                _createButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createNameFile() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre Documento'),
      validator: (value) {
        if (value.length < 2) {
          return 'Ingrese el nombre del Documento';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createEmailUserWhoRecibeDocument() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: 'Email Usuario que recibe Documento'),
      validator: (value) {
        if (utils.isEmailQweb(value)) {
          return null;
        } else {
          return 'Debe ser un Email Valido!';
        }
      },
    );
  }

  Widget _createButton() {
    return ElevatedButton.icon(
      icon: Icon(
        Icons.save_alt,
        color: Colors.black45,
        size: 24.0,
      ),
      label: Text('Guardar'),
      onPressed: () {
        _submit();
        print('Pressed');
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.green.shade300,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          shadowColor: Colors.amberAccent),
    );
  }

  void _submit() {
    formKey.currentState.validate();
  }
}




*/
