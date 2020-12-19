class Task {
  int id;
  String name;
  int isComplete;

  Task(this.id, this.name, this.isComplete);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'isComplete': isComplete,
    };
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isComplete = map['isComplete'];
  }
}
