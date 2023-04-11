import 'dart:convert';

class HistorySleepModel {
  double? percent;
  String? time;

  HistorySleepModel({this.percent, this.time});

  factory HistorySleepModel.fromJson(Map<String, dynamic> json) {
    return HistorySleepModel(
      percent: json['percent'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percent'] = percent;
    data['time'] = time;
    return data;
  }

  static Map<String, dynamic> toMap(HistorySleepModel dataHistory) => {
    'percent': dataHistory.percent,
    'time': dataHistory.time,
  };

  static String encode(List<HistorySleepModel> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((music) => HistorySleepModel.toMap(music)).toList());

  static List<HistorySleepModel> decode(String dataHistory) =>
      (json.decode(dataHistory) as List<dynamic>).map<HistorySleepModel>((item) => HistorySleepModel.fromJson(item)).toList();

  @override
  String toString() {
    return 'HistorySleepModel{percent: $percent, time: $time}';
  }
}