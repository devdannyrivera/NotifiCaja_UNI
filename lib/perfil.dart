import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PerfilPage extends StatelessWidget {
  final Datos datos;
  PerfilPage({Key key, @required this.datos}) : super(key:key);

  _removeValue() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        await prefs.remove('id_estudiante');
        await prefs.remove('pr_nom');
        await prefs.remove('sg_nom');
        await prefs.remove('pr_apell');
        await prefs.remove('sg_apell');
        await prefs.remove('carnet');
        await prefs.remove('carrera');
        await prefs.remove('email');
}
  Widget fotoperfil(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
      height: 130,
      width: 130,
      child: Image.asset('assets/images/profile.png'),
    )
      );
  }
  Widget franjaUniyNom() {
    return Container(color: Colors.lightBlue,
    height: 100, 
        child: Align(alignment: Alignment.center,
        child: Column(children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Text("Universidad Nacional de Ingenieria", style: TextStyle(color:  Colors.white, fontSize: 22),),),
          Text(datos.pnombre + " " + datos.snombre + " " + datos.papellido + " " + datos.sapellido , style: TextStyle(color: Colors.white, fontSize: 18),)
        ],)
    ));
  }
  Widget encabezadoinfo(){
        return Padding(padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text('Informacion personal', style: TextStyle(color: Colors.white, fontSize: 20,),textAlign: TextAlign.center,));
      }
  Widget bodyinfo(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Column(children: <Widget>[
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
            Text('Carnet: '+ datos.carnet, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.left,)
          ),
      ),
      Align(alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('Carrera: '+ datos.carrera, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.left)
        ),),
      Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('Correo: '+ datos.email, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.left)
        ))
    ],));
  }
   Widget logoutButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 80),
      child: ButtonTheme(
        minWidth: 180.0,
        height: 45.0,
         child: RaisedButton(
          onPressed: (
          ) {
            _removeValue();
           Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text("Cerrar sesion", style: TextStyle(color: Colors.white, fontSize: 18),),
          shape: StadiumBorder(),
      )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            decoration: BoxDecoration(
               image: DecorationImage(
                     image: AssetImage("assets/images/backnoti.png"),
                     fit: BoxFit.cover
                   )
               ),
            padding: const EdgeInsets.only(top: 20),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
              children: <Widget>[
                fotoperfil(),
                franjaUniyNom(),
                encabezadoinfo(),
                bodyinfo(),
                logoutButton(context),
                    ],)
                  )));
  }
}