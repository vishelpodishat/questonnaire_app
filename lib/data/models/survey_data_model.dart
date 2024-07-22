import 'dart:convert';

SurveyDataModel surveyDataModelFromJson(String str) =>
    SurveyDataModel.fromJson(json.decode(str));

String surveyDataModelToJson(SurveyDataModel data) =>
    json.encode(data.toJson());

class SurveyDataModel {
  String message;
  Data data;

  SurveyDataModel({
    required this.message,
    required this.data,
  });

  factory SurveyDataModel.fromJson(Map<String, dynamic> json) =>
      SurveyDataModel(
        message: json["message"] as String,
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  List<Page> pages;

  Data({
    required this.id,
    required this.pages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
      };
}

class Page {
  String question;
  String type;
  String image;
  List<String> options;

  Page({
    required this.question,
    required this.type,
    required this.image,
    required this.options,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        question: json["question"],
        type: json["type"],
        image: json["image"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "type": type,
        "image": image,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

// class SurveyDataModel {
//   String? message;
//   SurveyData? data;

//   SurveyDataModel({this.message, this.data});

//   SurveyDataModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data = json['data'] != null ? SurveyData.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class SurveyData {
//   String? id;
//   List<Pages>? pages;

//   SurveyData({this.id, this.pages});

//   SurveyData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['pages'] != null) {
//       pages = <Pages>[];
//       json['pages'].forEach((v) {
//         pages!.add(Pages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     if (pages != null) {
//       data['pages'] = pages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Pages {
//   String? question;
//   String? type;
//   String? image;
//   List<String>? options;

//   Pages({this.question, this.type, this.image, this.options});

//   Pages.fromJson(Map<String, dynamic> json) {
//     question = json['question'];
//     type = json['type'];
//     image = json['image'];
//     options = json['options'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['question'] = question;
//     data['type'] = type;
//     data['image'] = image;
//     data['options'] = options;
//     return data;
//   }
// }
