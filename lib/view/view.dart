import 'dart:html';

import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/game.dart';
import 'package:dartmotion_master/model/player.dart';
import 'package:dartmotion_master/model/shot.dart';
import 'package:dartmotion_master/model/cross.dart';

class View {
  Map<int, Element> domElements = Map();
  Element output = querySelector('#output');
  Game game;
  ///Mitte der X-Achse
  int centerX = (window.innerWidth / 2).round();
  ///Mitte der Y-Achse
  int centerY = (window.innerHeight / 2).round();
  int sinVal = 0;

  //ImageElemente für unsere Buttons und Lebensanzeige
  ImageElement life = new ImageElement();
  ImageElement startBtn = new ImageElement();
  ImageElement win = new ImageElement();
  ImageElement restart = new ImageElement();
  ImageElement lose = new ImageElement();
  ImageElement level = new ImageElement();
  ImageElement next = new ImageElement();
  ImageElement pause = new ImageElement();

  //ImageElemente und DivElement für die Minimap
  DivElement minimapElement = new DivElement();
  ImageElement playerDot = new ImageElement();
  List<ImageElement> enemyDots = new List<ImageElement>();

  ///Beim Erstellen der View wird der Start-Button direkt hinzugefügt
  View() {
    addStartBtn();
  }

  ///Aktualisiert die Lebensanzeige
  ///int life aktuelles Leben
  void setLifeBar(int life) {
    if (life >= 0 && life <= 9) {
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

  ///update erstellt und entfernt Gegner aus der Gamestage im Html-Code
  /// Speichert die Elemente in eine Tabelle, um nicht die ganze Zeit Query zu selecten #DartSnake
  void update() {
    //Liste erstellen mit allen Einträgen
    List entries = domElements.entries.toList();
    ImageElement temporaryImageHolder;

    for (Actor actor in game.actors) {
      Element actorInView;


      /// Suchen vom Actor
      actorInView = domElements[actor.id];

      /// wenn null, dann erstellen
      if (actorInView == null && !actor.isDead) {
        actorInView = Element.div();
        actorInView.classes = actor.classes..add("actor");
        domElements.putIfAbsent(actor.id, () => actorInView);
        output.insertAdjacentElement("afterbegin", actorInView);
        if(actor is !Player && actor is !Shot && actor is !Cross){
          ImageElement enemy = new ImageElement();
          enemy.style.position = "absolute";
          enemy.src = "Assets/EnemyBeepBeep.png";
          enemy.className = "enemy";
          enemy.id = "enemyDotNr${actor.id}";
          enemyDots.add(enemy);
          minimapElement.children.add(enemy);
        }
      }

      /// falls tot, soll es nicht mehr angezeigt werden
      /// und aus der Liste entfernt werden
      if (actor.isDead && actorInView != null) {
        actorInView.remove();
        domElements.remove(actor.id);
        enemyDots.removeWhere((x) => x.id == "enemyDotNr${actor.id}");
        minimapElement.children.removeWhere((x) => x.id == "enemyDotNr${actor.id}");

      } else if (actorInView != null) {
        /// Quelle generate und update der Dartsnake
        actorInView.style.height = actor.sizeY.toString() + "px";
        actorInView.style.width = actor.sizeX.toString() + "px";
        actorInView.style.bottom = actor.posY.toString() + "px";
        actorInView.style.left = actor.posX.toString() + "px";
        if(actor is !Player && actor is !Shot && actor is !Cross){
          temporaryImageHolder = enemyDots.firstWhere((x) => x.id == "enemyDotNr${actor.id}");
          temporaryImageHolder.style.left = '${((actor.posX / game.worldSizeX) * 100)}%';
          temporaryImageHolder.style.bottom = '${((actor.posY / game.worldSizeY) * 100)}%';
        }
      }
    }
    playerDot.style.left = '${((game.player.posX / game.worldSizeX) * 100)}%';
    playerDot.style.bottom = '${((game.player.posY / game.worldSizeY) * 100)}%';
  }


  ///Zeigt den Screen fürs Gewinnen an
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

  ///Fügt den Pause-Button hinzu
  void addPauseBtn() {
    pause.src = "Assets/pause.png";
    pause.className = "pauseBtn";
    pause.style.position = "absolute";
    pause.style.width = "100px";
    pause.style.height = "100px";
    pause.style.bottom = "${getViewHeight() - 100}px";
    pause.style.left = "${getViewWidth() - 100}px";
    output.children.add(pause);
  }

  ///Zeigt den Screen fürs Verlieren an
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

  ///Fügt den Start-Button hinzu
  void addStartBtn() {
    startBtn.src = "Assets/start.png";
    startBtn.className = "start";
    startBtn.style.position = "absolute";
    startBtn.style.zIndex = "3";
    startBtn.style.bottom = "${50}%";
    startBtn.style.left = "${getViewWidth() / 2 - 165}px";
    output.children.add(startBtn);
  }


  ///löscht alle Actoren, die im Spiel und im Dom-Tree vorhanden sind
  void deletAllFromDom() {
    for (Actor actor in game.actors) {
      List entries = domElements.entries.toList();
      for (MapEntry entry in entries) {
        if (entry.key == actor.id) {
          entry.value.remove();
          domElements.remove(actor.id);
        }
      }
    }
  }

  ///Fügt die Minimap hinzu
  void addMiniMap(){
    minimapElement.style.position = "absolute";
    minimapElement.style.top = "0px";
    minimapElement.style.left = "0px";
    minimapElement.style.width = "150px";
    minimapElement.style.height = "150px";
    minimapElement.style.overflow = "hidden";

    this.playerDot.style.position = "absolute";
    this.playerDot.src = "Assets/MiniMap_Circle_Player.png";
    this.playerDot.className = "playerOnMap";
    minimapElement.children.add(playerDot);

    UListElement griddy = new UListElement();
    griddy.style.padding = "0px";
    griddy.style.margin = "0px";
    griddy.style.display = "grid";
    griddy.style.gridTemplateColumns = "1fr 1fr 1fr";
    griddy.style.gridTemplateRows = "1fr 1fr 1fr";
    griddy.style.width = "100%";
    griddy.style.height = "100%";
    griddy.style.background = "#000";

    for (int i = 0; i < 9; i++) {
      LIElement box = new LIElement();
      box.style.listStyleType = "none";
      box.style.background = "#000";
      box.style.boxSizing = "border-box";
      box.style.border = "solid lightgreen 1px";
      griddy.children.add(box);
    }
    minimapElement.children.add(griddy);
    minimapElement.style.zIndex = "5";
    output.children.add(minimapElement);
  }

  ///Fügt die Life-Bar hinzu
  void addLifeBar(){
    life.src = "Assets/hearts_6.png";
    life.className = "life";
    life.style.position = "absolute";
    life.style.bottom = "${90}%";
    life.style.left = "${getViewWidth() / 2 - 96}px";
    life.style.zIndex = "5";
    output.children.add(life);
  }
}