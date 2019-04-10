import 'dart:html';
import 'dart:math';

class Circle {
	double x;
	double y;

	// current radius
	double radius;
	// Target size of radius
	double target;

	// Relative X movement of the circle.
	double dx = 0.0;

	// Relative Y movement of the circle.
	double dy = 0.0;

	//References the [view] on which the circle object is shown.
	MotionView view;

	///Creates a circle object at position ([x], [y]) with the specified [radius] on the viewport [view].
	Circle(this.x, this.y, this.radius, this.view) {
		this.target = this.radius;
	}

	//Top position in pixels of the circle.
	int get top => (this.y - this.radius).floor();

	//Bottom position in pixels of the circle.
	int get bottom => (this.y + this.radius).floor();

	//Left position in pixels of the circle.
	int get left => (this.x - this.radius).floor();

	//Right position in pixels of the circle.
	int get right => (this.x + this.radius).floor();

	//Width in pixels of the circle.
	int get width => (2 * this.radius).floor();

	//Height in pixels of the circle.
	int get height => (2 * this.radius).floor();

	/**
	* Sets the moving vector [dx] and [dy] of the circle.
   * The next update will shift the center position of
   * the circle according to this ([dx], [dy] vector).
   */
	void move(double dx, double dy) {
		this.dx = dx;
		this.dy = dy;
	}

	/**
   * Sets the absolute position of the center of the
   * circle to [cx] and [cy] position.
   */
	void position(double cx, double cy) {
		this.x = cx;
		this.y = cy;
	}

	/**
   * Updates the position of the circle.
   * It is assured that the circle will remain in the viewport of the [view].
   */
	void update() {
		this.x += this.dx;
		this.y += this.dy;

		if (this.top < 0) this.y = this.radius;

		if (this.bottom > this.view.height - 1) this.y = this.view.height - 1 - this.radius;

		if (this.left < 0) this.x = this.radius;

		if (this.right > this.view.width - 1) this.x = this.view.width - 1 - this.radius;
  }

	/**
   * Grows the [radius] of the circle by [dr].
   * It is assured that the [radius] will not become bigger that half of the
   * viewport size of the [view].
   */
	void grow(double dr) {
		this.radius += dr;
		this.radius = max(this.target, this.radius);
		this.radius = min(this.view.size / 2, this.radius);
	}

	/**
   * Checks wether the [other] circle is in danger.
   * A circle is in danger whenever its center position
   * has left the shape of this circle (partly overlap).
   */
	bool isInDanger(Circle other) {
		final dx = (this.x - other.x).abs();
		final dy = (this.y - other.y).abs();
		final dist = sqrt(dx * dx + dy * dy);
		return dist + other.radius > this.radius;
	}

  /**
   * Checks wether the [other] circle is completely out.
   * A circle is completely out whenever it has not overlop
   * with this circle anymore.
   */
  bool isOut(Circle other) {
    final dx = (this.x - other.x).abs();
    final dy = (this.y - other.y).abs();
    final dist = sqrt(dx * dx + dy * dy);
    return dist > this.radius;
  }

  /**
   * Checks whether the [other] circle is completely in this circle.
   * A circle is completely in whenever it overlops fully
   * with this circle.
   */
  bool isIn(Circle other) {
    final dx = (this.x - other.x).abs();
    final dy = (this.y - other.y).abs();
    final dist = sqrt(dx * dx + dy * dy);
    return dist + other.radius < this.radius;
  }
}

///Nutzbar als "Pseudo"-Canvas, da echte nicht erlaubt sind
class MotionView {
  //Html element representing the moving area of the game.
  final area = querySelector("#area");

  //Funktioniert nur für ein Objekt, umbauen zu List o.Ä.
  final stick = querySelector("#stick");

  //(re)start Element
  final start = querySelector("#Texto");

  //"Fake" Canvas
  int get width => window.innerWidth;
  int get height => window.innerHeight;

  //Minimale Größe
  int get size => min(this.width, this.height);

  //Mitte von x/y herausfinden
  double get center_x => this.width / 2;
  double get center_y => this.height / 2;

  void update(Circle a, Circle b) {
    a.update();
    b.update();

    final round = "${this.size}px";

    this.area.style.width = "${a.width}px";
    this.area.style.height = "${a.width}px";
    this.area.style.borderRadius = round;
    this.area.style.top = "${a.top}px";
    this.area.style.left = "${a.left}px";

    this.stick.style.top = "${b.top}px";
    this.stick.style.left = "${b.left}px";
    this.stick.style.width = "${b.width}px";
    this.stick.style.height = "${b.width}px";
    this.stick.style.borderRadius = round;

    this.stick.classes.remove('out');
    this.stick.classes.remove('danger');

    if (a.isInDanger(b)) this.stick.classes.add('danger');
    if (a.isOut(b)) this.stick.classes.add('out');
  }
}
