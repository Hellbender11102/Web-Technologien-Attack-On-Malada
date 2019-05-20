import 'asteroid.dart';
import 'enemy.dart';

class Level {
  int fortschritt;
  String name;
  int spawnWidth;
  int spawnTime;
  int number;
  List<Enemy> enemies;

  Level(
      {this.fortschritt,
      this.name,
      this.spawnWidth,
      this.spawnTime,
      this.number,
      this.enemies});

  Level.fromJson(Map<String, dynamic> json) {
    fortschritt = json['fortschritt'];
    name = json['name'];
    spawnWidth = json['spawnWidth'];
    spawnTime = json['spawnTime'];
    number = json['number'];
    if (json['enemies'] != null) {
      enemies = new List<Enemy>();
      json['enemies'].forEach((v) {
        enemies.add(Asteroid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fortschritt'] = this.fortschritt;
    data['name'] = this.name;
    data['spawnWidth'] = this.spawnWidth;
    data['spawnTime'] = this.spawnTime;
    data['number'] = this.number;
    if (this.enemies != null) {
      data['enemies'] = this.enemies.map((v) => v.toJson()).toList();
    }
    return data;
  }
  List<Enemy> getEnemyList(){
    return enemies;
  }
}
