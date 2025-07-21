import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/utils/constants/colors.dart';

Future<dynamic> showInfoDialog(
    {required BuildContext context,
    String? title,
    required Widget childWidget,
    Widget? bottomWidget,
    VoidCallback? onClose,
    double? width,
    bool scrollable = true,
    Color boxColor = pureWhite}) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: boxColor, borderRadius: BorderRadius.circular(30.0)),
                margin: EdgeInsets.only(right: 12, top: 12),
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (title != null)
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 70),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0))),
                        child: Text(
                          title,
                          style: GoogleFonts.robotoSlab(
                              fontSize: 24,
                              color: pureWhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    Flexible(
                      child: scrollable
                          ? SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: childWidget,
                            )
                          : childWidget,
                    ),
                    bottomWidget != null
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: bottomWidget,
                          )
                        : Container()
                  ],
                ),
              ),
              Positioned(
                right: 0.0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Feedback.forTap(context);
                      if (onClose != null) {
                        onClose();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 18.0,
                        backgroundColor:
                            title == null ? primaryBlue : pureWhite,
                        child: Icon(Icons.close,
                            color: title == null ? pureWhite : primaryBlue),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ).animate().scale(duration: 300.ms, curve: Curves.bounceOut);
      });
}

Future<dynamic> showLoaderDialog(
    {required BuildContext context, String? text}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                height: 70,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: pureWhite),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: primaryBlue,
                        strokeWidth: 6.0,
                      ),
                    ),
                    if (text != null)
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          style: GoogleFonts.poppins(
                              height: 1.1,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryBlue),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
