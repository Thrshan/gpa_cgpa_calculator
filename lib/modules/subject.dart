final String tableSubject = "course1";

class SubjectFields {
  static const String id = "_id";
  static const String name = "name";
  static const String code = "code";
  static const String credit = "credit";

  static const List<String> values = [id, name, code, credit];
}

class Subject {
  final int? id;
  final String name;
  final String code;
  final int credit;

  const Subject({
    this.id,
    required this.name,
    required this.code,
    required this.credit,
  });

  Map<String, Object?> toMap() => {
        SubjectFields.id: id,
        SubjectFields.name: name,
        SubjectFields.code: code,
        SubjectFields.credit: credit,
      };

  static Subject fromMap(Map<String, Object?> map) => Subject(
        id: map[SubjectFields.id] as int,
        name: map[SubjectFields.name] as String,
        code: map[SubjectFields.code] as String,
        credit: map[SubjectFields.credit] as int,
      );

  Subject copy({
    int? id,
    String? name,
    String? code,
    int? credit,
  }) =>
      Subject(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        credit: credit ?? this.credit,
      );
}
