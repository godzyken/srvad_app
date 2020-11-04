import 'package:flutter/material.dart';

class UserInfoEntity with ChangeNotifier {
  final String givenName;
  final String email;
  final String mobileNumber;
  final String familyName;
  final String sub;
  final String picture;
  final String uid;
  final String userRole;

  UserInfoEntity(
      {this.email,
      this.givenName,
      this.mobileNumber,
      this.familyName,
      this.sub,
      this.picture,
      this.uid,
      this.userRole});

  UserInfoEntity.fromJson(Map<String, dynamic> parsedJson)
      : sub = parsedJson['sub'],
        givenName = parsedJson['given_name'],
        email = parsedJson['email'],
        familyName = parsedJson['family_name'],
        picture = parsedJson['picture'],
        uid = parsedJson['uid'],
        mobileNumber = parsedJson['mobile_number'],
        userRole = parsedJson['user_role'];

  Map<String, dynamic> toJson() => {
        'sub': sub,
        'given_name': givenName,
        'family_name': familyName,
        'email': email,
        'picture': picture,
        'mobile_number': mobileNumber,
        'user_role': userRole,
        'uid': uid,
      };

  @override
  String toString() => "User<$givenName:$email:$picture:$userRole:$uid>";
}
