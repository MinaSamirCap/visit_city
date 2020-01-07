import 'package:flutter/material.dart';
import '../../res/assets_path.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';

import 'filter_widget.dart';

class ExploreWidget extends StatefulWidget {
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  AppLocalizations _appLocal;

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coolor.FEEDBACK_OFF_WHITE,
        bottom: FilterWidget(FilterItem.getFilterList(_appLocal)),
        title: searchWidget(),
      ),
      body: Container(
        child: Center(
          child: Text("Explore"),
        ),
      ),
    );
  }

  Widget searchWidget() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: 1,
      minLines: 1,
      decoration:
          InputDecoration(icon: Icon(Icons.search), labelText: "search"),
    );
  }
}
