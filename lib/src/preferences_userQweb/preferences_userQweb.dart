import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUserqweb {
  static final PreferenceUserqweb _instancia =
      new PreferenceUserqweb._internal();

  factory PreferenceUserqweb() {
    return _instancia;
  }

  PreferenceUserqweb._internal();

  //WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET del nombre
  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
