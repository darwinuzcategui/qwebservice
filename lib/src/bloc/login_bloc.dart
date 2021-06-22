import 'dart:async';
import 'package:qwebdoc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  //final _userNameQwebController = StreamController<String>.broadcast();
  final _userNameQwebController = BehaviorSubject<String>();
  // final _passwordQwebController = StreamController<String>.broadcast();
  final _passwordQwebController = BehaviorSubject<String>();
  //final _tokenQwebController = BehaviorSubject<String>();

  // Recuperar los datos del Stream o flujo de informacion
  Stream<String> get userNameQwebStream =>
      _userNameQwebController.stream.transform(validateUsername);
  Stream<String> get passwordQwebStream =>
      _passwordQwebController.stream.transform(validatePassword);
  // Stream<String> get tokenQwebStream => _tokenQwebController.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(userNameQwebStream, passwordQwebStream, (a, b) => true);

  // Inserto Valor al Stream
  // getter
  Function(String) get changeUserNameQweb => _userNameQwebController.sink.add;
  Function(String) get changePasswordQweb => _passwordQwebController.sink.add;
  // Function(String) get changetokenQweb => _tokenQwebController.sink.add;

  // obtener el ultimo valor ingresado a los streams

  String get userNameQweb => _userNameQwebController.value;
  String get passwordQwb => _passwordQwebController.value;
  //String get tokenQwb => _tokenQwebController.value;

  dispose() {
    _userNameQwebController?.close();
    _passwordQwebController?.close();
    //_tokenQwebController?.close();
  }
}
