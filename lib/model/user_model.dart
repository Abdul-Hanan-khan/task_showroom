class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? phoneNumber;
  String? password;

  User({this.userId, this.firstName, this.lastName, this.userName, this.email,
  this.phoneNumber, this.password});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    email = json['email'];
    phoneNumber = json['phone_no'];
    password = json['password'];
  }
}
