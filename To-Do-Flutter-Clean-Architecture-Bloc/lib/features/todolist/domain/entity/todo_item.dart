import 'dart:convert';

class ToDoItem {
  int? id;
  String? title;
  String? description;
  bool? complete;
  String? created;

  ToDoItem({this.id, this.title, this.description, this.complete, this.created});

  ToDoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    complete = json['complete'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['complete'] = this.complete;
    data['created'] = this.created;
    return data;
  }

  ToDoItem copyWith({
    String? title,
    String? description,
    bool? complete,
  }) {
    return ToDoItem(
      title: title ?? this.title,
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }
}

class ToDoItemList {
  List<ToDoItem>? todoItems;

  ToDoItemList({this.todoItems});

  factory ToDoItemList.fromDynamicList(List<dynamic> list) {
    var toDolist = <ToDoItem>[];
    for (var item in list) {
      toDolist.add(ToDoItem.fromJson(item));
    }
    return ToDoItemList(todoItems: toDolist);
  }

  List<dynamic> toDynamicList() {
    var toDolist = [];
    for (var item in todoItems!) {
      toDolist.add(item.toJson());
    }
    return toDolist;
  }

  String toJson() {
    return jsonEncode(toDynamicList());
  }

  factory ToDoItemList.fromJson(String json) {
    return ToDoItemList.fromDynamicList(jsonDecode(json));
  }
}
