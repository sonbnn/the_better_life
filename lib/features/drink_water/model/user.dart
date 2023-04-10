class User {
  String? gender;
  double? weight;
  String? wakeUpTime;
  String? bedTime;
  double? age;
  double? recommendedMilli;
  double? height;

  User({this.gender, this.weight, this.wakeUpTime, this.bedTime, this.age, this.recommendedMilli, this.height});

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    weight = json['weight'];
    wakeUpTime = json['wakeUpTime'];
    bedTime = json['bedTime'];
    age = json['age'];
    recommendedMilli = json['recommendedMilli'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['weight'] = weight;
    data['wakeUpTime'] = wakeUpTime;
    data['bedTime'] = bedTime;
    data['age'] = age;
    data['recommendedMilli'] = recommendedMilli;
    data['height'] = height;
    return data;
  }

  @override
  String toString() {
    return 'UserInfo{gender: $gender, weight: $weight, wakeUpTime: $wakeUpTime, bedTime: $bedTime, age: $age, recommendedMilli: $recommendedMilli, height: $height}';
  }
}
