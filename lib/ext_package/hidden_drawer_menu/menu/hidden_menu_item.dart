import 'package:edumarshal/ext_package/hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:flutter/material.dart';

class HiddenMenuItem extends StatelessWidget {
  /// name of the menu item
  final String name;

  /// callback to receive action click in item
  final GestureTapCallback? onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle? baseStyle;

  /// style to apply to text when item is selected
  final TextStyle? selectedStyle;

  final bool selected;

  final TypeOpen typeOpen;

  const HiddenMenuItem({
    Key? key,
    required this.name,
    this.onTap,
    required this.colorLineSelected,
    this.baseStyle,
    this.selectedStyle,
    required this.selected,
    required this.typeOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            if (typeOpen == TypeOpen.fromLeft)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
                child: Container(
                  height: 40.0,
                  color: selected ? colorLineSelected : Colors.transparent,
                  width: 5.0,
                ),
              ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: typeOpen == TypeOpen.fromLeft ? 20 : 0.0,
                  right: typeOpen == TypeOpen.fromRight ? 20 : 0.0,
                ),
                child: Text(
                  name,
                  style: _getStyle().merge(_getStyleSelected()),
                  textAlign: typeOpen == TypeOpen.fromRight
                      ? TextAlign.right
                      : TextAlign.left,
                ),
              ),
            ),
            if (typeOpen == TypeOpen.fromRight)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
                child: Container(
                  height: 40.0,
                  color: selected ? colorLineSelected : Colors.transparent,
                  width: 5.0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  TextStyle? _getStyleSelected() {
    return selected
        ? selectedStyle ?? const TextStyle(color: Colors.white)
        : null;
  }

  TextStyle _getStyle() {
    return baseStyle ?? const TextStyle(color: Colors.grey, fontSize: 25.0);
  }
}
