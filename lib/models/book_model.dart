import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String yearPublished;
  final String synopsis;
  final List<dynamic> genre;
  final String otherDetails;
  final String bookCover;
  final bool isAvailable;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.yearPublished,
    required this.synopsis,
    required this.genre,
    required this.otherDetails,
    required this.bookCover,
    required this.isAvailable,
  });

  toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "author": this.author,
      "yearPublished": this.yearPublished,
      "synopsis": this.synopsis,
      "genre": this.genre,
      "otherDetails": this.otherDetails,
      "bookCover": this.bookCover,
      "isAvailable": this.isAvailable
    };
  }

  factory BookModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BookModel(
        id: data["id"],
        title: data["title"],
        author: data["author"],
        yearPublished: data["yearPublished"],
        synopsis: data["synopsis"],
        genre: data["genre"],
        otherDetails: data["otherDetails"],
        bookCover: data["bookCover"],
        isAvailable: data["isAvailable"]);
  }
}
