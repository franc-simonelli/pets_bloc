// ignore_for_file: prefer_collection_literals

class LoggedUser {
  String? displayName;
  String? email;
  bool? emailVerified;
  String? photoURL;
  String? userId;
  String? userInitial;

  LoggedUser({
    this.displayName = "",
    this.email = "",
    this.emailVerified = false,
    this.photoURL = "",
    this.userId = '',
    this.userInitial = ''
  });

  LoggedUser.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    photoURL = json['photoURL'];
    userId = json['userId'];
    userInitial = json['userInitial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['displayName'] = displayName;
    data['email'] = email;
    data['emailVerified'] = emailVerified;
    data['photoURL'] = photoURL;
    data['userId'] = userId;
    data['userInitial'] = userInitial;
    return data;
  }
}