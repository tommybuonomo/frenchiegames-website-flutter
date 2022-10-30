import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final GestureTapCallback? onTap;
  final TextStyle? style;
  final String text;
  final bool underline;

  const HoverText({Key? key, required this.text, this.onTap, this.style, this.underline = false}) : super(key: key);

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  double? _textWidth;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = _textKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _textWidth = renderBox.size.width;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hovered) {
        setState(() {
          _hovered = hovered;
        });
      },
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            key: _textKey,
            child: AnimatedScale(
              scale: _hovered ? 1.04 : 1.0,
              child: Text(widget.text, style: widget.style),
              duration: Duration(milliseconds: 100),
            ),
          ),
          _textWidth == null
              ? Container(width: 0,)
              : widget.underline
                  ? AnimatedContainer(
                      margin: EdgeInsets.only(top: 4),
                      duration: Duration(milliseconds: 100),
                      width: _hovered ? _textWidth! * 0.7 : _textWidth! * 0,
                      height: 2.0,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.0)),
                    )
                  : Container(width: 0,)
        ],
      ),
    );
  }
}
