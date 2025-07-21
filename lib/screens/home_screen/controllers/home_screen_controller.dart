import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  RxInt currentPage = 0.obs;
  PageController pageController = new PageController(initialPage: 0);
}
