import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCollapsiblePanel extends StatefulWidget {
  final String title;
  final Widget content;
  final Color headerBackgroundColor;
  final Color headerTextColor;

  CustomCollapsiblePanel({
    required this.title,
    required this.content,
    this.headerBackgroundColor = Colors.deepPurple,
    this.headerTextColor = Colors.white,
  });

  @override
  _CustomCollapsiblePanelState createState() => _CustomCollapsiblePanelState();
}

class _CustomCollapsiblePanelState extends State<CustomCollapsiblePanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            color: widget.headerBackgroundColor,
            child: Text(
              widget.title,
              style: TextStyle(color: widget.headerTextColor, fontSize: 18),
            ),
          ),
        ),
        if (_isExpanded) widget.content,
      ],
    );
  }
}
