import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/models/transaction_model.dart';
import 'package:the_library/models/user_model.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/database_repository.dart';
import 'package:the_library/widgets/dialogs.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  late TextEditingController userID, bookID;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  Rx<DateTime> dateToReturn = DateTime.now().obs;
  RxList<BookModel> listBooks = <BookModel>[].obs;
  RxString user = "".obs;

  @override
  void onInit() {
    super.onInit();
    userID = TextEditingController();
    bookID = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    userID.dispose();
    bookID.dispose();
  }

  void chooseDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: dateToReturn.value,
        firstDate: DateTime(2024),
        lastDate: DateTime(2034));
    if (newDate != null) {
      dateToReturn.value = newDate;
    }
  }

  Future checkoutBooks(BuildContext context) async {
    DateTime timeNow = DateTime.now();
    String dateTodayStr = DateFormat('MM/dd/yyyy').format(timeNow);
    String dateToReturnStr =
        DateFormat('MM/dd/yyyy').format(dateToReturn.value);
    int finish = 0;
    if (userModel.value != null &&
        listBooks.length > 0 &&
        dateToReturn.value.isAfter(timeNow)) {
      showLoaderDialog(context: context);
      for (BookModel book in listBooks) {
        try {
          TransactionModel trans = new TransactionModel(
              id: ApplicationController.instance.uuid.v1(),
              uid: userModel.value!.uid,
              librarianId: ApplicationController.instance.loggedInUser!.uid,
              bookId: book.id,
              title: book.title,
              author: book.author,
              yearPublished: book.yearPublished,
              dateBorrowed: dateTodayStr,
              dateToReturn: dateToReturnStr,
              isActive: true,
              resolvedDate: "");
          await DatabaseRepository.instance
              .createTransaction(trans)
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
              isAvailable: false);
          await DatabaseRepository.instance.updateBook(newBook);
        } catch (e) {
          ApplicationController.instance.errorSnackBar(
              title: "Error has occured",
              message: "Error occured on checking out ${book.title}");
        }
      }
      Navigator.of(context).pop();
      Get.back();
      ApplicationController.instance.successSnackBar(
          title: "Success",
          message: "Successfully checked out ${finish.toString()} book(s)");
    } else {
      Get.snackbar("Form error", "Please check your inputs before proceeding.");
    }
  }
}
