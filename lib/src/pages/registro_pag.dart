import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qwebdoc/src/bloc/provider.dart';
import 'package:qwebdoc/src/preferences_userQweb/preferences_userQweb.dart';
import 'package:qwebdoc/src/providers/userQweb_provider.dart';
import 'package:qwebdoc/src/utilis/utilis.dart' as util;

class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final userQwebProvider = new UserQwebProvider();

  var prefs = new PreferenceUserqweb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
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
                Text('Conexion Qweb', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                _crearHttp(bloc),
                SizedBox(height: 10.0),
                _crearPuerto(bloc),
                SizedBox(height: 15.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: Text('Ya tienes una Conexion registrada ?')),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearHttp(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.httpQwebStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
                icon: Icon(Icons.http, color: Colors.blue),
                hintText: 'Ejm http://192.168.1.108',
                labelText: 'Ruta de Qweb ',
                counterText: snapshot.data,
                errorText: snapshot.error as String?),
            //onChanged:(value)=>bloc.changeUserNameQweb(value),
            onChanged: bloc.changeHttpQweb,
          ),
        );
      },
    );
  }

  Widget _crearPuerto(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.puertoQwebStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(Icons.pin_outlined, color: Colors.blue),
                hintText: 'Ejm 8080',
                labelText: 'Puerto Qweb',
                counterText: snapshot.data,
                errorText: snapshot.error as String?),
            onChanged: bloc.changePuertoQweb,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
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
      stream: bloc.formValidStream1,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextButton(
          style: flatButtonStyle,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
          child: Text("Crear"),
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    print('===========================');
    print('http: ${bloc.httpQwb} ');
    print('Puerto: ${bloc.puertoQwb} ');
    print('===========================');
    prefs.urlbase = '${bloc.httpQwb}:${bloc.puertoQwb}';
    print(prefs.urlbase);

    //final info = await .nuevoUsuario(bloc.email, bloc.clave);

    // ignore: unnecessary_null_comparison
    if (bloc.httpQwb == null) {
      util.showAlertQweb(context, "no Puede ser nula o vacia ruta");
    } else {
      //final info = "ok";
      Navigator.pushReplacementNamed(context, 'login');
    }

/*
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'inicio');
    } else {
      util.showAlertQweb(context, info['mensaje']);
    }
*/
    // Navigator.pushReplacementNamed(context, 'inicio');
  }

  Widget _crearFondo(BuildContext context) {
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
