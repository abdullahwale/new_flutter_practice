import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Users.dart';
import 'Academy.dart';

class Services {
  //http://192.168.43.97/EmployeesDB/employee_actions.php
  //http://localhost/EmployeesDB/employee_actions.php
  static const ROOT = 'http://172.31.64.1/AcademyDB/actions.php';
  static const String _GET_ACTION = 'USER_AUTH';
  static const String _GET_ALL = 'GET_ACADEMY';
  static const String _ADD_Academy = 'ADD_ACADEMY';
  static const String _GET_TEACHERS = 'GET_TEACHERS';
  static const String _ADD_Teacher = 'ADD_TEACHER';
  static const String _GET_STUDENTS = 'GET_STUDENTS';
  static const String _ADD_student = 'ADD_STUDENT';
  static const String _GET_UNPAID = 'GET_UNPAID';
  static const String _GET_PAID = 'GET_PAID';
  static const String _GET_COURSE = 'GET_COURSE';
  static const String _GET_CLASS = 'GET_CLASS';
  static const String _ADD_COURSE = 'ADD_COURSE';
  static const String _GET_MANAGER = 'GET_MANAGER';
  static const String _ADD_MANAGER = 'ADD_MANAGER';
  static const String _GET_CITY = 'GET_CITY';
  static const String _GET_DETAIL = 'GET_DETAIL';
  static const String _GET_ACADEMYNAME = 'GET_ACADEMYNAME';

  static Future<List> getdata() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ALL;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getTeachers(String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_TEACHERS;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getdetail(String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_DETAIL;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getManager(String role, String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_MANAGER;
      map["role"] = role;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getStudents(String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_STUDENTS;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List<Academy>> getCity() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_CITY;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Academy> list = parse(response.body);
        return list;
      } else {
        throw List<Academy>();
      }
    } catch (e) {
      return List<Academy>();
    }
  }

  static Future<List<Academy>> getAcademy(String city) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACADEMYNAME;
      map["city"] = city;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Academy> list = parse(response.body);
        return list;
      } else {
        throw List<Academy>();
      }
    } catch (e) {
      return List<Academy>();
    }
  }

  static Future<List> getUnpaid(String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_UNPAID;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getPaid(String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_PAID;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getCourse(String academy, String selected) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_COURSE;
      map["academy_name"] = academy;
      map["slected"] = selected;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List> getClass(String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_CLASS;
      map["academy_name"] = academy;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      return List<User>();
    }
  }

  static Future<String> addManager(
      String username, String password, String role, String academyname) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_MANAGER;
      map["academy_name"] = academyname;
      map["role"] = role;
      map["user_email"] = username;
      map["user_pass"] = password;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addacademy(String academyname, String address,
      String username, String password) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_Academy;
      map["academy_name"] = academyname;
      map["address"] = address;
      map["role"] = "Owner";
      map["user_email"] = username;
      map["user_pass"] = password;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addTeacher(
      String name, String subject, String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_Teacher;
      map["Teacher_name"] = name;
      map["subject"] = subject;
      map["academy"] = academy;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addCourse(
      String name, String subject, String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_COURSE;
      map["course_name"] = name;
      map["subject"] = subject;
      map["academy"] = academy;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addStudent(String roll, String name, String class_name,
      String address, String phone, String academy) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_student;
      map["roll"] = roll;
      map["Student_name"] = name;
      map["class"] = class_name;
      map["address"] = address;
      map["phone"] = phone;
      map["academy"] = academy;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<User>> login(
      String email, String pass, String role) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map["user_email"] = email;
      map["user_pass"] = pass;
      map["user_role"] = role;
      final response = await http.post(ROOT, body: map);
      print(response.body);
      print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }

  static List<Academy> parse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Academy>((json) => Academy.fromJson(json)).toList();
  }

  static List<User> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
