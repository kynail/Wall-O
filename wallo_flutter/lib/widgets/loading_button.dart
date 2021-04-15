import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  LoadingButton(
      {Key key, this.style, this.child, this.isLoading = false, this.onPressed})
      : super(key: key);

  final ButtonStyle style;
  final Widget child;
  final bool isLoading;
  final Function onPressed;

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            style: widget.style != null
                ? widget.style
                : ElevatedButton.styleFrom(onPrimary: Colors.white),
            onPressed: widget.onPressed,
            child: widget.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : widget.child));
  }
}
