class Club {
  String clubCode;
  String club;

  Club({this.clubCode, this.club});

  Club.fromJson(Map<String, dynamic> parsedJson) {
    clubCode = parsedJson["Club_code"];
    club = parsedJson["Club"];
  }
}
