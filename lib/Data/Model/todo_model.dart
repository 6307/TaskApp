class TodoModel {
  String task;

  TodoModel({required this.task});

  Map<String, dynamic> toJson() => {'task': task};

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      TodoModel(task: json['task']);
}
