import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:notificaja_uni/classes/controladores.dart';
import 'package:notificaja_uni/classes/help.dart';
import 'perfil.dart';
import 'loginpage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class Pageview extends StatefulWidget {
  final Datos datos;
  const Pageview({Key key, @required this.datos}) : super(key:key);
  @override
  _PageviewState createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  final mensaje = TextEditingController();
  String _emailController = "dhrivera2502@gmail.com";
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  _sendEmail() async {
    final String _email = 'mailto:' +
    _emailController + '?subject=' +
    _subjectController.text  + '&body='+
    _bodyController.text + " (enviado desde flutter)";
    try{
      await launch(_email);

    }catch(e){
      print(e.toString());
    }
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int index = 0;
  Timer timer;
  
    final PageController pageController = PageController();
    final Curve _curve = Curves.ease;
    final Duration _duration = Duration(milliseconds: 300);
    _navigateToPage(value){
        pageController.animateToPage(
            value,
            duration: _duration,
            curve: _curve
        );
        setState((){
            index = value;
        });
    }
     String _num = "00";
     String _act = " ";
     String _posc = " ";
     String _total = " ";
     String _resta = " ";
     String _minutos = " ";
     bool _boolean = false;
     bool _boolean2 = false;
     bool _sizebool = true;
     int counter = 1;
  Future agregar(String idestudiante) async {
  var url = 'https://notificaja.000webhostapp.com/flutterApp/cola.php';
  http.Response response = await http.post(url, body: {
    "id_estudiante": idestudiante,
  });
    var data = jsonDecode(response.body);
    print(data.toString());
    if(data['success'] == true){
      setState(() => this._num = data['posicion']);
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) => consultar(widget.datos.id.toString()));
    } else{
      Controladores().mostrarDialogo(context, 'Usted ya tiene una posicion en la fila', 'Registro Cola', 'Cerrar');  
      setState(() => this._num = data['posicion']);
    }
  }
 Future consultar(String idestudiante) async {
  var url = 'https://notificaja.000webhostapp.com/flutterApp/valores.php';
  try{
  http.Response response = await http.post(url, body: {
    "id_estudiante": idestudiante,
  });
    var data = jsonDecode(response.body);
    print(data.toString());
    if(data['success'] == true){
      setState(() => this._act = data['NumActual']);
      setState(() => this._posc = data['NumPer']);
      setState(() => this._num = data['NumPer']);
      setState(() => this._resta = data['Resta'].toString());
      setState(() => this._total = data['Total'].toString());
      setState(() {
        this._minutos = (data['Resta']*3).toString();
      });
      setState(() => this._boolean = true);
      setState(() {
          this._boolean2 = false;
        });
      if(_resta == "2" && counter < 2){
        _showNotification1();
        counter ++;
      }
      else if(_resta == "1" && counter <= 2){
        _showNotification2();
        counter = 3;
        setState(() {
          this._sizebool = false;
        });
      }
      else if(_resta == "0"){
        setState(() {
          this._boolean = false;
        });
        setState(() {
          this._boolean2 = true;
        });
        setState(() {
          this._sizebool = false;
        });
        }
    }
    else{
      setState(() => this._act = data['NumActual']??'');
      setState(() => this._posc = '');
      setState(() => this._num = '00');
      setState(() => this._total = '');
      setState(() => this._minutos = '');
      setState(() => this._resta = '');
      setState(() => this._boolean = false);
      setState(() => this._boolean2 = false);
      setState(() {
        this._sizebool = true;
      });
      timer?.cancel();
      setState(() {
        this.counter = 1;
      });
    }} catch(e){
      print(e.toString());
    }
}
  Widget encabezado(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Align(alignment: Alignment.topCenter,
      child: Text("Toma tu turno", style: TextStyle(color: Colors.white, fontSize: 32)),
    ));
  }
  Widget numactual(){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 70),
    child:Column(
      children: <Widget>[
        Visibility (
          child: Column(children: <Widget>[
            Text(widget.datos.pnombre +' tu numero en fila es el: ' + _posc, style: TextStyle(fontSize: 20, color: Colors.white)),
            Padding(padding: const EdgeInsets.symmetric(vertical: 20),
              child:Text('Esta siendo atendido el numero: ' + _act, style: TextStyle(fontSize: 20, color: Colors.white))),
            Text('Cantidad de personas antes de ti: ' +_resta, style: TextStyle(fontSize: 20, color: Colors.white)),
            Padding(padding: const EdgeInsets.symmetric(vertical: 20),
              child:Text('Cantidad de personas en fila: '+_total, style: TextStyle(fontSize: 20, color: Colors.white))),
            Text('Faltan '+ _minutos + ' minutos aproximadamente', style: TextStyle(fontSize: 20, color: Colors.white)) 
          ],),
        maintainSize: _sizebool, 
        maintainAnimation: true,
        maintainState: true,
        visible: _boolean),
        Visibility(
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 58),
          	child:Column(
            children: <Widget>[
            Text("Ya es tu turno !!!", style: TextStyle(fontSize: 30, color: Colors.white),),
            Padding(padding: const EdgeInsets.only(top: 20),
            child: Text('Gracias por usar Notificaja', style: (TextStyle(fontSize: 20, color: Colors.white)),),)
      ],
    )), maintainSize: false,
    maintainAnimation: true,
    maintainState: true,
    visible: _boolean2 ,
        ),
    ]));
  } 
  Widget scanButton(){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
      child: ButtonTheme(
        minWidth: 180.0,
        height: 45.0,
         child: RaisedButton(
          onPressed: scan,
          child: Text("Scanear el código QR.", style: TextStyle(color: Colors.white, fontSize: 18),),
          shape: StadiumBorder(),
      )
      )
    );
  }
  Widget libreta(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 360,
        width: 320,
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/libreta.png"),
                fit: BoxFit.fitHeight
                ),
            ),
            child: Column(children: <Widget>[
              Expanded(
                child: new Align(
                  alignment: Alignment.center,
                  child: Text(_num, style: TextStyle(fontSize: 100),
                )
              ),
            )],)
    ));
  }
   Widget encabezadoFila(context) {
    return Padding(
      padding: const EdgeInsets.only(top:10, right: 10),
      child: Row(children: <Widget>[
        Expanded(
        child: Column(children: <Widget>[
          Text(
            'Bienvenid@ '+ widget.datos.pnombre.toString(),
            style: TextStyle(fontSize: 24, color: Colors.white)
          ),
            Text('tu estudia nosotros notificamos',style: TextStyle(fontSize: 18, color: Colors.white),textAlign: TextAlign.left,)
          ],),),
          InkWell(
                child: Image.asset('assets/images/profile.png',width: 60, fit: BoxFit.fitWidth),onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilPage(datos: widget.datos)));
              },
              ),
      ],)
    );
  }
  Widget robot() {
    return Padding(padding:  const EdgeInsets.only(),
    child: Align(alignment: Alignment.bottomRight,
    child: Image.asset('assets/images/rob.png',
    width: 110, fit: BoxFit.fitWidth)
    ));
  }
  Widget encabezadoContacto(){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
    child: Row(children: <Widget>[
            Icon(Icons.mail_outline, size: 40, color: Colors.white),
            Text(' Contactanos', style: TextStyle(color: Colors.white, fontSize: 26,),),
          ],),);
  }
  Widget cuerpoMensaje(){
    return Padding(padding: const EdgeInsets.only(top: 50),
    child: Column (children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Container(
            decoration: BoxDecoration(color: Colors.white, border:  Border.fromBorderSide(BorderSide(color: Colors.green, width: 1.0)),borderRadius: BorderRadius.only( topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0))),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
            controller: _subjectController,
          decoration: InputDecoration(hintText: 'Asunto del correo',hintStyle: TextStyle(fontSize: 16),
          ),
          )
          )
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 10),
            child: Container(
            decoration: BoxDecoration(color: Colors.white, border:  Border.fromBorderSide(BorderSide(color: Colors.green, width: 1.0)),borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0))),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child:TextFormField(
              controller: _bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
          decoration: InputDecoration(hintText: 'Cuerpo del correo',hintStyle: TextStyle(fontSize: 16), 
        ),)       
          )
          ))
    ],));
  }
  Widget botonEnviar(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 70),
      child: ButtonTheme(
        minWidth: 180.0,
        height: 45.0,
         child: RaisedButton(
          onPressed:(){
               _sendEmail();
          },
          child: Text("Enviar", style: TextStyle(color: Colors.white, fontSize: 18),),
          shape: StadiumBorder(),
      )
      )
    );
  }
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => consultar(widget.datos.id.toString()));
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, 
        onSelectNotification: onSelectNotification);
        _scheduleNotification();
  }
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage("assets/images/backnoti.png"),
                     fit: BoxFit.cover
                   )
                 ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
      body: PageView(
          controller: pageController,
            onPageChanged: (page){
               setState(() {
                 index = page;
               });
           },
           children: <Widget>[
               Container(
                   child: Scaffold(
                     backgroundColor: Colors.transparent,
                       body: ListView(
                         children: <Widget> [
         	        encabezado(),
                  libreta(),
                  scanButton(),
                         ]
        )
        )
    ),
    Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.only(top: 40),
              children: <Widget>[
                encabezadoFila(context),
                numactual(),
                robot(),         
              ]
            ))
    ),
    Container(
      child: Scaffold(backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.only(top: 30),
        children: <Widget>[
          encabezadoContacto(),
          cuerpoMensaje(),
          botonEnviar()
          ],
      ),
      )
    ),
    Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(children: <Widget>[
            Help().problematica(),
            Help().mision(),
            Help().notificaja(),
            Help().instrucciones()
            ],),
        )
    )
            ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            onTap: (value) =>_navigateToPage(value),
            currentIndex: index,
            items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera),
                    title: Text('Escanear')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.format_list_numbered),
                    title: Text('Fila')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mail_outline),
                    title: Text('Contactanos')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.help_outline),
                    title: Text('Ayuda')
                  ),
            ],
        ),
    ));
  }
  Future scan() async {
    try {
      String cameraScanResult = await scanner.scan();
      if( cameraScanResult == '2019'){
        agregar(widget.datos.id.toString());
      }else{
        Controladores().mostrarDialogo(context, 'Qr Invalido', 'Agregarse a la fila', "Aceptar");
      }
    } on FormatException {
     Controladores().mostrarDialogo(context, 'Error.. Presionó el botón de volver antes de escanear algo', 'Agregarse a la fila', "Aceptar");
    } catch (e) {
      Controladores().mostrarDialogo(context, 'Error desconocido $e', 'Agregarse a la fila', "Aceptar");
    }
  }
  Future _showNotification1() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Notificacion de turno',
    widget.datos.pnombre + ' estas a dos personas de pasar',
    platformChannelSpecifics,
    payload: 'Hey! Tienes aproximadamente seis minutos para ir a caja',
  );
  }
  Future _showNotification2() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Notificacion de turno',
    widget.datos.pnombre + ' estas a una persona de pasar',
    platformChannelSpecifics,
    payload: 'Es urgente que te dirijas a caja o perderas tu turno',
  );
  }
  Future _scheduleNotification() async {
    var scheduledNotificationDateTime =
         new DateTime.now().add(new Duration(seconds: 30));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        color: const Color.fromARGB(255, 255, 0, 0));
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        3,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
    Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Notificaja"),
          content: Text(payload),
        );
      },
    );
  }
}
