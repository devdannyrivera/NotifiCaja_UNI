import 'package:flutter/material.dart';
class Controladores{
  Widget formInput(TextEditingController controller, final ruta,  String hint, bool){ 
      return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(children: <Widget>[
         Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 8),
                child: Image.asset(ruta,
                width: 25, fit: BoxFit.fitWidth),
        ),    
        Expanded(
        child: Container(
        height: 45,
        child: TextFormField(controller: controller, obscureText: bool, 
        decoration: InputDecoration(hintText: hint,hintStyle: TextStyle(fontSize: 16,color: Colors.white),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0) ,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.0) ,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0))),
        ),
     style: TextStyle(color:Colors.white),
    )
    )
      )
    ],)
    );
  }
  Widget formInputLogin(String desc, TextEditingController controller, bool) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(desc,
                        style: TextStyle(color: Colors.white, fontSize: 14))
                  ],
                )),
            Container(
              height: 45,
              child: TextFormField(
                controller: controller,
                obscureText: bool,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
  void mostrarDialogo(BuildContext context, String mensaje, tema, textoBoton){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: new Text(tema),
        content: new Text(mensaje),
        actions: <Widget>[
          new FlatButton(
            child: new Text(textoBoton),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
}
