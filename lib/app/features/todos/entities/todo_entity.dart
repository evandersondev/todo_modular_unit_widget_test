import 'dart:convert';

class TodoEntity {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  TodoEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  TodoEntity copyWith({
    int? id,
    int? userId,
    String? title,
    bool? completed,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'title': title});
    result.addAll({'completed': completed});

    return result;
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      title: map['title'] ?? '',
      completed: map['completed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoEntity.fromJson(String source) =>
      TodoEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoEntity(id: $id, userId: $userId, title: $title, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoEntity &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ title.hashCode ^ completed.hashCode;
  }
}
