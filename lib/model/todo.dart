class Todo {
  int id;
  String title;
  String content;
  String date;

  Todo({this.id, this.title, this.content, this.date});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["title"] = title;
    map["content"] = content;
    map["date"] = date;

    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

}