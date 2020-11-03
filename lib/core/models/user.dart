class User {
  final String displayName;
  final String email;
  final String photoURL;
  final String uid;
  final String userRole;


  User({this.displayName,
    this.email,
    this.photoURL,
    this.uid,
    this.userRole
    });


  User.fromJson(Map<String, dynamic> parsedJson)
      : displayName = parsedJson['displayName'],
        email = parsedJson['email'],
        photoURL = parsedJson['photoURL'],
        uid = parsedJson['uid'],
        userRole = parsedJson['userRole'];


  @override
  String toString() => "User<$displayName:$email:$photoURL:$userRole:$uid>";
}