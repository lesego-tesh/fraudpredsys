import 'dart:convert';

class Result {
  int id;
  String dataType;
  String shape;
  String UTV;
  String Score;
  String f1Score;
  String f2Score;
  String anyNull;
  String tFraud;
  String tNormal;
  Result({
    this.id = 0,
    this.dataType = '',
    this.shape = '',
    this.UTV = '',
    this.Score = '',
    this.f1Score = '',
    this.f2Score = '',
    this.anyNull = '',
    this.tFraud = '',
    this.tNormal = '',
  });

  Result copyWith({
    int? id,
    String? dataType,
    String? shape,
    String? UTV,
    String? Score,
    String? f1Score,
    String? f2Score,
    String? anyNull,
    String? tFraud,
    String? tNormal,
  }) {
    return Result(
      id: id ?? this.id,
      dataType: dataType ?? this.dataType,
      shape: shape ?? this.shape,
      UTV: UTV ?? this.UTV,
      Score: Score ?? this.Score,
      f1Score: f1Score ?? this.f1Score,
      f2Score: f2Score ?? this.f2Score,
      anyNull: anyNull ?? this.anyNull,
      tFraud: tFraud ?? this.tFraud,
      tNormal: tNormal ?? this.tNormal,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'dataType': dataType});
    result.addAll({'shape': shape});
    result.addAll({'UTV': UTV});
    result.addAll({'Score': Score});
    result.addAll({'f1Score': f1Score});
    result.addAll({'f2Score': f2Score});
    result.addAll({'anyNull': anyNull});
    result.addAll({'tFraud': tFraud});
    result.addAll({'tNormal': tNormal});

    return result;
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id']?.toInt() ?? 0,
      dataType: map['dataType'] ?? '',
      shape: map['shape'] ?? '',
      UTV: map['UTV'] ?? '',
      Score: map['Score'] ?? '',
      f1Score: map['f1Score'] ?? '',
      f2Score: map['f2Score'] ?? '',
      anyNull: map['anyNull'] ?? '',
      tFraud: map['tFraud'] ?? '',
      tNormal: map['tNormal'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(id: $id, dataType: $dataType, shape: $shape, UTV: $UTV, Score: $Score, f1Score: $f1Score, f2Score: $f2Score, anyNull: $anyNull, tFraud: $tFraud, tNormal: $tNormal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
        other.id == id &&
        other.dataType == dataType &&
        other.shape == shape &&
        other.UTV == UTV &&
        other.Score == Score &&
        other.f1Score == f1Score &&
        other.f2Score == f2Score &&
        other.anyNull == anyNull &&
        other.tFraud == tFraud &&
        other.tNormal == tNormal;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataType.hashCode ^
        shape.hashCode ^
        UTV.hashCode ^
        Score.hashCode ^
        f1Score.hashCode ^
        f2Score.hashCode ^
        anyNull.hashCode ^
        tFraud.hashCode ^
        tNormal.hashCode;
  }
}
