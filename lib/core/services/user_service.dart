import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:srvad_app/core/models/user_info_entity.dart';

class UserServices {
  static const ROOT = 'http://localhost/UserInfoEntityDB/user_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_USER_ACTION = 'ADD_USER ';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _DELETE_USER_ACTION = 'DELETE_USER';

  // Method to create table Users
  static Future<String> createTable() async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if(200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error : $e";
    }
  }

  static Future<List<UserInfoEntity>> getUsers() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Get list of users Response: ${response.body}');
      if(200 == response.statusCode) {
        List<UserInfoEntity> list = parseResponse(response.body);
        return list;
      } else {
        return List<UserInfoEntity>();
      }
    } catch (e) {
      return List<UserInfoEntity>();
    }
  }

  static List<UserInfoEntity> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<UserInfoEntity>((json) => UserInfoEntity.fromJson(json)).toList();
  }

  // Method to add UserInfo...
  static Future<String> addUser(String givenName, String familyName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['given_name'] = givenName;
      map['family_name'] = familyName;
      final response = await http.post(ROOT, body: map);
      print('Add a user Response: ${response.body}');
      if(200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an UserInfo on database
  static Future<String> updateUser(int userId, String givenName, String familyName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['user_id'] = userId;
      map['given_name'] = givenName;
      map['family_name'] = familyName;
      final response = await http.post(ROOT, body: map);
      print('Update user Response: ${response.body}');
      if(200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to delete an UserInfo on database
  static Future<String> deleteUser(int userId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_USER_ACTION;
      map['user_id'] = userId;
      final response = await http.post(ROOT, body: map);
      print('Delete an user Response: ${response.body}');
      if(200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}