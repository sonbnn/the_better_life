import 'dart:convert';

class GoBedHistory {
  String? timeWakeUp;
  String? timeSleep;

  GoBedHistory({this.timeWakeUp, this.timeSleep});

  factory GoBedHistory.fromJson(Map<String, dynamic> json) {
    return GoBedHistory(
      timeWakeUp: json['timeWakeUp'],
      timeSleep: json['timeSleep'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeWakeUp'] = timeWakeUp;
    data['timeSleep'] = timeSleep;
    return data;
  }

  static Map<String, dynamic> toMap(GoBedHistory dataHistory) => {
        'timeWakeUp': dataHistory.timeWakeUp,
        'timeSleep': dataHistory.timeSleep,
      };

  static String encode(List<GoBedHistory> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((i) => GoBedHistory.toMap(i)).toList());

  static List<GoBedHistory> decode(String dataHistory) =>
      (json.decode(dataHistory) as List<dynamic>).map<GoBedHistory>((i) => GoBedHistory.fromJson(i)).toList();

  @override
  String toString() {
    return 'GoBedHistory{timeWakeUp: $timeWakeUp, timeSleep: $timeSleep}';
  }
}