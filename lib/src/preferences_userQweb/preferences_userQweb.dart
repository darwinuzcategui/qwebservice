import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUserqweb {
  static final PreferenceUserqweb _instancia =
      new PreferenceUserqweb._internal();

  factory PreferenceUserqweb() {
    return _instancia;
  }

  PreferenceUserqweb._internal();

  //WidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  String get token {
    return _prefs.getString('token') ?? '';
    //return _prefs.getString('token') ;
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET del nombre
  String get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  // GET y SET del urlBase
  String get urlbase {
    return _prefs.getString('urlbase') ?? 'http://70.36.114.168:8095';
  }

  set urlbase(String value) {
    _prefs.setString('urlbase', value);
  }
}
