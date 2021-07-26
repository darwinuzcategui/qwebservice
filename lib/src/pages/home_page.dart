import 'package:flutter/material.dart';
import 'package:qwebdoc/src/bloc/provider.dart';
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';
//import 'package:qwebdoc/src/providers/userQweb_provider.dart';
//

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    // final userQwebProvider =
    //    Provider.of<UserQwebProvider>(context, listen: false);
    //final userQwebProvider = Provider.of<UserQwebProvider>(listen: false);

    //final authService = Provider.of<AuthService>(context, listen: false);

    final prefs = new PreferenceUserqweb();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            // userQwebProvider.logout();
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
          Text('Token  : ${prefs.token}')
        ],
      ),
      floatingActionButton: _createButton(context),
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.green.shade300,
      onPressed: () => Navigator.pushNamed(context, 'document'),
    );
  }
}
