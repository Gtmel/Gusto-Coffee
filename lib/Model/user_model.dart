class UserModel {
  String? uid;
  String? firstName;
  String? secondName;
  String? email;
  String? password;
  String? passswordConfirm;

  UserModel({
    this.uid,
    this.firstName,
    this.secondName,
    this.email,
    this.password,
    this.passswordConfirm,
  });

  factory UserModel.toMap(Map) {
    return UserModel(
      uid: Map['uid'],
      firstName: Map['firstName'],
      secondName: Map['secondName'],
      email: Map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
    };
  }
}
