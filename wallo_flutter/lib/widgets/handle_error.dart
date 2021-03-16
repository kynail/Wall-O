import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/theme.dart';

void handleError(BuildContext context, UserState userState) {
  print("CHANGE");
  print(userState);

  if (userState.isError == true) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Flexible(
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 20),
            Flexible(child: Text(userState.errorMessage)),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppTheme.errorColor,
    ));
  } else if (userState.isError == false &&
      userState.successMessage.length > 0) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 20),
          Flexible(child: Text(userState.successMessage)),
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
