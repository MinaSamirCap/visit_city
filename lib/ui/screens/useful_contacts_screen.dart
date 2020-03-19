import 'package:flutter/material.dart';

import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class UsefulContactsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/useful-contacts';
  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.USEFUL_CONTACTS)),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              ListTile(
                title: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Emergency Numbers',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ambulance: 123',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Police: 122',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Fire Brigade: 180',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Public Transportation Services',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Cairo Old Airport Information: 265-5000/265-3333/265-3413/14/15',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Cairo New Airport: 265-2029/265-2222/265-2436',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Cairo Air Information: 635-0270/635-0260',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Railway Information: 575-3555',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Egyptian Company for Navigation: 575-9058/575-9166',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Public Utility Services',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Electricity Emergency: 121',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Natural Gas: 129',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Water: 575-0059/575-7416',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Public Call Services',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Telephone Number Assistance: 140/141',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Telephone Billing Inquires: 177',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Central Operator Information: 142',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Telephone Complaints: 16',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'International Calls Information: 120',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'Telephone Trouble Shooting: 188',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                        Text(
                          'International Calls Billing Inquires: 09002222',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Coolor.GREY,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
