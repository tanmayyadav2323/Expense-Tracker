import 'dart:io';

import 'package:flutter/material.dart';

import 'package:personal_expenses/models/user_detail.dart';
import 'package:personal_expenses/widgets/image_input.dart';

class UserProfile extends StatefulWidget {
  Function saveForm;
  User user;
  Function updateImage;
  UserProfile({
    Key? key,
    required this.saveForm,
    required this.user,
    required this.updateImage,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void _saveForm() {
    widget.saveForm(widget.user);
    Navigator.of(context).pop();
  }

  void _selectImage(File pickedImage) {
    widget.user.image = pickedImage;
  }

  final _form1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
              onPressed: () {
                _form1.currentState?.save();
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black54,
            height: size.height / 2,
            width: double.infinity,
            child: Form(
              key: _form1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  isAlwaysShown: true,
                  radius: Radius.circular(10),
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: widget.user.username,
                        decoration: InputDecoration(label: Text('Username')),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          widget.user = User(
                              id: '',
                              username: value!,
                              balance: widget.user.balance,
                              cardNumber: widget.user.cardNumber,
                              image: widget.user.image,
                              holderName: widget.user.holderName,
                              income: widget.user.income);
                        },
                      ),
                      TextFormField(
                        initialValue: widget.user.balance.toString(),
                        decoration: InputDecoration(label: Text('Balance')),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          widget.user = User(
                              id: '',
                              username: widget.user.username,
                              balance: int.parse(value!),
                              cardNumber: widget.user.cardNumber,
                              image: widget.user.image,
                              holderName: widget.user.holderName,
                              income: widget.user.income);
                        },
                      ),
                      TextFormField(
                        initialValue: widget.user.cardNumber.toString(),
                        decoration: InputDecoration(label: Text('Card Number')),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          widget.user = User(
                              id: '',
                              username: widget.user.username,
                              balance: widget.user.balance,
                              cardNumber: int.parse(value!),
                              image: widget.user.image,
                              holderName: widget.user.holderName,
                              income: widget.user.income);
                        },
                      ),
                      TextFormField(
                        initialValue: widget.user.holderName,
                        decoration: InputDecoration(label: Text('Holder Name')),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          widget.user = User(
                              id: '',
                              username: widget.user.username,
                              balance: widget.user.balance,
                              cardNumber: widget.user.cardNumber,
                              image: widget.user.image,
                              holderName: value!,
                              income: widget.user.income);
                        },
                      ),
                      TextFormField(
                        initialValue: widget.user.income.toString(),
                        decoration: InputDecoration(label: Text('Income')),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          widget.user = User(
                              id: '',
                              username: widget.user.username,
                              balance: widget.user.balance,
                              cardNumber: widget.user.cardNumber,
                              image: widget.user.image,
                              holderName: widget.user.holderName,
                              income: int.parse(value!));
                        },
                        onFieldSubmitted: (_) {
                          _form1.currentState?.save();
                          _saveForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: size.height / 2,
            color: Colors.black,
            child: ImageInput(
                image: widget.user.image,
                savedImage: _selectImage,
                updateImage: widget.updateImage),
          )
        ],
      ),
    );
  }
}
