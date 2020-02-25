import 'package:flutter/material.dart';
import '../../res/sizes.dart';

class ExploreCellWidget extends StatelessWidget {
  final String cellTitle;
  final IconData cellIcon;
  final Function func;

  ExploreCellWidget(this.cellTitle, this.cellIcon, this.func);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Icon(cellIcon),
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
