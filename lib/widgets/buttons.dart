import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/screens/search_screen/controllers/search_controller.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:the_library/widgets/dialogs.dart';

class MaterialButtonIcon extends StatelessWidget {
  const MaterialButtonIcon({
    super.key,
    this.height,
    this.width,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.buttonColor,
    this.highlightColor,
    this.splashColor,
    this.borderRadius,
    required this.onTap,
    this.iconPadding,
    this.withIcon = true,
    this.withText = false,
    this.text,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.buttonPadding,
    this.iconTextDistance,
    this.fontFamily,
    this.isHorizontal = true,
    this.iconIsSVG,
    this.svgIcon,
    this.withShadow,
    this.withOutline,
  });

  final double? height;
  final double? width;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? highlightColor;
  final Color? splashColor;
  final BorderRadius? borderRadius;
  final VoidCallback onTap;
  final EdgeInsets? iconPadding;
  final EdgeInsets? buttonPadding;
  final bool? withIcon;
  final bool? withText;
  final String? text;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? iconTextDistance;
  final String? fontFamily;
  final bool? isHorizontal;
  final bool? iconIsSVG;
  final String? svgIcon;
  final bool? withShadow;
  final bool? withOutline;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: withShadow ?? false
          ? mediumGray.withOpacity(0.25)
          : Colors.transparent,
      color: buttonColor ?? primaryBlue,
      borderRadius: borderRadius ?? BorderRadius.circular(height ?? 30),
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(height ?? 30),
        onTap: onTap,
        splashColor: splashColor ?? lightGrey.withOpacity(0.25),
        highlightColor: highlightColor ?? lightGrey.withOpacity(0.25),
        child: Container(
            height: height,
            width: width,
            padding: buttonPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(height ?? 30),
                border: withOutline ?? false
                    ? Border.all(color: fontColor ?? primaryBlue, width: 2.0)
                    : null),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: isHorizontal ?? true
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (withIcon ?? true)
                          Padding(
                            padding: iconPadding ?? EdgeInsets.all(0),
                            child: Icon(
                              icon,
                              size: iconSize ?? 25,
                              color: iconColor ?? pureWhite,
                            ),
                          ),
                        if (withText ?? false)
                          Container(
                            padding:
                                EdgeInsets.only(left: iconTextDistance ?? 0),
                            child: Text(
                              text ?? "",
                              style: fontFamily == null
                                  ? GoogleFonts.poppins(
                                      fontSize: fontSize ?? 16,
                                      color: fontColor ?? pureWhite,
                                      fontWeight: fontWeight ?? FontWeight.w600)
                                  : TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: fontSize ?? 16,
                                      color: fontColor ?? pureWhite,
                                      fontWeight:
                                          fontWeight ?? FontWeight.w600),
                            ),
                          )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (withIcon ?? true)
                          Padding(
                            padding: iconPadding ?? EdgeInsets.all(0),
                            child: Icon(
                              icon,
                              size: iconSize ?? 25,
                              color: iconColor ?? pureWhite,
                            ),
                          ),
                        if (withText ?? false)
                          Container(
                            padding:
                                EdgeInsets.only(top: iconTextDistance ?? 0),
                            child: Text(
                              text ?? "",
                              style: fontFamily == null
                                  ? GoogleFonts.poppins(
                                      fontSize: fontSize ?? 16,
                                      color: fontColor ?? pureWhite,
                                      fontWeight: fontWeight ?? FontWeight.w600)
                                  : TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: fontSize ?? 16,
                                      color: fontColor ?? pureWhite,
                                      fontWeight:
                                          fontWeight ?? FontWeight.w600),
                            ),
                          )
                      ],
                    ),
            )),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.controller,
  });

  final SearchWordController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: pureWhite,
          boxShadow: [lightShadow()]),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(
          Icons.search,
          size: 30.0,
          color: primaryYellow,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(child: SearchField(controller: controller))
      ]),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
  });

  final SearchWordController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: TextField(
          controller: controller.searchBoxController,
          style: TextStyle(fontSize: 18, color: muteBlack),
          decoration: InputDecoration.collapsed(hintText: "Search"),
          onChanged: (value) => controller.searchWord(value),
        ));
  }
}

class SearchFilter extends StatelessWidget {
  const SearchFilter({
    super.key,
    required this.controller,
  });

  final SearchWordController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          searchFilterDialog(context: context, controller: controller);
        },
        child: Icon(
          Icons.manage_search_rounded,
          size: 30,
          color: pureWhite,
        ),
      ),
    );
  }
}

void searchFilterDialog(
    {required BuildContext context, required SearchWordController controller}) {
  showInfoDialog(
    context: context,
    title: "Search filter",
    width: min(400, MediaQuery.of(context).size.width),
    childWidget: Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "SEARCH BY",
              style: GoogleFonts.poppins(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: lightGrey,
            ),
            SizedBox(
              height: 5,
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 15,
              runSpacing: 5,
              children: [
                for (var option in {
                  "Title": "title",
                  "Author": "author",
                  "Genre": "genre",
                  "Year": "year",
                  "Synopsis": "synopsis",
                }.entries)
                  FilterOption(
                      controller: controller,
                      label: option.key,
                      refVal: option.value)
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ]),
    ),
  );
}

class FilterOption extends StatelessWidget {
  const FilterOption({
    super.key,
    required this.controller,
    required this.label,
    required this.refVal,
  });

  final SearchWordController controller;
  final String label;
  final String refVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      child: Column(children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: primaryBlue),
        ),
        SizedBox(
          height: 5,
        ),
        Obx(
          () => FlutterSwitch(
            padding: 2,
            width: 55,
            height: 30,
            valueFontSize: 12,
            toggleSize: 26,
            value: refVal == "title"
                ? controller.searchInTitle.value
                : refVal == "author"
                    ? controller.searchInAuthor.value
                    : refVal == "genre"
                        ? controller.searchInGenre.value
                        : refVal == "year"
                            ? controller.searchInYear.value
                            : refVal == "synopsis"
                                ? controller.searchInSynopsis.value
                                : false,
            borderRadius: 30,
            showOnOff: true,
            onToggle: (value) {
              refVal == "title"
                  ? controller.searchInTitle.value
                  : refVal == "author"
                      ? controller.searchInAuthor.value
                      : refVal == "genre"
                          ? controller.searchInGenre.value
                          : refVal == "year"
                              ? controller.searchInYear.value
                              : refVal == "synopsis"
                                  ? controller.searchInSynopsis.value
                                  : null;
            },
            activeColor: primaryBlue,
          ),
        )
      ]),
    );
  }
}

class OrSeparator extends StatelessWidget {
  const OrSeparator({
    super.key,
    this.lineWidth,
    this.fontSize,
    this.color,
    this.fontWeight,
    required this.text,
    this.textStyle,
  });

  final double? lineWidth;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: lineWidth ?? 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color ?? primaryBlue,
          ),
        )),
        Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ??
              GoogleFonts.poppins(
                  fontSize: fontSize ?? 15,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: color ?? primaryBlue),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: lineWidth ?? 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color ?? primaryBlue,
          ),
        )),
      ],
    );
  }
}
