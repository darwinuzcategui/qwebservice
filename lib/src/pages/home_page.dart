import 'package:flutter/material.dart';
import 'package:qwebdoc/src/bloc/provider.dart';
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';
import 'package:qwebdoc/src/providers/userQweb_provider.dart';
//

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final prefs = new PreferenceUserqweb();
    final userQwebProvider = new UserQwebProvider();
    //final user

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 192, 240),
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            userQwebProvider.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('UserQweb : ${bloc.userNameQweb}'),
          Divider(),
          Text('Nombre : ${prefs.nombre}'),
          Divider(),
          Text('${prefs.mensaje}')
        ],
      ),
      floatingActionButton: _createButton(context),
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color.fromARGB(255, 154, 192, 240),
      //backgroundColor: Colors.green.shade300,
      onPressed: () => Navigator.pushNamed(context, 'document'),
    );
  }
}
