import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:notificaja_uni/classes/controladores.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
String _value;

class _RegisterPageState extends State<RegisterPage> {

final nombres = TextEditingController();final apellidos = TextEditingController();final carnet = TextEditingController();
String numcarrera;final correo = TextEditingController();final clave = TextEditingController();final repetirClave = TextEditingController();
Future registrar(String prnom, String sgnom, String prapell, String sgapell, String carnet, String carrera, String correo, String clave, BuildContext context) async {
  var url = 'https://exasperate-load.000webhostapp.com/registro.php';
  http.Response response = await http.post(url, body: {
    "pr_nombre": prnom,
    "sg_nombre": sgnom,
    "pr_apell": prapell,
    "sg_apell": sgapell,
    "carnet": carnet,
    "id_carrera": carrera,
    "mail": correo,
    "pw": clave
  });
    var data = jsonDecode(response.body);
    print(data);
    if(data['success'] == true){
      
    } else{
      Controladores().mostrarDialogo(context, 'Este perfil ya existe', 'Solicitud de Registro', 'Cerrar');  
    }
}
void validarDatos(String nombres, apellidos, carnet, _value, email, clave1, clave2){
  String msg = "";
  if(nombres == "" || apellidos == "" || carnet == "" || _value==null || email == "" || clave1 == "" || clave2 == ""){
    if (nombres == ""){
      
      msg += "Nombres\n";
    }
    if (apellidos == ""){
      
      msg += "Apellidos\n"; 
    }
    if (carnet == ""){
      msg += "Carnet\n";
    }
    if (_value == null){
      
      msg += "Carrera\n";
    }
    if (email == ""){
      
      msg += "Email\n"; 
    }
    if (clave1 == "" || clave2 == ""){
      msg += "Contraseña\n";
    }
    Controladores().mostrarDialogo(context,  msg,"Los siguientes campos no pueden estar vacios", 'Cerrar');
  }
  else
  {
    int counter = 0;

    if(RegExp(r"^([a-zA-Z]{3})").hasMatch(nombres)== false || RegExp(r"^([a-zA-Z]{3})").hasMatch(apellidos)== false){
      counter +=1;
      Controladores().mostrarDialogo(context, "Nombre Invalido", "Validacion de Nombre", 'Cerrar');
    }
    if(RegExp(r"^([0-9]{4})+-([0-9]{4})+([A-Z]{1})+$").hasMatch(carnet) == false){
      counter += 1;
      Controladores().mostrarDialogo(context, "Carnet Invalido", "Validacion de Carnet", 'Cerrar');
    }
    if(RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.([a-zA-Z]{3})+$").hasMatch(email) == false){
      counter += 1;
      Controladores().mostrarDialogo(context, "El correo no tiene un formato valido","Validacion de correo electronico", 'Cerrar');
    }
    if(RegExp(r"^[a-zA-Z0-9.]{6}").hasMatch(clave1) == false){
      counter += 1;
      Controladores().mostrarDialogo(context, "La clave es muy poco segura","Seguridad de clave", 'Cerrar');
    }
    if(clave1 != clave2){
      counter += 1;
      Controladores().mostrarDialogo(context, "Las contraseñas no coinciden", "Validacion de Contraseña", 'Cerrar');
    }
    if(counter == 0) {
      String prnom,sgnom, prapell, sgapell;
      var x = [];
      var y = [];
      x = nombres.split(' ');
      if(x.length == 2){
        prnom = x[0];
        sgnom	= x[1];
      }else{
        prnom = x[0];
        sgnom = "";
      }  
      y = apellidos.split(' ');
      if(y.length == 2){
        prapell = y[0];
        sgapell	= y[1];
      }else{
        prapell = y[0];
        sgapell = "";
      }  
      registrar(prnom, sgnom, prapell, sgapell, carnet, _value, email, clave1, context);
    }
  }
}
Widget selectCarrera(){
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only( right: 8),
              child: Image.asset('assets/images/diploma.png',
              width: 25, fit: BoxFit.fitWidth),
        ),
        Expanded(
          child: Row(
        children: <Widget>[
          Expanded(
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
          ),border: Border.all(color: Colors.white, style: BorderStyle.solid)),
        height: 45,
        child: DropdownButton<String>(hint: Text("  Selecciona una Carrera", style: TextStyle(color: Colors.white, fontSize: 16),), style: TextStyle(color: Colors.white, fontSize: 16),
        items: [
          DropdownMenuItem(
            value: "1",
            child: Text(
              "  Ingenieria en Sistemas",
            ), 
          ),
          DropdownMenuItem(
            value: "2",
            child: Text(
              "  Ingenieria Industrial",
            ),
          ),
          DropdownMenuItem(
            value: "3",
            child: Text(
              "  Ingenieria Civil",
            )
          ),
           DropdownMenuItem(
            value: "4",
            child: Text(
              "  Ingenieria Agroindustrial",
            )
          )
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
        
      )
        
      )
          )
          
        ],
      )
        )
      ],)
    );
  } 
  Widget submitButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 80),
      child: ButtonTheme(
        minWidth: 180.0,
        height: 45.0,
         child: RaisedButton(
          onPressed: (
          ) {
            validarDatos(nombres.text, apellidos.text, carnet.text, _value , correo.text, clave.text, repetirClave.text);
          },
          child: Text("Registrarse", style: TextStyle(color: Colors.white, fontSize: 18),),
          shape: StadiumBorder(),
      )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backnoti.png"),
                fit: BoxFit.cover,
                ),
            ),
      child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
            padding: const EdgeInsets.only(top: 50), 
            children: <Widget>[             
              Controladores().formInput(nombres,'assets/images/img_user.png','Nombres',false),
              Controladores().formInput(apellidos,'assets/images/img_user.png','Apellidos',false),
              Controladores().formInput(carnet,'assets/images/img_register.png','Num Carnet',false),
              selectCarrera(),
              Controladores().formInput(correo,'assets/images/img_email.png'
              ,'Correo Electronico',false),
              Controladores().formInput(clave,'assets/images/password.png','Contraseña',true),
              Controladores().formInput(repetirClave,'assets/images/password.png','Repetir Contraseña',true),
              submitButton(),
            ])
      ),
    );
  }
}