class User {
  String? gender;
  double? weight;
  String? wakeUpTime;
  String? bedTime;
  String? birthDay;
  double? recommendedMilli;

  User({this.gender, this.weight, this.wakeUpTime, this.bedTime, this.birthDay, this.recommendedMilli});

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    weight = json['weight'];
    wakeUpTime = json['wakeUpTime'];
    bedTime = json['bedTime'];
    birthDay = json['birthDay'];
    recommendedMilli = json['recommendedMilli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['weight'] = weight;
    data['wakeUpTime'] = wakeUpTime;
    data['bedTime'] = bedTime;
    data['birthDay'] = birthDay;
    data['recommendedMilli'] = recommendedMilli;
    return data;
  }

  @override
  String toString() {
    return 'UserInfo{gender: $gender, weight: $weight, wakeUpTime: $wakeUpTime, bedTime: $bedTime, birthDay: $birthDay, recommendedMilli: $recommendedMilli}';
  }
}
