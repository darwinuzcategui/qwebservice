import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class UserQwebProvider {
  //final String _qwebToken = '38-251-236-49-55-138-50-213';
  var prefs = new PreferenceUserqweb();
  final String _qwebToken = '38-251-236-49-55-138-50-213';

  // ignore: missing_return

  Future<Map<String, dynamic>> userQweb(String usuario, String password) async {
    final authData = {'usuario': usuario, 'clave': password};

    var client = http.Client();
    // rutas servidores
    //http://70.36.114.168:8095/
    //http://192.168.1.108:8080/

    try {
      final resp = await http.post(
          Uri.parse('http://70.36.114.168:8095/qweb/obtenerUsuarioWS.do'),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': _qwebToken,
          },
          body: json.encode(authData));

      if (resp.statusCode == 200) {
        Map<String, dynamic> decodedResp = json.decode(resp.body);
        print(decodedResp);

        if (decodedResp.containsKey('token') ||
            decodedResp.containsKey('nombres') ||
            decodedResp.containsKey('Apellidos')) {
          prefs.token = decodedResp['token'].toString();
          prefs.nombre = decodedResp['nombres'].toString() +
              " " +
              decodedResp['Apellidos'].toString();
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
}
