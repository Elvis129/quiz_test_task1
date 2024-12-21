// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyResalt {
  int many;
  int xp;
  int time;
  int timeAVG;
  int count;
  int correct;
  MyResalt({
    required this.many,
    required this.xp,
    required this.time,
    required this.timeAVG,
    required this.count,
    required this.correct,
  });

  MyResalt copyWith({
    int? many,
    int? xp,
    int? time,
    int? timeAVG,
    int? count,
    int? correct,
  }) {
    return MyResalt(
      many: many ?? this.many,
      xp: xp ?? this.xp,
      time: time ?? this.time,
      timeAVG: timeAVG ?? this.timeAVG,
      count: count ?? this.count,
      correct: correct ?? this.correct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'many': many,
      'xp': xp,
      'time': time,
      'timeAVG': timeAVG,
      'count': count,
      'correct': correct,
    };
  }

  factory MyResalt.fromMap(Map<String, dynamic> map) {
    return MyResalt(
      many: map['many'] as int,
      xp: map['xp'] as int,
      time: map['time'] as int,
      timeAVG: map['timeAVG'] as int,
      count: map['count'] as int,
      correct: map['correct'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyResalt.fromJson(String source) =>
      MyResalt.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyResalt(many: $many, xp: $xp, time: $time, timeAVG: $timeAVG, count: $count, correct: $correct)';
  }

  @override
  bool operator ==(covariant MyResalt other) {
    if (identical(this, other)) return true;

    return other.many == many &&
        other.xp == xp &&
        other.time == time &&
        other.timeAVG == timeAVG &&
        other.count == count &&
        other.correct == correct;
  }

  @override
  int get hashCode {
    return many.hashCode ^
        xp.hashCode ^
        time.hashCode ^
        timeAVG.hashCode ^
        count.hashCode ^
        correct.hashCode;
  }
}
