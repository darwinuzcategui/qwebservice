import 'dart:async';
import 'package:qwebdoc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _userNameQwebController = BehaviorSubject<String>();
  final _passwordQwebController = BehaviorSubject<String>();

  final _httpQwebController = BehaviorSubject<String>();
  final _puertoQwebController = BehaviorSubject<String>();

  // Recuperar los datos del Stream o flujo de informacion
  Stream<String> get userNameQwebStream =>
      _userNameQwebController.stream.transform(validateUsername);
  Stream<String> get passwordQwebStream =>
      _passwordQwebController.stream.transform(validatePassword);

  Stream<String> get httpQwebStream =>
      _httpQwebController.stream.transform(validateHttp);

  Stream<String> get puertoQwebStream =>
      _puertoQwebController.stream.transform(validatePuerto);

  Stream<bool> get formValidStream => Rx.combineLatest2(
      userNameQwebStream, passwordQwebStream, (dynamic a, dynamic b) => true);

  Stream<bool> get formValidStream1 => Rx.combineLatest2(
      httpQwebStream, puertoQwebStream, (dynamic a, dynamic b) => true);

  // Inserto Valor al Stream
  // getter
  Function(String) get changeUserNameQweb => _userNameQwebController.sink.add;
  Function(String) get changePasswordQweb => _passwordQwebController.sink.add;
  Function(String) get changeHttpQweb => _httpQwebController.sink.add;
  Function(String) get changePuertoQweb => _puertoQwebController.sink.add;

  // obtener el ultimo valor ingresado a los streams

  String get userNameQweb => _userNameQwebController.value;
  String get passwordQwb => _passwordQwebController.value;
  String get httpQwb => _httpQwebController.value;
  String get puertoQwb => _puertoQwebController.value;

  dispose() {
    _userNameQwebController.close();
    _passwordQwebController.close();
    _httpQwebController.close();
    _puertoQwebController.close();
  }
}
