import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/screens/checkout_screen/controllers/return_controller.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';
import 'package:the_library/widgets/buttons.dart';
import 'package:the_library/widgets/card_widgets.dart';
import 'package:the_library/widgets/dialogs.dart';

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({super.key});

  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  final qrRet = GlobalKey(debugLabel: "QR");
  QRViewController? qrController;

  @override
  void dispose() {
    super.dispose();
    qrController?.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrController!.pauseCamera();
    }
    qrController!.resumeCamera();
  }

  Future<String?> showQRScanner(
      {required BuildContext context, required Size size}) async {
    String? valRet;
    RxString qrValue = "".obs;
    await showInfoDialog(
        context: context,
        width: min(size.width - 60, 400),
        childWidget: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "SCAN BOOK QR",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: lightGrey),
                ),
              ),
              Container(
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: QRView(
                  key: qrRet,
                  onQRViewCreated: (qrCtl) async {
                    setState(() {
                      this.qrController = qrCtl;
                    });
                    await qrCtl.scannedDataStream.listen((qr) {
                      if (qr.code != null) {
                        setState(() {
                          qrValue.value = qr.code ?? "";
                        });
                      }
                    });
                  },
                  overlay: QrScannerOverlayShape(
                      borderLength: 20,
                      borderWidth: 10,
                      borderRadius: 20,
                      borderColor: primaryBlue,
                      cutOutSize: 300 * 0.8),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${qrValue.value}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: mediumGray),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: MaterialButtonIcon(
                  icon: Icons.check,
                  withText: true,
                  text: "USE CODE",
                  onTap: () {
                    valRet = qrValue.value;
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ));
    return valRet;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final controller = Get.put(ReturnController());

    return Padding(
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Container(
              width: size.width,
              height: 90,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Get.back();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        color: primaryYellow,
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                        ),
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: 90,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "RETURN",
                          style: GoogleFonts.poppins(
                            color: lightGrey,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 40,
                          child: Image.asset(
                            iTheLibraryBrowse,
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          radius: Radius.circular(20),
                          padding: EdgeInsets.all(15),
                          strokeWidth: 3,
                          dashPattern: [10, 10],
                          color: lightGrey.withOpacity(0.5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Books to resolve",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: lightGrey),
                              ),
                              Obx(
                                () => controller.listBooks.length == 0
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: Text(
                                          "NONE",
                                          style: GoogleFonts.poppins(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: mediumGray),
                                        ),
                                      )
                                    : Obx(
                                        () => ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          itemCount:
                                              controller.listBooks.length,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Dismissible(
                                                key: ValueKey(
                                                    controller.listBooks[i].id),
                                                background: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.all(30),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: lightGrey
                                                        .withOpacity(0.75),
                                                    size: 40,
                                                  ),
                                                ),
                                                secondaryBackground: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding: EdgeInsets.all(30),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: lightGrey
                                                        .withOpacity(0.75),
                                                    size: 40,
                                                  ),
                                                ),
                                                onDismissed: (_) {
                                                  controller.listBooks
                                                      .removeAt(i);
                                                  controller.listBooks
                                                      .refresh();
                                                },
                                                child:
                                                    HorizontalThreeLayerWidget(
                                                        image: controller
                                                            .listBooks[i]
                                                            .bookCover,
                                                        firstText: controller
                                                            .listBooks[i].title,
                                                        secondText: controller
                                                            .listBooks[i]
                                                            .author,
                                                        thirdText: controller
                                                            .listBooks[i].id),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                              Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          maxLines: 1,
                                          controller: controller.bookID,
                                          validator: (value) {
                                            if (value != null && value != "") {
                                              return null;
                                            }
                                            return "Invalid book ID";
                                          },
                                          style:
                                              GoogleFonts.poppins(fontSize: 18),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            prefixIcon: Icon(
                                              Icons.menu_book_rounded,
                                              color: primaryPink,
                                              size: 25,
                                            ),
                                            filled: true,
                                            fillColor:
                                                lightGrey.withOpacity(0.2),
                                            prefixIconConstraints:
                                                BoxConstraints(minWidth: 50),
                                            hintText: "Book ID",
                                            focusColor: primaryYellow,
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red.shade700),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 50,
                                        child: MaterialButtonIcon(
                                          onTap: () {
                                            BookModel? bookOnList = controller
                                                .listBooks
                                                .firstWhereOrNull((element) =>
                                                    element.id ==
                                                    controller.bookID.text
                                                        .trim());
                                            if (bookOnList == null) {
                                              final book = ApplicationController
                                                  .instance.listBooks
                                                  .firstWhereOrNull((element) =>
                                                      element.id ==
                                                      controller.bookID.text
                                                          .trim());
                                              if (book != null) {
                                                controller.listBooks.add(book);
                                                controller.bookID.clear();
                                                ApplicationController.instance
                                                    .successSnackBar(
                                                        title: "QR Imported",
                                                        message:
                                                            "Book ${book.title} added");
                                              } else {
                                                ApplicationController.instance
                                                    .errorSnackBar(
                                                        title:
                                                            "Unable to find book",
                                                        message:
                                                            "Book ID must be wrong or book does not exist.");
                                              }
                                            } else {
                                              ApplicationController.instance
                                                  .errorSnackBar(
                                                      title:
                                                          "Unable to add book",
                                                      message:
                                                          "Book is already in return list.");
                                            }
                                          },
                                          icon: Icons.add,
                                          buttonColor: primaryPink,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 50,
                                        child: MaterialButtonIcon(
                                          onTap: () async {
                                            var qrValue = await showQRScanner(
                                                context: context, size: size);
                                            if (qrValue != null) {
                                              BookModel? bookOnList = controller
                                                  .listBooks
                                                  .firstWhereOrNull((element) =>
                                                      element.id ==
                                                      qrValue.trim());
                                              if (bookOnList == null) {
                                                final book =
                                                    ApplicationController
                                                        .instance.listBooks
                                                        .firstWhereOrNull(
                                                            (element) =>
                                                                element.id ==
                                                                qrValue.trim());
                                                if (book != null) {
                                                  controller.listBooks
                                                      .add(book);
                                                  ApplicationController.instance
                                                      .successSnackBar(
                                                          title: "QR Imported",
                                                          message:
                                                              "Book ${book.title} added");
                                                } else {
                                                  ApplicationController.instance
                                                      .errorSnackBar(
                                                          title:
                                                              "Unable to find book",
                                                          message:
                                                              "Book ID must be wrong or book does not exist.");
                                                }
                                              } else {
                                                ApplicationController.instance
                                                    .errorSnackBar(
                                                        title:
                                                            "Unable to add book",
                                                        message:
                                                            "Book is already in return list.");
                                              }
                                            }
                                          },
                                          icon: Icons.qr_code_scanner_rounded,
                                          buttonColor: primaryGreen,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: MaterialButtonIcon(
                          onTap: () {
                            controller.returnBooks(context);
                          },
                          icon: Icons.menu_book_rounded,
                          withText: true,
                          text: "RETURN BOOKS",
                          buttonColor: primaryBlue,
                          iconTextDistance: 10,
                          fontSize: 20,
                        ),
                      )
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
