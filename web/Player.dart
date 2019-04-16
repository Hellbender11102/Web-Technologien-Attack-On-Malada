import 'Actors.dart';
import 'Enemy.dart';

class Player extends Actor{

  //Player function to shoot enemy. Whether it hits or not is up to controller/world
  void shoot(Enemy enemy){
    enemy.life = enemy.life - this.damage;
  }
}