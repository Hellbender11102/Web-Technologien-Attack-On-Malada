import 'dart:async';
import 'dart:html';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/game.dart';
import 'package:dartmotion_master/view/view.dart';

// ignore: library_prefixes
import 'dart:convert' as JSON;

class Controller {
  Game game;
  View view;
  Timer modelTimer;
  int level = 1;
  int _life;

  Controller(this.view) {
    _setListener();
  }

  void startGame() {
    view.addLifeBar();
    view.addPauseBtn();
    view.addMiniMap();
    ///Device-Oriantation listener welcher anhand von dem derzeitigen winkel des gerätes
    ///die position auf dem Display bestimmt
    window.onDeviceOrientation.listen((ev) {
      if (ev.alpha == null && ev.beta == null && ev.gamma == null) {
        ev.stopPropagation();
      } else {
        ///gibt eine range zwischen -1 und 1 an die 30 ist der maximale ausschlag
        ///dies wird gemacht damit das fadenkreutz immer in die mitte des bildes geht

        game.cross.posX = view.getViewWidth() * (ev.gamma / 60);
        game.cross.posX +=
            view.getViewWidth() / 2 - 33; // - 33 weild as bild ~60 px hat

        game.cross.posY = view.getViewHeight() * ((ev.beta - 35) / -60);
        game.cross.posY += view.getViewHeight() / 2;
      }
    });
    window.onTouchStart.listen((_) {
      game.player.shoot();
    });

// Keylistener WASD
    ///beschleunigung wird wieder aufgehoben
    window.onKeyUp.listen((e) {
      switch (e.keyCode) {
        case KeyCode.W:
          game.cross.accelerationY = 0;
          break;
        case KeyCode.A:
          game.cross.accelerationX = 0;

          break;
        case KeyCode.S:
          game.cross.accelerationY = 0;

          break;
        case KeyCode.D:
          game.cross.accelerationX = 0;
          break;
        case KeyCode.SPACE:
          game.player.shoot();
      }
    });

    ///fügt wärend des drucks beschleunigung zum spieler hinzu
    window.onKeyDown.listen((e) {
      switch (e.keyCode) {
        case KeyCode.W:
          game.cross.accelerationY = 1;
          break;
        case KeyCode.A:
          game.cross.accelerationX = -1;
          break;
        case KeyCode.S:
          game.cross.accelerationY = -1;

          break;
        case KeyCode.D:
          game.cross.accelerationX = 1;
          break;
      }
    });
    ///timer der Model und view updatet
    startTimer();
  }

  ///Lädt das Level
  void loadLevel(String levelName) async {
    await HttpRequest.getString(levelName).then((json) {
      Map<String, dynamic> gameMap = JSON.jsonDecode(json);
      this.game = Game.fromJson(gameMap, view.getViewWidth());
      view.game = game;
    });
  }

  ///Zählt das Level hoch und zeigt den entsprechenden Screen an
  void nextLevel() {
    level = level > 10 ? 1: level+1;
    view.showEndWin();
  }

  ///Zeigt den Screen fürs Verlieren an
  void retryLevel() {
    view.showEndLose();
  }

  void startTimer() {
    ///timer der Model und View updatet
    modelTimer = new Timer.periodic(
        new Duration(microseconds: ((1000 / tick).round().toInt())),
        (Timer t) async {
      view.setLifeBar(game.player.life);
      if (game.player.life <= 0) {
        view.deletAllFromDom();
        stopTimer();
        retryLevel();
      } else if (game.enemies.isEmpty) {
        _life = game.player.life;
        view.deletAllFromDom();
        stopTimer();
        nextLevel();
      } else {
        game.update();
        view.update();
      }
    });
  }

  void stopTimer() {
    modelTimer.cancel();
  }

  ///erstellt die Listener der Knöpfe und legt deren Funktion fest
  void _setListener() {
    view.pause.onClick.listen((_) {
      if (modelTimer.isActive) {
        stopTimer();
      } else {
        startTimer();
      }
    });

    view.next.onClick.listen((_) async {
      await loadLevel("level/level$level.json");
      view.next.remove();
      view.win.remove();
      game.player.life = _life;
      startTimer();
    });

    view.restart.onClick.listen((_) async {
      await loadLevel("level/level$level.json");
      view.restart.remove();
      view.lose.remove();
      startTimer();
    });

    view.startBtn.onClick.listen((e) async {
      await loadLevel("level/level$level.json");
      view.startBtn.remove();
      startGame();
    });
  }
}
