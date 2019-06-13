
  import 'package:dartmotion_master/controller/controller.dart';
import 'package:dartmotion_master/model/game.dart';
import 'package:dartmotion_master/view/view.dart';

void main() {

    Game game = Game();
    View view = View(game);
    // ignore: unused_local_variable
    Controller con = Controller(game, view);
}
