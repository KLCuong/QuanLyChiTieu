import 'package:flutter/cupertino.dart';
import 'package:quanlychitieu/utils/app_fonts.dart';

class CustomConfirmDialog {
  static Future<void> show(
      BuildContext context, {
        required String title,
        required String content,
        required VoidCallback onYes,
        String yesText = 'Yes',
        String noText = 'No',
        bool barrierDismissible = false,
      }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: AppFonts.beVietnamSemiBold18,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            content,
            style: AppFonts.beVietnamRegular16,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              noText,
              style: AppFonts.beVietnamRegular16,
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              onYes();
            },
            child: Text(
              yesText,
              style: AppFonts.beVietnamRegular16,
            ),
          ),
        ],
      ),
    );
  }
}
