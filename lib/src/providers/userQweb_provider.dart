import 'dart:convert';
import 'package:flutter/widgets.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';

class UserQwebProvider extends ChangeNotifier {
  //final String _qwebToken = '38-251-236-49-55-138-50-213';
  //final storage = new FlutterSecureStorage();
  var prefs = new PreferenceUserqweb();
  String get _qwebToken => prefs.token; //'4-223-55-37-16-49-41-176';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ignore: missing_return

  Future<Map<String, dynamic>> userQweb(String usuario, String password) async {
    final authData = {'usuario': usuario, 'clave': password};
    final String _url = prefs.urlbase; //'http://192.168.1.108:8080';

    var client = http.Client();
    // rutas servidores
    //http://70.36.114.168:8095/
    //http://192.168.0.6:8080/

    try {
      final resp = await http.post(Uri.parse('$_url/qweb/obtenerUsuarioWS.do'),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': _qwebToken,
          },
          body: json.encode(authData));

      if (resp.statusCode == 200) {
        _isLoading = true;
        Map<String, dynamic> decodedResp = json.decode(resp.body);
        print(decodedResp);

        if (decodedResp.containsKey('token') ||
            decodedResp.containsKey('nombres') ||
            decodedResp.containsKey('Apellidos')) {
          prefs.token = decodedResp['token'].toString();
          prefs.nombre = decodedResp['nombres'].toString() +
              " " +
              decodedResp['Apellidos'].toString();

          // grabar un token seguro
          //await storage.write(
          //  key: 'token', value: decodedResp['token'].toString());
          return {'ok': true, 'mensaje': decodedResp['token']};
        } else {
          return {'ok': false, 'mensaje': 'Error en Token  '};
        }
      } else {
        print(resp.statusCode);
        print("Error en Peticion");
        return {'ok': false, 'mensaje': 'Error en peticion  Username/Password'};
      }
    } catch (e) {
      print(e);
      return {'ok': false, 'mensaje': e.toString()};
      //print(e);
    } finally {
      client.close();
    }
  }

  void logout() {
    prefs.token = "";
    prefs.mensaje = "";
    return;
  }
}
