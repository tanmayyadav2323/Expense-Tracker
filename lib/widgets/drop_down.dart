import 'package:flutter/material.dart';
import 'package:personal_expenses/models/months.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  DropDown({Key? key}) : super(key: key);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    final _months = Provider.of<Months>(context).months;
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              Provider.of<Months>(context, listen: false).ChangeIndex(index);
            });
          },
          child: Column(
            children: [Text(_months[index]), const Divider()],
          ),
        );
      },
      itemCount: _months.length,
    );
  }
}
