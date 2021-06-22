import 'package:flutter/material.dart';
import 'package:qwebdoc/src/bloc/provider.dart';
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';
//import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final prefs = new PreferenceUserqweb();

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('UserQweb : ${bloc.userNameQweb}'),
          Divider(),
          Text('Nombre : ${prefs.nombre}'),
          Divider(),
          Text('Token  : ${prefs.token}')
        ],
      ),
    );
  }
}
