import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../res/coolor.dart';

Widget lineDivider() {
  return Container(
    color: Coolor.GREY,
    width: double.infinity,
    height: 2,
  );
}

SnackBar createSnackBar(String message) {
  return SnackBar(content: Text(message));
}

void showSnackBar(SnackBar snackBar, GlobalKey<ScaffoldState> key){
  key.currentState.showSnackBar(snackBar);
}
