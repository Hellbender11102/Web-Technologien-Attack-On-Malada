


import 'dart:html';

import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/game.dart';

class View {
  Map<int, Element> domElements = Map();
  Element output = querySelector('#output');
  Game game;
  int centerX = (window.innerWidth / 2).round();
  int centerY = (window.innerHeight / 2).round();

  ImageElement life = new ImageElement();
  ImageElement startBtn = new ImageElement();
  ImageElement win = new ImageElement();
  ImageElement restart = new ImageElement();
  ImageElement lose = new ImageElement();
  ImageElement level = new ImageElement();
  ImageElement next = new ImageElement();

  View(this.game) {
    startBtn.src = "Assets/start.png";
    startBtn.className = "start";
    startBtn.style.position = "absolute";
    startBtn.style.zIndex = "3";
    startBtn.style.bottom = "${50}%";
    startBtn.style.left = "${getViewWidth() / 2 - 165}px";
    output.children.add(startBtn);

    life.src = "Assets/hearts_6.png";
    life.className = "life";
    life.style.position = "absolute";
    life.style.bottom = "${90}%";
    life.style.left = "${getViewWidth() / 2 - 96}px";
    life.style.zIndex = "5";
    output.children.add(life);
  }

  void setLife(int life) {
    if (life >= 0 && life <= 6) {
      this.life.src = "Assets/hearts_$life.png";
    }
  }

  ///return die innerheight
  int getViewHeight() {
    return window.innerHeight;
  }

  ///return die innerwidth
  int getViewWidth() {
    return window.innerWidth;
  }

  ///update erstellt und entfernt gegner aus der gamestage im html code
  /// Speichert die Elemente in eine Tabelle um nicht die ganze zeit query selecten #dartsnake
  void update() {
    // Füge alle Element in den Dom ein
    // todo
    for (Actor actor in game.actors) {
      Element actorInView;
      List entries = domElements.entries.toList();

      /// Suchen vom actor
      for (MapEntry entry in entries) {
        if (entry.key == actor.id) {
          actorInView = entry.value;
        }
      }

      /// wenn null dann erstellen
      if (actorInView == null && !actor.isDead) {
        actorInView = Element.div();
        actorInView.classes = actor.classes..add("actor");
        domElements.putIfAbsent(actor.id, () => actorInView);
        output.insertAdjacentElement("afterbegin", actorInView);
      }

      /// falls tot soll es nciht mehr angezeigt werde
      /// und entfernen aus der Liste
      if (actor.isDead && actorInView != null) {
        actorInView.remove();
        domElements.remove(actor.id);
      } else if(actorInView != null){
        /// Quelle generate und update  der Dartsnake
        actorInView.style.height = actor.sizeY.toString() + "px";
        actorInView.style.width = actor.sizeX.toString() + "px";
        actorInView.style.bottom = actor.posY.toString() + "px";
        actorInView.style.left = actor.posX.toString() + "px";
      }
    }
  }

  void showEndWin() {
    win.src = "Assets/Win.png";
    win.className = "win";
    win.style.position = "absolute";
    win.style.zIndex = "5";
    win.style.bottom = "${centerY + 65}px";
    win.style.left = "${centerX - 165}px";
    output.children.add(win);

    next.src = "Assets/Next.png";
    next.className = "next";
    next.style.position = "absolute";
    next.style.zIndex = "5";
    next.style.bottom = "${centerY - 65}px";
    next.style.left = "${centerX - 165}px";
    output.children.add(next);
  }

  void showEndLose() {
    lose.src = "Assets/GameOver.png";
    lose.className = "lose";
    lose.style.position = "absolute";
    lose.style.zIndex = "5";
    lose.style.bottom = "${centerY + 65}px";
    lose.style.left = "${centerX - 165}px";
    output.children.add(lose);

    restart.src = "Assets/restart.png";
    restart.className = "restart";
    restart.style.position = "absolute";
    restart.style.zIndex = "5";
    restart.style.bottom = "${centerY - 65}px";
    restart.style.left = "${centerX - 165}px";
    output.children.add(restart);
  }

}
