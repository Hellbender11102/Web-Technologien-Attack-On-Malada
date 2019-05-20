

class Level {
  String name;
  int spawnTime, number, numberOnScreen,numberTilFinish,fortschritt;
  List<String> type;
  Level(
      {this.fortschritt,
      this.name,
      this.spawnTime,
      this.numberOnScreen,
      this.type,
        this.numberTilFinish});

  Level.fromJson(Map<String, dynamic> json) {
    fortschritt = json['fortschritt'];
    name = json['name'];
    spawnTime = json['spawnTime'];
    numberOnScreen = json['numberOnScreen'];
    type = json['type'].cast<String>();
    numberTilFinish = json['numberTilFinish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fortschritt'] = fortschritt;
    data['name'] = name;
    data['spawnTime'] = spawnTime;
    data['numberOnScreen'] = numberOnScreen;
    data['type'] = type;
    data['numberTilFinish'] = numberTilFinish;
    return data;
  }

}