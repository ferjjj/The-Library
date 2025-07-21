import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/widgets/dialogs.dart';

void showUserQR(
    {required BuildContext context,
    required Size size,
    required String userID}) {
  showInfoDialog(
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
                "CHECKOUT QR",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: lightGrey),
              ),
            ),
            Container(
              height: 300,
              child: QrImageView(
                // data: "8119d700-1fd6-1f84-a0f4-ddc7e48f142f",
                //75c6ab80-1fd6-1f84-a0f4-ddc7e48f142f
                //7d865000-1fd6-1f84-a0f4-ddc7e48f142f
                //8119d700-1fd6-1f84-a0f4-ddc7e48f142f
                data: userID,
                version: QrVersions.auto,
                size: 300,
                gapless: true,
                eyeStyle:
                    QrEyeStyle(eyeShape: QrEyeShape.circle, color: muteBlack),
                dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle,
                    color: muteBlack),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "USER ID",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: lightGrey),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                userID,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: muteBlack),
              ),
            )
          ],
        ),
      ));
}
