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
  Timer shootTimer;
  int level = 1;
  int _life;

  Controller(this.view) {
    _setListener();
  }

  void startGame() {
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
    view.addPauseBtn();

    ///timer der Model und view updatet
    startTimer();
  }

  void loadLevel(String levelName) async {
    await HttpRequest.getString(levelName).then((json) {
      Map<String, dynamic> gameMap = JSON.jsonDecode(json);
      this.game = Game.fromJson(gameMap);
      view.game = game;
      //TODO so soll es nicht bleiben ist nur ein schmankerle für marcel
      game.worldSizeX = view.getViewWidth() - 40;
      game.worldSizeY = view.getViewHeight() - 40;
    });
  }

  void nextLevel() {
    level = level > 9 ? 1 : level + 1;
    view.showEndWin();
  }

  void retryLevel() {
    view.showEndLose();
  }

  void startTimer() {
    ///timer der Model und view updatet
    modelTimer = new Timer.periodic(
        new Duration(microseconds: ((1000 / ticks).round().toInt())),
        (Timer t) {
          view.setLifeBar(game.player.life);
          //todo beim retry werden 2 timerr gestartet wird doppelt so schnell
      if (game.player.life <= 0) {
        view.deletAllFromDom();
        stopAllTimer();
        retryLevel();
        view.setLifeBar(0);
        //todo friendly shots müssen ignoriert werden sonst kann man machen das das level nicht beendet wird
      } else if (game.actors.length <= 2) {
        _life = game.player.life;
        view.deletAllFromDom();
        stopAllTimer();
        nextLevel();
      } else {
        game.update();
        view.update();
      }
    });
    ///timer der Model und view updatet
    shootTimer = new Timer.periodic(new Duration(seconds: (3)), (Timer t) {
      game.shoot();
    });
  }


  void stopAllTimer() {
    shootTimer.cancel();
    modelTimer.cancel();
  }

  ///erstellt die listener der knöpfe und legt deren funktion fest
  void _setListener() {
    view.pause.onClick.listen((_) {
      if (modelTimer.isActive) {
        stopAllTimer();
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
      startGame();
      startTimer();
    });

    view.startBtn.onClick.listen((e) async {
      await loadLevel("level/level$level.json");
      view.startBtn.remove();
      startGame();
    });
  }
}
