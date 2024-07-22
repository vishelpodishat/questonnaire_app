class TasksDataModel {
  String? message;
  List<TasksData>? data;

  TasksDataModel({this.message, this.data});

  TasksDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TasksData>[];
      json['data'].forEach((v) {
        data!.add(TasksData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TasksData {
  String? id;
  String? title;
  String? tag;
  String? deadline;

  TasksData({this.id, this.title, this.tag, this.deadline});

  TasksData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tag = json['tag'];
    deadline = json['deadline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['tag'] = tag;
    data['deadline'] = deadline;
    return data;
  }
}
