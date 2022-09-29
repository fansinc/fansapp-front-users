class MyWeekModel {
  MyWeekModel({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.statusId,
    required this.statusName,
    required this.assetType,
    required this.assetUrl,
  });

  int id;
  int playerId;
  String playerName;
  int statusId;
  String statusName;

  List<String> assetType;
  List<String> assetUrl;
}
