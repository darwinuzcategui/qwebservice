import 'package:flutter/material.dart';
import 'package:qwebdoc/src/bloc/provider.dart';
import 'package:qwebdoc/src/pages/home_page.dart';
import 'package:qwebdoc/src/pages/login_page.dart';
import 'package:qwebdoc/src/pages/document_page.dart';
import 'package:qwebdoc/src/pages/registro_pag.dart';
import 'src/preferences_userQweb/preferences_userQweb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenceUserqweb();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenceUserqweb();
    //print("***** en clase My app*** ");
    print(prefs.token);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qweb Service App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'document': (BuildContext context) => DocumentPage(),
          'cuenta': (BuildContext context) => RegistroPage(),
        },
        theme: ThemeData(primaryColor: Color.fromARGB(255, 119, 172, 243)),
        //theme: ThemeData(primaryColor: Colors.green.shade300),
       
      ),
    );
  }
}

/*
  //#0455BF azul
  //#0476D9 azul mas calro
  //#024873 azul mas oscuro
  //#79C4F2 verde
*/