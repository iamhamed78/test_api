// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dio/dio.dart';

class StudentData {
  final int id;
  final String firstName;
  final String lastNmae;
  final String course;
  final int score;
  final String createdAt;
  final String updatedAt;

  StudentData(this.id, this.firstName, this.lastNmae, this.course, this.score,
      this.createdAt, this.updatedAt);

  StudentData.fromjson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastNmae = json['last_name'],
        course = json['course'],
        score = json['score'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];
}

class HttpClient {
  static Dio instance =
      Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'));
}

Future<List<StudentData>> getStudents() async {
  final response = await HttpClient.instance.get('experts/student');

  final List<StudentData> students = [];
  if (response.data is List<dynamic>) {
    (response.data as List<dynamic>).forEach((element) {
      students.add(StudentData.fromjson(element));
    });
  }
  return students;
}

Future<StudentData> saveStudent(
    String firstName, String lastName, String course, int score) async {
  final response = await HttpClient.instance.post('experts/student', data: {
    "first_name": firstName,
    "last_name": lastName,
    "course": course,
    "score": score
  });
  if (response.statusCode == 200) {
    return StudentData.fromjson(response.data);
  } else {
    throw Exception();
  }
}
