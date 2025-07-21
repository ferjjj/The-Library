import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String uid;
  final String librarianId;
  final String bookId;
  final String title;
  final String author;
  final String yearPublished;
  final String dateBorrowed;
  final String dateToReturn;
  final bool isActive;
  final String? resolvedDate;

  const TransactionModel(
      {required this.id,
      required this.uid,
      required this.librarianId,
      required this.bookId,
      required this.title,
      required this.author,
      required this.yearPublished,
      required this.dateBorrowed,
      required this.dateToReturn,
      required this.isActive,
      required this.resolvedDate});

  toJson() {
    return {
      "id": this.id,
      "uid": this.uid,
      "librarianId": this.librarianId,
      "bookId": this.bookId,
      "title": this.title,
      "author": this.author,
      "yearPublished": this.yearPublished,
      "dateBorrowed": this.dateBorrowed,
      "dateToReturn": this.dateToReturn,
      "isActive": this.isActive,
      "resolvedDate": this.resolvedDate
    };
  }

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TransactionModel(
      id: data["id"],
      uid: data["uid"],
      librarianId: data["librarianId"],
      bookId: data["bookId"],
      title: data["title"],
      author: data["author"],
      yearPublished: data["yearPublished"],
      dateBorrowed: data["dateBorrowed"],
      dateToReturn: data["dateToReturn"],
      isActive: data["isActive"],
      resolvedDate: data["resolvedDate"] == null ? "" : data["resolvedDate"],
    );
  }
}
