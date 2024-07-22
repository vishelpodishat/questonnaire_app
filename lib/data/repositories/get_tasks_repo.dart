import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:questonnaire_app/data/models/survey_data_model.dart';
import 'package:questonnaire_app/data/models/tasks_data_model.dart';
import 'package:questonnaire_app/network/dio_settings.dart';

class GetTasksRepo {
  final Dio dio = DioSettings().dio;

  Future<TasksDataModel> getTasks() async {
    try {
      final Response responce = await dio
          .get('https://getquestionnairesendpoint-nfhw57yfsq-uc.a.run.app/');
      if (responce.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(responce.data);
        return TasksDataModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      print('Error $e');
      rethrow;
    }
  }

  Future<SurveyDataModel> getTasksById(String id) async {
    try {
      final Response response = await dio.get(
          'https://getquestionnairesendpoint-nfhw57yfsq-uc.a.run.app/?id=$id');
      if (response.statusCode == 200) {
        print(response.data);
        return SurveyDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load task by ID');
      }
    } catch (e) {
      print('Error $e');
      rethrow;
    }
  }
}
