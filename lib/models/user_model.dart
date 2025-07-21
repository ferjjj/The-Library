import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String phoneNo;
  final String firstName;
  final String lastName;
  final bool isMale;
  final bool isLibrarian;

  const UserModel(
      {required this.uid,
      required this.email,
      required this.phoneNo,
      required this.firstName,
      required this.lastName,
      required this.isMale,
      required this.isLibrarian});

  toJson() {
    return {
      "uid": this.uid,
      "email": this.email,
      "phoneNo": this.phoneNo,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "isMale": this.isMale,
      "isLibrarian": this.isLibrarian
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        uid: data["uid"],
        email: data["email"],
        phoneNo: data["phoneNo"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        isMale: data["isMale"],
        isLibrarian: data["isLibrarian"]);
  }
}
