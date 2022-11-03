import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AlertAction { cancel, ok }

Future<AlertAction?> confirmDialog(BuildContext context, String message) async {
  return showDialog<AlertAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0.sp))),
        title: Row(
          children: [
            Text('Confirm!',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(
              Icons.info,
              size: 25.sp,
              color: Theme.of(context).disabledColor,
            ),
          ],
        ),
        content: Text(
          message.toString(),
        ),
        actions: <Widget>[
          TextButton(
            // style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all(Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.of(context).pop(AlertAction.cancel);
            },
            child: const Text(
              "CANCEL",
            ),
          ),
          TextButton(
            // style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all(Colors.grey.shade400)),
            onPressed: () {
              Navigator.of(context).pop(AlertAction.ok);
            },
            child: const Text(
              "OK",
            ),
          ),
        ],
      );
    },
  );
}
