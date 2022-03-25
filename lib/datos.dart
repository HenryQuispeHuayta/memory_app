import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> listaImgs() {
  return [
    'assets/imgs/1.jpg',
    'assets/imgs/1.jpg',
    'assets/imgs/2.jpg',
    'assets/imgs/2.jpg',
    'assets/imgs/3.jpg',
    'assets/imgs/3.jpg',
    'assets/imgs/4.jpg',
    'assets/imgs/4.jpg',
    'assets/imgs/5.jpg',
    'assets/imgs/5.jpg',
    'assets/imgs/6.jpg',
    'assets/imgs/6.jpg',
  ];
}

enum Level { DIFICIL, FACIL }

List getImgs(Level level) {
  List<String> levelList = [];
  List img = listaImgs();
  if (level == Level.DIFICIL) {
    img.forEach((element) {
      levelList.add(element);
    });
  } else if (level == Level.FACIL) {
    for (int i = 0; i < 6; i++) {
      levelList.add(img[i]);
    }
  }
  levelList.shuffle();
  return levelList;
}

List<bool> getEstadoInicial(Level level) {
  List<bool> estadoInicial = [];
  if (level == Level.DIFICIL) {
    for (int i = 0; i < 12; i++) {
      estadoInicial.add(true);
    }
  }else if (level == Level.FACIL) {
    for (int i = 0; i < 12; i++) {
      estadoInicial.add(true);
    }
  }
  return estadoInicial;
}

List<GlobalKey<FlipCardState>> getEstadoTarjeta(Level level){
  List<GlobalKey<FlipCardState>> keyTarjeta = [];
  if(level == Level.DIFICIL){
        for (int i = 0; i < 12; i++){
          keyTarjeta.add(GlobalKey<FlipCardState>());
        }
  }
  else if(level == Level.FACIL){
        for (int i = 0; i < 6; i++){
          keyTarjeta.add(GlobalKey<FlipCardState>());
        }
  }
  return keyTarjeta;
}