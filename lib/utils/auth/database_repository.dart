import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/models/transaction_model.dart';
import 'package:the_library/models/user_model.dart';
import 'package:the_library/utils/application_controller.dart';

class DatabaseRepository extends GetxController {
  static DatabaseRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future createUser(UserModel user) async {
    await _db
        .collection("Users")
        .doc(user.uid)
        .set(user.toJson())
        .whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully created user for ${user.email}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.errorSnackBar(
          title: "Something wrong occurred",
          message: "Unable to create user for ${user.email}.");
      print(err.toString());
    });
  }

  Future createBook(BookModel book) async {
    await _db
        .collection("Books")
        .doc(book.id)
        .set(book.toJson())
        .whenComplete(() {
      // ApplicationController.instance.successSnackBar(
      //     title: "Success",
      //     message: "Successfully created book ${book.title}.");
    }).catchError((err, stackTrace) {
      // ApplicationController.instance.errorSnackBar(
      //     title: "Something wrong occurred", message: "Unable to create book.");
      print(err.toString());
    });
  }

  Future createTransaction(TransactionModel transaction) async {
    await _db
        .collection("Transactions")
        .doc(transaction.id)
        .set(transaction.toJson())
        .catchError((err, stackTrace) {
      ApplicationController.instance.errorSnackBar(
          title: "Something wrong occurred",
          message: "Unable to create transaction.");
      print(err.toString());
    });
  }

  Future getUserInfo(String uid) async {
    final snapshot =
        await _db.collection("Users").where("uid", isEqualTo: uid).get();
    final userData = snapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .single;
    return userData;
  }

  Future getAllUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .toList();
    return userData;
  }

  Future getSpecificBook(String id) async {
    final snapshot =
        await _db.collection("Books").where("id", isEqualTo: id).get();
    final bookData = snapshot.docs
        .map(
          (e) => BookModel.fromSnapshot(e),
        )
        .single;
    return bookData;
  }

  Future getAllBooks() async {
    final snapshot = await _db.collection("Books").get();
    final bookData = snapshot.docs
        .map(
          (e) => BookModel.fromSnapshot(e),
        )
        .toList();
    return bookData;
  }

  Future getSpecificTransaction(String id) async {
    final snapshot =
        await _db.collection("Transactions").where("id", isEqualTo: id).get();
    final transData = snapshot.docs
        .map(
          (e) => TransactionModel.fromSnapshot(e),
        )
        .single;
    return transData;
  }

  Future getAllTransactionByUser(String uid) async {
    final snapshot =
        await _db.collection("Transactions").where("uid", isEqualTo: uid).get();
    final transData = snapshot.docs
        .map(
          (e) => TransactionModel.fromSnapshot(e),
        )
        .toList();
    return transData;
  }

  // Future getAllTransactionByBook(String bookId) async {
  //   final snapshot = await _db
  //       .collection("Transactions")
  //       .where("bookId", isEqualTo: bookId)
  //       .get();
  //   final transData = snapshot.docs
  //       .map(
  //         (e) => TransactionModel.fromSnapshot(e),
  //       )
  //       .toList();
  //   return transData;
  // }

  Future getAllTransactions() async {
    final snapshot = await _db.collection("Transactions").get();
    final transData = snapshot.docs
        .map(
          (e) => TransactionModel.fromSnapshot(e),
        )
        .toList();
    return transData;
  }

  Future getCategories() async {
    final snapshot = await _db.collection("Default").doc("Categories").get();
    final categ = snapshot.data();
    return categ;
  }

  Future updateUser(UserModel user) async {
    await _db
        .collection("Users")
        .doc(user.uid)
        .update(user.toJson())
        .whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message:
              "Successfully updated user ${user.firstName} ${user.lastName}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.successSnackBar(
          title: "Error",
          message: "Unable to update user ${user.firstName} ${user.lastName}.");
      print(err.toString());
    });
  }

  Future updateCategories(Map<String, dynamic> list) async {
    await _db
        .collection("Default")
        .doc("Categories")
        .update(list)
        .whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success", message: "Successfully updated categories.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.successSnackBar(
          title: "Error", message: "Unable to update categories.");
      print(err.toString());
    });
  }

  Future updateBook(BookModel book) async {
    await _db
        .collection("Books")
        .doc(book.id)
        .update(book.toJson())
        .whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully updated book entitled ${book.title}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.errorSnackBar(
          title: "Something wrong occurred",
          message: "Unable to update book entitled ${book.title}.");
      print(err.toString());
    });
  }

  Future updateTransaction(TransactionModel trans) async {
    await _db
        .collection("Transactions")
        .doc(trans.id)
        .update(trans.toJson())
        .whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully updated transaction ${trans.id}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.errorSnackBar(
          title: "Something wrong occurred",
          message: "Unable to update transaction ${trans.id}.");
      print(err.toString());
    });
  }

  Future deleteUser(UserModel user) async {
    await _db.collection("Users").doc(user.uid).delete().whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message:
              "Successfully deleted user ${user.firstName} ${user.lastName}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.successSnackBar(
          title: "Error",
          message: "Unable to delete user ${user.firstName} ${user.lastName}.");
      print(err.toString());
    });
  }

  Future deleteBook(BookModel book) async {
    await _db.collection("Books").doc(book.id).delete().whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully deleted book ${book.title}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.errorSnackBar(
          title: "Something wrong occurred",
          message: "Unable to delete book ${book.title}.");
      print(err.toString());
    });
  }

  Future deleteTransaction(TransactionModel trans) async {
    await _db
        .collection("Transactions")
        .doc(trans.id)
        .delete()
        .whenComplete(() {
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully deleted transaction ${trans.id}.");
    }).catchError((err, stackTrace) {
      ApplicationController.instance.errorSnackBar(
          title: "Something wrong occurred",
          message: "Unable to delete transaction ${trans.id}.");
      print(err.toString());
    });
  }
}
