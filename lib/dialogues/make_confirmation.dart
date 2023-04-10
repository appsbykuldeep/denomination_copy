import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

/// Showing dialog for make confirmation in Yes/No
Future<bool> makeconfirmation({
  String? titel,
  String content = "Are you sure ?",
  bool focusonyes = true,
}) async {
  return await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.backgroundColor,
          title: Text(
            (titel ?? "Confirmation"),
            maxLines: 2,
            style: TextStyle(
              color: context.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            content,
            softWrap: true,
            maxLines: 3,
            style: const TextStyle(
              // color: context.backgroundColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'NO',
                style: TextStyle(
                  color: !focusonyes
                      ? Get.theme.primaryColor
                      : Get.theme.colorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: focusonyes
                      ? Get.theme.primaryColor
                      : Get.theme.colorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      });
}
