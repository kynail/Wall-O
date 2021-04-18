import 'package:flutter/material.dart';
import 'package:wallo_flutter/theme.dart';

void handleSnackBar(BuildContext context, String errorMessage,
    String successMessage, bool isError, bool isLoading) {
  print("CHANGE");

  if (isError == true) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 20),
          Expanded(child: Text(errorMessage)),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppTheme.errorColor,
    ));
  } else if (isError == false &&
      isLoading == false &&
      successMessage.length > 0) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 20),
          Expanded(child: Text(successMessage)),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.green,
    ));
  }
}
