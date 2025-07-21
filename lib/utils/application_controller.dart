import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/models/transaction_model.dart';
import 'package:the_library/models/user_model.dart';
import 'package:the_library/utils/auth/database_repository.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:uuid/uuid.dart';

class ApplicationController extends GetxController {
  static ApplicationController get instance => Get.find();

  final Connectivity connectivity = Connectivity();

  var uuid = Uuid();

  @override
  void onInit() async {
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      hasConnection.value = false;
    } else {
      hasConnection.value = true;
    }
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      hasConnection.value = false;
      connectionSnackBar();
    } else {
      hasConnection.value = true;
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
    }
  }

  // -- USER MANAGEMENT
  UserModel? loggedInUser;
  List<UserModel> listUsers = [];
  List<TransactionModel> userActiveTransactions = [];
  List<TransactionModel> userAllTransactions = [];
  List<TransactionModel> listTransactions = [];
  List<BookModel> listBooks = [];
  List<String> popularBooks = [];
  List<String> featuredBooks = [];
  List<String> newBooks = [];

  Future updateTransactions() async {
    listTransactions.clear();

    var tempTrans = await DatabaseRepository.instance.getAllTransactions();
    for (TransactionModel trans in tempTrans) {
      listTransactions.add(trans);
    }
    listTransactions.sort((a, b) => a.dateBorrowed.compareTo(b.dateBorrowed));

    this.refresh();
  }

  Future updateUserTransactions(String userUid) async {
    userActiveTransactions.clear();
    userAllTransactions.clear();

    var tempTrans = await DatabaseRepository.instance.getAllTransactions();

    for (TransactionModel trans in tempTrans) {
      if (trans.uid.trim() == userUid.trim()) {
        userAllTransactions.add(trans);
        if (trans.isActive == true) {
          userActiveTransactions.add(trans);
        }
      }
    }
    userAllTransactions
        .sort((a, b) => a.dateBorrowed.compareTo(b.dateBorrowed));
    userActiveTransactions
        .sort((a, b) => a.dateBorrowed.compareTo(b.dateBorrowed));

    this.refresh();
  }

  Future updateBooks() async {
    listBooks.clear();
    var tempBooks = await DatabaseRepository.instance.getAllBooks();
    for (BookModel book in tempBooks) {
      listBooks.add(book);
    }
    listBooks.sort((a, b) => a.title.compareTo(b.title));

    this.refresh();
  }

  Future updateUsers() async {
    listUsers.clear();
    var tempUsers = await DatabaseRepository.instance.getAllUsers();
    for (UserModel user in tempUsers) {
      listUsers.add(user);
    }
    listUsers.sort((a, b) => a.firstName.compareTo(b.firstName));

    this.refresh();
  }

  Future updateCategories() async {
    popularBooks.clear();
    featuredBooks.clear();
    newBooks.clear();
    var tempCateg = await DatabaseRepository.instance.getCategories();
    var tempFeatured = tempCateg["featured"];
    var tempNew = tempCateg["new"];
    var tempPopular = tempCateg["popular"];
    for (String text in tempFeatured) {
      featuredBooks.add(text);
    }
    for (String text in tempNew) {
      newBooks.add(text);
    }
    for (String text in tempPopular) {
      popularBooks.add(text);
    }
    this.refresh();
  }

  // -- CONNECTION MANAGEMENT
  late StreamSubscription subscription;
  RxBool hasConnection = false.obs;

  void connectionSnackBar() {
    final message = hasConnection.value
        ? "Connected to the internet."
        : "Disconnected from the internet.";
    final color = hasConnection.value
        ? Colors.green.withOpacity(0.75)
        : Colors.redAccent.withOpacity(0.75);
    final icon = hasConnection.value ? Icons.wifi : Icons.wifi_off;
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: GoogleFonts.poppins(color: pureWhite, fontSize: 14),
      ),
      backgroundColor: color,
      icon: Icon(
        icon,
        color: pureWhite,
        size: 30,
      ),
      duration: Duration(seconds: 3),
      shouldIconPulse: true,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 20,
    );
  }

  void successSnackBar({required title, required message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: pureWhite,
        backgroundColor: primaryBlue.withOpacity(0.75),
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        icon: Icon(
          Icons.check_circle_outline,
          color: pureWhite,
          size: 30,
        ));
  }

  void errorSnackBar({required title, required message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: pureWhite,
        backgroundColor: Colors.redAccent.withOpacity(0.75),
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        icon: Icon(
          Icons.error_outline,
          color: pureWhite,
          size: 30,
        ));
  }
}
