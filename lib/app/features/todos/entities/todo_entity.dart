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

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      title: map['title'] ?? '',
      completed: map['completed'] ?? false,
    );
  }
}
