class Todo {
  int id;
  String title;
  String content;
  String date;
  int isChecked;

  Todo({this.id, this.title, this.content, this.date, this.isChecked = 0});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = json["date"];
    isChecked = json["isChecked"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["title"] = title;
    map["content"] = content;
    map["date"] = date;
    map["isChecked"] = isChecked;

    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

}