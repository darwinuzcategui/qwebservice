import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qwebdoc/src/bloc/provider.dart';
import 'package:qwebdoc/src/providers/userQweb_provider.dart';
import 'package:qwebdoc/src/utilis/utilis.dart';

class LoginPage extends StatelessWidget {
  final userQwebProvider = new UserQwebProvider();
  //const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackgroundQweb(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 190.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 15.0),
                _createUser(bloc),
                SizedBox(height: 15.0),
                _createPassword(bloc),
                SizedBox(height: 15.0),
                _createButton(bloc),
              ],
            ),
          ),
          TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'cuenta'),
              child: Text('Cambiar de Conexion Qweb')),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _createUser(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.userNameQwebStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,

            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
                icon: Icon(Icons.supervised_user_circle, color: Colors.blue),
                hintText: 'Usuario Qweb',
                labelText: 'USER',
                counterText: snapshot.data,
                errorText: snapshot.error as String?),
            //onChanged: (value) => bloc.changeUserNameQweb(value),
            onChanged: bloc.changeUserNameQweb,
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordQwebStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.blue),
                labelText: 'Password',
                //counterText: snapshot.data,
                errorText: snapshot.error as String?),
            onChanged: bloc.changePasswordQweb,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color.fromRGBO(121, 162, 198, 1.0),
      // backgroundColor: Color.fromRGBO(92, 224, 132, 1.0),
      elevation: 0.0,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextButton(
          style: flatButtonStyle,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
          child: Text("Ingresar"),
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info =
        await userQwebProvider.userQweb(bloc.userNameQweb, bloc.passwordQwb);

    if (info["ok"]) {
      //showAlertQweb(context, info["mensaje"]);
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlertQweb(context, info["mensaje"]);
    }
  }

  Widget _createBackgroundQweb(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backgroundQweb = Container(
      height: size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(92, 224, 132, 1.0),
        Color.fromRGBO(121, 162, 198, 1.0)
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        backgroundQweb,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.dashboard_customize, color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('QwebApp',
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ],
          ),
        )
      ],
    );
  }
}
