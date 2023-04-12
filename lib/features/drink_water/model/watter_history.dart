import 'dart:convert';

class WaterHistoryDay {
  double? amount;
  String? time;

  WaterHistoryDay({this.amount, this.time});

  factory WaterHistoryDay.fromJson(Map<String, dynamic> json) {
    return WaterHistoryDay(
      amount: json['amount'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['time'] = time;
    return data;
  }

  static Map<String, dynamic> toMap(WaterHistoryDay dataHistory) => {
        'amount': dataHistory.amount,
        'time': dataHistory.time,
      };

  static String encode(List<WaterHistoryDay> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((music) => WaterHistoryDay.toMap(music)).toList());

  static List<WaterHistoryDay> decode(String? dataHistory) {
    if (dataHistory != null) {
      return (json.decode(dataHistory) as List<dynamic>)
          .map<WaterHistoryDay>((i) => WaterHistoryDay.fromJson(i))
          .toList();
    }
    return [];
  }

  @override
  String toString() {
    return 'HistoryDay{amount: $amount, time: $time}';
  }
}

class WaterHistoryMonth {
  String? result;
  String? date;

  WaterHistoryMonth({this.result, this.date});

  factory WaterHistoryMonth.fromJson(Map<String, dynamic> json) {
    return WaterHistoryMonth(
      result: json['result'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['date'] = date;
    return data;
  }

  static Map<String, dynamic> toMap(WaterHistoryMonth historyMonth) => {
        'result': historyMonth.result,
        'date': historyMonth.date,
      };

  static String encode(List<WaterHistoryMonth> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((e) => WaterHistoryMonth.toMap(e)).toList());

  static List<WaterHistoryMonth> decode(String e) {
    if (e.isNotEmpty) {
      return (json.decode(e) as List<dynamic>)
          .map<WaterHistoryMonth>((item) => WaterHistoryMonth.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }

  @override
  String toString() {
    return 'HistoryMonth{result: $result, date: $date}';
  }
}
