import 'package:flutter/material.dart';
import 'package:personal_expenses/models/months.dart';

class DropDownNew extends StatefulWidget {
  final List months;
  Function ChangeMonth;
  DropDownNew({
    Key? key,
    required this.months,
    required this.ChangeMonth,
  }) : super(key: key);
  @override
  _DropDownNewState createState() => _DropDownNewState();
}

class _DropDownNewState extends State<DropDownNew> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Material(
          type: MaterialType.transparency,
          child: IconButton(
            iconSize: 70,
            onPressed: () {
              setState(() {
                widget.ChangeMonth(index);
              });
            },
            splashColor: Colors.blue,
            splashRadius: 50,
            icon: CircleAvatar(
              radius: 50,
              child: Text(
                widget.months[index],
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              backgroundColor: Colors.white70,
            ),
          ),
        );
      },
      itemCount: widget.months.length,
    );
  }
}
