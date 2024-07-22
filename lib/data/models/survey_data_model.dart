class SurveyDataModel {
  String? message;
  SurveyData? data;

  SurveyDataModel({this.message, this.data});

  SurveyDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? SurveyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SurveyData {
  String? id;
  List<Pages>? pages;

  SurveyData({this.id, this.pages});

  SurveyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (pages != null) {
      data['pages'] = pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  String? question;
  String? type;
  String? image;
  List<String>? options;

  Pages({this.question, this.type, this.image, this.options});

  Pages.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    type = json['type'];
    image = json['image'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['type'] = type;
    data['image'] = image;
    data['options'] = options;
    return data;
  }
}
