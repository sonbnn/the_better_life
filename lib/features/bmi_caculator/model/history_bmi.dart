import 'dart:convert';

class BMIHistory {
  String? result;
  String? time;
  String? txtResult;

  BMIHistory({this.result, this.time, this.txtResult});

  factory BMIHistory.fromJson(Map<String, dynamic> json) {
    return BMIHistory(
      result: json['result'],
      time: json['time'],
      txtResult: json['txtResult'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['time'] = time;
    data['txtResult'] = txtResult;
    return data;
  }

  static Map<String, dynamic> toMap(BMIHistory dataHistory) => {
    'result': dataHistory.result,
    'time': dataHistory.time,
    'txtResult': dataHistory.txtResult,
  };

  static String encode(List<BMIHistory> dataHistory) =>
      json.encode(dataHistory.map<Map<String, dynamic>>((i) => BMIHistory.toMap(i)).toList());

  static List<BMIHistory> decode(String dataHistory) {
    if(dataHistory.isNotEmpty){
      return (json.decode(dataHistory) as List<dynamic>).map<BMIHistory>((i) => BMIHistory.fromJson(i)).toList();
    }
    return [];
  }


  @override
  String toString() {
    return 'BMIHistory{result: $result, time: $time, txtResult: $txtResult}';
  }
}