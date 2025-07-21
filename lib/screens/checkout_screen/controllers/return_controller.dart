import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/models/transaction_model.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/database_repository.dart';
import 'package:the_library/widgets/dialogs.dart';

class ReturnController extends GetxController {
  static ReturnController get instance => Get.find();
  late TextEditingController bookID;
  RxList<BookModel> listBooks = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    bookID = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    bookID.dispose();
  }

  Future returnBooks(BuildContext context) async {
    DateTime timeNow = DateTime.now();
    String dateTodayStr = DateFormat('MM/dd/yyyy').format(timeNow);
    int finish = 0;
    if (listBooks.length > 0) {
      showLoaderDialog(context: context);
      for (BookModel book in listBooks) {
        TransactionModel? recentTrans =
            ApplicationController.instance.listTransactions.firstWhereOrNull(
                (e) => ((e.bookId == book.id) && (e.isActive == true)));
        if (recentTrans != null) {
          try {
            TransactionModel newTransaction = new TransactionModel(
                id: recentTrans.id,
                uid: recentTrans.uid,
                librarianId: recentTrans.librarianId,
                bookId: recentTrans.bookId,
                title: recentTrans.title,
                author: recentTrans.author,
                yearPublished: recentTrans.yearPublished,
                dateBorrowed: recentTrans.dateBorrowed,
                dateToReturn: recentTrans.dateToReturn,
                isActive: false,
                resolvedDate: dateTodayStr);
            await DatabaseRepository.instance
                .updateTransaction(newTransaction)
                .whenComplete(() {
              finish += 1;
            });
            BookModel newBook = new BookModel(
                id: book.id,
                title: book.title,
                author: book.author,
                yearPublished: book.yearPublished,
                synopsis: book.synopsis,
                genre: book.genre,
                otherDetails: book.otherDetails,
                bookCover: book.bookCover,
                isAvailable: true);
            await DatabaseRepository.instance.updateBook(newBook);
          } catch (e) {
            ApplicationController.instance.errorSnackBar(
                title: "Error has occured",
                message: "Error occured on checking out ${book.title}");
          }
        }
      }
      Navigator.of(context).pop();
      Get.back();
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully returned ${finish.toString()} book(s)");
    } else {
      Get.snackbar("Form error", "Please check your inputs before proceeding.");
    }
  }
}
