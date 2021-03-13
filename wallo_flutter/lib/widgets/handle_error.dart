import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/theme.dart';

void handleError(BuildContext context, UserState userState) {
  if (userState.isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 20),
          Text(userState.errorMessage),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppTheme().errorColor,
    ));
  }
}
