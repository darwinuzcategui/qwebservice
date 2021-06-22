import 'dart:async';

class Validators {
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (userNameQweb, sink) {
    Pattern pattern = r'^[a-z0-9_-]{3,15}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(userNameQweb)) {
      sink.add(userNameQweb);
    } else {
      sink.addError('UserName no es Correcto');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (passwordQweb, sink) {
    if (passwordQweb.length >= 6) {
      sink.add(passwordQweb);
    } else {
      sink.addError('Mas de 5 Caracteres Por Favor');
    }
  });
}
