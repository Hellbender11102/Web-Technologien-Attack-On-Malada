import 'dart:html';

import 'elite.dart';
import 'enemy.dart';
import 'asteroid.dart';
import 'casual.dart';

import '../model/asteroid.dart';
import '../model/boss.dart';
import '../model/casual.dart';
import '../model/enemy.dart';
import 'dart:math';

class Level {
  int fortschritt, maxY;
  static var Screen = querySelector("#screen");
  final int maxX = Screen.clientWidth - 70;
  String name;
  List<dynamic> entityList;

  Level({this.fortschritt,this.name, this.maxY, this.entityList});

  Level.fromJson(Map<String, dynamic> json) {
    fortschritt = json['fortschritt'];
    name = json['name'];
    maxY = json['maxY'];
    entityList = json['entityList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fortschritt'] = this.fortschritt;
    data['name'] = this.name;
    data['maxY'] = this.maxY;
    data['entityList'] = this.entityList;
    return data;
  }

/*

 */
  List<Enemy> enemyList() {
    var rand = new Random();
    List<Enemy> enemies = new List();
    for (int i = 0; i < entityList.length; i++) {
      if (entityList[i] == 'casual') {
        enemies.add(new Casual(2, rand.nextDouble()*maxX, double.parse(entityList[i + 1]), false));
      } else if (entityList[i] == 'asteroid') {
        enemies.add(new Asteroid(rand.nextDouble()*maxX, double.parse(entityList[i + 1])));
      } else if (entityList[i] == 'elite') {
        enemies.add(Elite(4, rand.nextDouble()*maxX,
            double.parse(entityList[i + 1])));
      }
    }
    print(enemies);
    return enemies;
  }

  int checkX(int toCheck){
    if(toCheck > maxX){
      int newX = ((maxX/toCheck) * toCheck).round();
      return newX;
    } else {
      return toCheck;
    }
  }

  String toString(){
    return  name+ " " + maxX.toString()+ " " + maxY.toString()+ " " +entityList.toString();
  }
}
