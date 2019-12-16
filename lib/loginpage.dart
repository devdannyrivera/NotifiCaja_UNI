import 'dart:async';

import 'package:flutter/material.dart';
import 'registerpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pageview.dart';
import 'classes/controladores.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Datos{
  int id;
  String pnombre; String snombre; String papellido; String sapellido; String carnet; String carrera;
  String email;
    Datos({this.id, this.pnombre, this.snombre, this.papellido, this.sapellido, this.carnet, this.carrera, this.email});
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final carnet = TextEditingController();

  final password = TextEditingController();

  bool token = false;

  int id;

  String prnom, sgnom, prapell, sgapell, bcarnet, carrera, email;

  getvalue(BuildContext context) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getBool('token');
      id = prefs.getInt('id_estudiante');
      prnom = prefs.getString('pr_nom');
      sgnom = prefs.getString('sg_nom');
      prapell = prefs.getString('pr_apell');
      sgapell = prefs.getString('sg_apell');
      bcarnet = prefs.getString('carnet');
      carrera = prefs.getString('carrera');
      email = prefs.getString('email');

      if(token ==  true){
        final datos = Datos(id: id, pnombre: prnom, snombre: sgnom, papellido: prapell, sapellido: sgapell, carnet: bcarnet, carrera: carrera, email: email);
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Pageview(datos : datos)));
      }}
  Widget image() {
    return Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 10),
        child: Row(children: <Widget>[
          Image.asset('assets/images/rob.png',
              width: 130, fit: BoxFit.fitWidth)
        ]));
  } 
  Widget logoCarga(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 140),
      child: Column(children: <Widget>[
        Text(
            'NotifiCaja',
            style: TextStyle(fontSize: 45, color: Colors.white),
          ),
        Text('Todos los derechos reservados', style: TextStyle(fontSize: 20, color: Colors.white))  
      ],),
    );
  }
  Widget encabezado() {
    return Row(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 60, left: 10),
          child: Text(
            'NotifiCaja',
            style: TextStyle(fontSize: 35, color: Colors.white),
          ))
    ]);
  }

_saveValue(bool token, int idestudiante, String prnom, sgnom, prapell, sgapell, carnet, carrera, email) async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('token', token);
        await prefs.setInt('id_estudiante', idestudiante);
        await prefs.setString('pr_nom', prnom);
        await prefs.setString('sg_nom', sgnom);
        await prefs.setString('pr_apell', prapell);
        await prefs.setString('sg_apell', sgapell);
        await prefs.setString('carnet', carnet);
        await prefs.setString('carrera', carrera);
        await prefs.setString('email', email);
}

Future getlogin(String carnet, String password, BuildContext context) async {
  var url = 'https://exasperate-load.000webhostapp.com/log-in.php';
  http.Response response = await http.post(url, body: {
    "carnet": carnet,
    "pwd": password
  });
    var data = jsonDecode(response.body);
    print(data.toString());
    if(data['password'] == true){
      _saveValue(true, data['id_estudiante'], data['pr_nom'],data['sg_nom'],data['pr_apell'], data['sg_apell'], data['carnet'], data['carrera'], data['email']);
      final datos = Datos(id: data['id_estudiante'], pnombre: data['pr_nom'], snombre: data['sg_nom'], papellido: data['pr_apell'], sapellido: data['sg_apell'], carnet: data['carnet'], carrera: data['carrera'],email: data['email']);
      Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Pageview( datos : datos,)),
      );   
    } else{
      Controladores().mostrarDialogo(context, 'Carnet o Contraseña incorrecta...', 'Peticion de Acceso', 'Cerrar');
    }
}

  Widget loginButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ButtonTheme(
            minWidth: 180.0,
            height: 45.0,
            child: OutlineButton(
              onPressed: () {
                getlogin(carnet.text, password.text, context);
              },
              child: Text(
                "Entrar",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              borderSide: BorderSide(color: Colors.white),
              shape: StadiumBorder(),
            )));
  }

  Widget renderRecuperacion(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:80,bottom: 7),
        child: Row(children: <Widget>[
          InkWell(
            child: Text('Registrarse',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
          ),
          Expanded(
            child: InkWell(
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.white, fontSize: 17),
                textAlign: TextAlign.right,
              ),
              onTap: () {
              },
            ),
          ),
        ]));
  }
  Timer timer;
  bool showform = false;
  bool showlogo = true;
  _showForm(){
    timer?.cancel();
    setState(() {
      this.showform = true;
    });
    setState(() {
      this.showlogo = false;
    });
  }
  @override
  void initState() {
    getvalue(context);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _showForm());
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/images/backnoti.png"),
                fit: BoxFit.cover,
                ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
            body: ListView(
              children: <Widget>[
                Visibility(
              child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(children: <Widget>[
                  image(),
                  encabezado(),
                ],),
                Controladores().formInputLogin("NUMERO DE CARNET",carnet, false),
                Controladores().formInputLogin("CONTRASEÑA",password, true),
                loginButton(context),
                renderRecuperacion(context)
              ],), visible: showform),
              Visibility(
                child: logoCarga(),
                visible: showlogo,
              )])
    ));
  }
}