import 'dart:convert';

class HistoryDay {
  double? amount;
  String? time;

  HistoryDay({this.amount, this.time});

  factory HistoryDay.fromJson(Map<String, dynamic> json) {
    return HistoryDay(
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

  static Map<String, dynamic> toMap(HistoryDay dataHistory) => {
        'amount': dataHistory.amount,
        'time': dataHistory.time,
      };

  static String encode(List<HistoryDay> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((music) => HistoryDay.toMap(music)).toList());

  static List<HistoryDay> decode(String dataHistory) =>
      (json.decode(dataHistory) as List<dynamic>).map<HistoryDay>((item) => HistoryDay.fromJson(item)).toList();

  @override
  String toString() {
    return 'HistoryDay{amount: $amount, time: $time}';
  }
}

class HistoryMonth {
  String? result;
  String? date;

  HistoryMonth({this.result, this.date});

  factory HistoryMonth.fromJson(Map<String, dynamic> json) {
    return HistoryMonth(
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

  static Map<String, dynamic> toMap(HistoryMonth historyMonth) => {
    'result': historyMonth.result,
    'date': historyMonth.date,
  };

  static String encode(List<HistoryMonth> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((e) => HistoryMonth.toMap(e)).toList());

  static List<HistoryMonth> decode(String e) {
    if(e.isNotEmpty){
      return (json.decode(e) as List<dynamic>).map<HistoryMonth>((item) => HistoryMonth.fromJson(item)).toList();
    }else{
      return [];
    }
  }


  @override
  String toString() {
    return 'HistoryMonth{result: $result, date: $date}';
  }
}
