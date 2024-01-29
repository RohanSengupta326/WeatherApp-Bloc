// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Weather {
  final String time;
  final double temperature;
  final int is_day;
  final double weathercode;

  Weather({
    required this.time,
    required this.temperature,
    required this.is_day,
    required this.weathercode,
  });
  //

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temperature': temperature,
      'is_day': is_day,
      'weathercode': weathercode,
    };
  }

//  Note:
//be careful about what are the names of json keys, make sure to name local model keys the same,
// and also, what 'type' api json returns, and how are you typecasting them in local
// model,
// else if your local model key is name is different, then you have to mention the actual json key while fetching like this : @JsonKey(name: 'weathercode')
// by using json_annotation & other packages.
  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      time: map['time'] as String,
      temperature: double.parse(map['temperature'].toString()),
      is_day: map['is_day'] as int,
      weathercode: double.parse(map['weathercode'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);
}
