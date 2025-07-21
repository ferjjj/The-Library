import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/utils/application_controller.dart';

class SearchWordController extends GetxController {
  static SearchWordController get instance => Get.find();

  late BuildContext context;

  final appController = Get.find<ApplicationController>();

  late TextEditingController searchBoxController;

  RxBool searchInTitle = true.obs;
  RxBool searchInAuthor = true.obs;
  RxBool searchInGenre = true.obs;
  RxBool searchInYear = true.obs;
  RxBool searchInSynopsis = false.obs;
  RxBool isAscending = true.obs;
  RxBool loading = false.obs;

  RxList<BookModel> suggestionList = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    suggestionList.value = appController.listBooks;
    searchBoxController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    searchBoxController.dispose();
  }

  void searchWord(String input) {
    if (input != "") {
      loading.value = true;
      List<BookModel> tempList = [];
      String query = input.toLowerCase().trim();
      for (BookModel entry in appController.listBooks) {
        if (searchInTitle.value) {
          String normalized = entry.title.toLowerCase().trim();
          if (normalized.contains(query)) {
            tempList.add(entry);
            continue;
          }
        }
        if (searchInAuthor.value) {
          String normalized = entry.author.toLowerCase().trim();
          if (normalized.contains(query)) {
            tempList.add(entry);
            continue;
          }
        }
        if (searchInGenre.value) {
          String normalized = entry.genre.join(" ").toLowerCase().trim();
          if (normalized.contains(query)) {
            tempList.add(entry);
            continue;
          }
        }
        if (searchInYear.value) {
          String normalized = entry.yearPublished.toLowerCase().trim();
          if (normalized.contains(query)) {
            tempList.add(entry);
            continue;
          }
        }
        if (searchInSynopsis.value) {
          String normalized = entry.synopsis.toLowerCase().trim();
          if (normalized.contains(query)) {
            tempList.add(entry);
            continue;
          }
        }
      }
      tempList.sort((a, b) => a.title.compareTo(b.title));
      suggestionList.value = tempList;
      this.update();
      if (suggestionList.length == 0) {
        Future.delayed(Duration(seconds: 3), () {
          loading.value = false;
        });
      }
    } else {
      suggestionList.value = appController.listBooks;
    }
  }
}
