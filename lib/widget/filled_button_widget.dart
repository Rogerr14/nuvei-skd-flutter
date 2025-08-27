import 'package:flutter/material.dart';
class FilledButtonWidget extends StatefulWidget {

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? textButtonColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? fontFamily;

  const FilledButtonWidget({
    super.key,
    this.onPressed,
    this.color,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 5,
    this.textButtonColor, 
    this.fontWeight = FontWeight.w400, 
    this.fontSize, 
    this.fontFamily,
    });

  @override
  State<FilledButtonWidget> createState() => _FilledButtonWidgetState();
}

class _FilledButtonWidgetState extends State<FilledButtonWidget> {
  @override
  Widget build(BuildContext context) {
    // final responsive = Responsive(context);
    
    return FilledButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(
            Size(widget.width!, widget.height!)
            ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( widget.borderRadius!)
              
              ),
        ),
        backgroundColor:
            WidgetStatePropertyAll(widget.color ?? Colors.black),
      ),
      onPressed:widget.onPressed,
      child: Text(widget.text,
          style: TextStyle(
              color: widget.textButtonColor ?? Colors.white,
              fontWeight: widget.fontWeight,
              fontFamily: widget.fontFamily,
              fontSize: widget.fontSize  ?? 15
              ),
          textAlign: TextAlign.center),
    );
  }
}