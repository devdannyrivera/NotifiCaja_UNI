import 'package:flutter/material.dart';

class Help{
  Widget problematica(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text('Problematica', style: TextStyle(color: Colors.white, fontSize: 26),textAlign: TextAlign.center,),),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text('En la Universidad Nacional de Ingenieria especialmente en el Sabatino existe el problema de grandes filas a la hora de pagar, lo que hace perder tiempo valioso a los estudiantes, quienes en el peor de los casos pasan hasta 2 horas haciendo fila para realizar un proceso que solo toma 3 minutos.', style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,))
        ],)
    );
  }
  Widget mision(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text('Mision', style: TextStyle(color: Colors.white, fontSize: 26),textAlign: TextAlign.center,),),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text('Facilitar los procesos de pago en la Universidad Nacional de Ingenieria acortando radicalmente el tiempo que los estudiante pasan haciendo fila a traves de un asistente virtual que hara fila por ellos.', style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,))
        ],)
    );
  }
  Widget notificaja(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text('NotifiCaja', style: TextStyle(color: Colors.white, fontSize: 26),textAlign: TextAlign.center,),),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text('La tecnologia a lo largo de la historia ha facilitado la vida del ser humano, teniendo esa misma forma de pensar se dio vida a NotifiCaja el cual sera ese asistente virtual que nos permita dar solucion al problema antes mencionado.', style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,))
        ],)
    );
  }
  Widget instrucciones(){
    return Column(children: <Widget>[
      Padding(padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Como usar NotifiCaja?', style: TextStyle(color: Colors.white, fontSize: 26,),textAlign: TextAlign.center,)),
            Padding( padding: const EdgeInsets.symmetric( vertical: 15),
            child: Row(children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(Icons.camera, color: Colors.white, size: 80,)),
              Expanded(child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text('Escanea', style: TextStyle(color: Colors.white, fontSize: 24),),),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Dirigite a caja y con la app escanea el codigo QR que esta en la pared.', style: TextStyle(color: Colors.white, fontSize: 16))
              )],)
             )],),),
              Padding( padding: const EdgeInsets.symmetric( vertical: 15),
              child: Row(children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(Icons.format_list_numbered, color: Colors.white, size: 80,)),
              Expanded(child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text('Revisa', style: TextStyle(color: Colors.white, fontSize: 24),),),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Una vez escaneado el codigo QR ya tienes una posicion en la fila, podras revisar tu estado siempre que quieras.', style: TextStyle(color: Colors.white, fontSize: 16))
              )],)
             )],),),
              Padding( padding: const EdgeInsets.symmetric( vertical: 15),
              child: Row(children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(Icons.notifications_active, color: Colors.white, size: 80,)),
              Expanded(child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text('Espera', style: TextStyle(color: Colors.white, fontSize: 24),),),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('La app te notificara 10 minutos antes de que sea tu turno para que puedas dirigirte a caja.', style: TextStyle(color: Colors.white, fontSize: 16))
              )],)
             )],)),
              Padding( padding: const EdgeInsets.symmetric( vertical: 15),
              child: Row(children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(Icons.monetization_on, color: Colors.white, size: 80,)),
              Expanded(child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text('Paga', style: TextStyle(color: Colors.white, fontSize: 24),),),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Una vez terminados todos los procesos podras pagar comodamente y mira!!! solo tomo 10 minutos de tu tiempo.', style: TextStyle(color: Colors.white, fontSize: 16))
              )],)
             )],))
          
    ],);
  }
}