import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expenses/models/months.dart';
import 'package:personal_expenses/screens/tarnsaction_screen.dart';
import 'package:personal_expenses/screens/user_profile.dart';
import 'package:personal_expenses/widgets/master_card.dart';
import 'package:personal_expenses/widgets/upcoming_payments.dart';
import 'package:provider/provider.dart';
import '../models/user_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userForm = Provider.of<UserDetail>(context);
    final userProfile = userForm.userdetail;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 31, 49, 37),
                    Color.fromARGB(255, 31, 25, 25),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 0.2]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userProfile.username}',
                            style: const TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.w600),
                          ),
                          Text('Welcome Back'),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30,
                        child: userProfile.image == null
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Add photo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 9),
                                ),
                              ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  userProfile.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                MasterCard(
                  cardHolder: userProfile.holderName,
                  cardNumber: userProfile.cardNumber,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${userProfile.balance}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Upcoming payments',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    UpcomingPayments(
                      icon: const Icon(
                        Icons.email_outlined,
                        size: 40,
                      ),
                      amount: 2000,
                      title: 'Salary',
                      subtitle: 'Belong interactive',
                    ),
                    UpcomingPayments(
                      icon: Container(
                        height: 40,
                        width: 50,
                        child: SvgPicture.asset(
                          'assets/icons/2959755_money_paypal_transfer_icon.svg',
                          color: Colors.white,
                        ),
                      ),
                      amount: 45,
                      title: 'Paypal',
                      subtitle: 'Freelance payment',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            setState(() {
              _selectedIndex = i;
              if (_selectedIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => Months(),
                      child: TransactionSceen(),
                    ),
                  ),
                );
                _selectedIndex = 0;
              }
            });
            if (_selectedIndex == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                      saveForm: userForm.AddDetails,
                      user: userForm.userdetail,
                      updateImage: userForm.UpdateImage),
                ),
              );
            }
            _selectedIndex = i;
          },
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 30.0,
          items: [
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  backgroundColor: Colors.lightGreen[500],
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
              title: SizedBox(
                height: 0,
              ),
              icon: Icon(
                Icons.home_outlined,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  backgroundColor: Colors.lightGreen[500],
                  child: Icon(
                    Icons.bolt,
                    color: Colors.white,
                  )),
              title: SizedBox(
                height: 0,
              ),
              icon: Icon(Icons.bolt_outlined),
            ),
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  backgroundColor: Colors.lightGreen[500],
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
              title: SizedBox(
                height: 0,
              ),
              icon: Icon(Icons.person_outline),
            ),
            BottomNavigationBarItem(
              activeIcon: CircleAvatar(
                  backgroundColor: Colors.lightGreen[500],
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
              title: SizedBox(
                height: 0,
              ),
              icon: Icon(Icons.notifications_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
