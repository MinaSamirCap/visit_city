import 'package:flutter/material.dart';
import '../../res/sizes.dart';

class ExploreCellWidget extends StatelessWidget {
  final String cellTitle;
  final IconData cellIcon;
  final Function func;
  final Color iconColor;

  ExploreCellWidget(this.cellTitle, this.cellIcon, this.func, {this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Icon(
            cellIcon,
            color: iconColor
          ),
          onTap: () {
            func();
          },
        ),
        Sizes.DIVIDER_HEIGHT_3,
        Text(cellTitle, style: actionStyleItem())
      ],
    );
  }

  TextStyle actionStyleItem() {
    return TextStyle(fontWeight: FontWeight.w700, fontSize: 15);
  }
}
