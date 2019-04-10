import 'dart:html';
import 'dart:math' as math;

void main() async{
  //Player one = new Player(4.0, 4.0);
  //Space space_one = new Space(15.0, 15.0, one);
  //Textbox
  var show = querySelector("#Texto");

  //Vector zum testen
  Vector2D testVector = new Vector2D(0.0, 1.0);

  //Winkel, wie sehr rotiert wird
  double alpha = 0.0;
  
  //Schleife, die den Vektor einfach nur drehen sollte
  //Funktioniert nicht ganz und zeigt "6.73678268762387628734e-16" o.Ä. dank floating point rundung.
  //TODO Fix this RITO!
  for(int i = 0; i < 100; i++){
    show.text = "Nun haben wir alpha (${alpha}) und sinus (${math.sin(alpha)}) und cosinus (${math.cos(alpha)})";
    alpha += math.pi / 2;
    await window.animationFrame;
  }
  /*
  //Test für Funktion, die später das drehen erleichtert
  print("dx ist ${testVector.dx} und dy ist ${testVector.dy}");
  for(int i = 0; i < 10; i++){
	 testVector.rotate_counter_clockwise(1);
	 print("dx ist ${testVector.dx} und dy ist ${testVector.dy}");
  }
  */
}

class Space {
  //Set sizes at start etc
  double x_size_max;
  double y_size_max;
  Player current_player;
  Space(this.x_size_max, this.y_size_max, this.current_player);

  //Function to simulate the space for every frame(Kommt noch)
  void simulate() {}
}

class Player {
  //Current position
  double x_pos_curr;
  double y_pos_curr;
  //Current health
  int health = 6;
  Player(this.x_pos_curr, this.y_pos_curr);
}

class Vector2D {
  //2 Dimensional dx, dy
  //should be between -1 to 1
  double dx;
  double dy;
  Vector2D(this.dx, this.dy);

  //Functions to rotate clockwise/counter-clockwise
  //we'll use some math for this (oh geez!)
  void rotate_counter_clockwise(int betaDegree) {
    this.dx = math.cos(betaDegree) * this.dx - math.sin(betaDegree) * this.dy;
    this.dy = math.sin(betaDegree) * this.dx + math.cos(betaDegree) * this.dy;
  }

  String toString() => "($dx, $dy)";
}
