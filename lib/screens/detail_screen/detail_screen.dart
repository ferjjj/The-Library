import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/models/transaction_model.dart';
import 'package:the_library/models/user_model.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/widgets/buttons.dart';
import 'package:the_library/widgets/card_widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.book});

  final BookModel book;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<TransactionModel> listTrans = [];

  @override
  void initState() {
    super.initState();
    var bookTrans = ApplicationController.instance.listTransactions
        .where((e) => e.bookId == widget.book.id);
    for (TransactionModel trans in bookTrans) {
      listTrans.add(trans);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Padding(
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(widget.book.bookCover),
                colorFilter: ColorFilter.mode(
                    pureWhite.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.cover,
              )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: size.width,
                    height: 70,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                  color: mediumGray,
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 30,
                                  ),
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {},
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  color: mediumGray,
                                  icon: Icon(
                                    Icons.bookmark_outline_rounded,
                                    size: 35,
                                  ),
                                ),
                              )),
                        ]),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Column(
                      children: [
                        Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: lightGrey.withOpacity(0.5),
                                image: DecorationImage(
                                    image: NetworkImage(widget.book.bookCover),
                                    fit: BoxFit.cover),
                                boxShadow: [lightShadow()]),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.book.title}",
                                    style: GoogleFonts.poppins(
                                      color: mediumGray,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                  ),
                                  Text(
                                    "${widget.book.author} (${widget.book.yearPublished})",
                                    style: GoogleFonts.poppins(
                                      color: mediumGray,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Genre: ${widget.book.genre.join(", ")}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: lightGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: MaterialButtonIcon(
                            onTap: () {},
                            withIcon: true,
                            withText: true,
                            text: "BOOK INFORMATION",
                            fontColor: mediumGray,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            icon: Icons.menu_book_rounded,
                            iconSize: 35,
                            iconColor: mediumGray,
                            buttonColor: Colors.transparent,
                            iconTextDistance: 10,
                            withOutline: true,
                            withShadow: false,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Status",
                            style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: primaryGreen,
                                height: 1.3),
                          ),
                          Text(
                            "${widget.book.isAvailable ? "Available" : "Borrowed"}",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: primaryYellow,
                                height: 1.3),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        "Synopsis/Summary",
                        style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: primaryPink,
                            height: 1.3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: pureWhite,
                          boxShadow: [lightShadow()]),
                      alignment: Alignment.topLeft,
                      child: ReadMoreText(
                        "${widget.book.synopsis}",
                        trimMode: TrimMode.Line,
                        trimLines: 4,
                        colorClickableText: primaryBlue,
                        trimCollapsedText: ' see more',
                        trimExpandedText: ' see less',
                        moreStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: primaryBlue,
                            height: 1.3),
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: mediumGray,
                            height: 1.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        "Checkout History",
                        style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: primaryYellow,
                            height: 1.3),
                      ),
                    ),
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
                          child: listTrans.length == 0
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "NONE",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: lightGrey),
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: min(listTrans.length, 3),
                                        itemBuilder: (context, i) {
                                          UserModel user = ApplicationController
                                              .instance.listUsers
                                              .firstWhere((e) =>
                                                  e.uid == listTrans[i].uid);
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: HorizontalThreeLayerWidget(
                                              image: user.isMale.toString(),
                                              firstText:
                                                  "${user.firstName} ${user.lastName}",
                                              secondText:
                                                  "${listTrans[i].dateBorrowed} to ${listTrans[i].dateToReturn} ",
                                              thirdText:
                                                  "${listTrans[i].isActive ? "Active" : "Resolved"}",
                                              onPress: () {},
                                              isBook: false,
                                            ),
                                          );
                                        }),
                                    if (listTrans.length > 3)
                                      ExpandChild(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: listTrans.length - 3,
                                            itemBuilder: (context, i) {
                                              int newI = i + 3;
                                              UserModel user =
                                                  ApplicationController
                                                      .instance.listUsers
                                                      .firstWhere((e) =>
                                                          e.uid ==
                                                          listTrans[newI].uid);
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child:
                                                    HorizontalThreeLayerWidget(
                                                  image: user.isMale.toString(),
                                                  firstText:
                                                      "${user.firstName} ${user.lastName}",
                                                  secondText:
                                                      "${listTrans[newI].dateBorrowed} to ${listTrans[newI].dateToReturn} ",
                                                  thirdText:
                                                      "${listTrans[newI].isActive ? "Active" : "Resolved"}",
                                                  onPress: () {},
                                                  isBook: false,
                                                ),
                                              );
                                            }),
                                      )
                                  ],
                                ),
                        )),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
