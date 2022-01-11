import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/models/months.dart';
import 'package:personal_expenses/widgets/drop_down.dart';
import 'package:personal_expenses/widgets/drop_down_new.dart';
import 'package:personal_expenses/widgets/graph_learn.dart';
import 'package:personal_expenses/screens/payments.dart';
import 'package:provider/provider.dart';

class TransactionSceen extends StatefulWidget {
  TransactionSceen({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionSceen> createState() => _TransactionSceenState();
}

class _TransactionSceenState extends State<TransactionSceen> {
  bool arrow_down = false;
  var transaction = Transactions(
      id: DateTime.now().toString(),
      title: "",
      subtitle: "",
      amount: 0,
      month: "");
  int _selectedIndex = 0;
  void ChangeMonth(int index) {
    _selectedIndex = index;
  }

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var transactionDone = Provider.of<Months>(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 10),
                  color: Colors.black,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 500,
                            child: DropDownNew(
                              months: transactionDone.months,
                              ChangeMonth: ChangeMonth,
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (val) {
                              transaction = Transactions(
                                  id: DateTime.now().toString(),
                                  title: val!,
                                  subtitle: transaction.subtitle,
                                  amount: transaction.amount,
                                  month:
                                      transactionDone.months[_selectedIndex]);
                            },
                            decoration: InputDecoration(label: Text("Title")),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (val) {
                              transaction = Transactions(
                                  id: DateTime.now().toString(),
                                  title: transaction.title,
                                  subtitle: val!,
                                  amount: transaction.amount,
                                  month:
                                      transactionDone.months[_selectedIndex]);
                            },
                            decoration:
                                InputDecoration(label: Text("Subtitle")),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text("Amount"),
                            ),
                            onSaved: (val) {
                              transaction = Transactions(
                                  id: DateTime.now().toString(),
                                  title: transaction.title,
                                  subtitle: transaction.subtitle,
                                  amount: int.parse(val!),
                                  month:
                                      transactionDone.months[_selectedIndex]);
                            },
                            onFieldSubmitted: (_) {
                              _form.currentState?.save();
                              transactionDone.addTransaction(transaction);
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                _form.currentState?.save();
                                transactionDone.addTransaction(transaction);
                                Navigator.of(context).pop();
                              },
                              child: Text("Done")),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white70.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_vert))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Spending this month',
                      style: TextStyle(fontSize: 17, letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      '${transactionDone.totalAmount(transactionDone.index)}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('History'),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            arrow_down = !arrow_down;
                          });
                        },
                        child: Row(
                          children: [
                            arrow_down
                                ? Icon(Icons.arrow_drop_down)
                                : Icon(Icons.arrow_drop_up),
                            Consumer<Months>(builder: (ctx, month, _) {
                              return Text(month.months[month.index]);
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                  TransactionGraph(
                    arrow_down: arrow_down,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Payments(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionGraph extends StatelessWidget {
  bool arrow_down;
  TransactionGraph({
    Key? key,
    required this.arrow_down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalAmount = Provider.of<Months>(context);
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(top: 10),
            height: 300,
            width: 650,
            child: LineChart(
              LineChartData(
                axisTitleData: FlAxisTitleData(
                    bottomTitle:
                        AxisTitle(titleText: 'Months', showTitle: true),
                    leftTitle: AxisTitle(
                      titleText: 'Savings',
                      showTitle: true,
                    )),
                backgroundColor: Colors.black54,
                titlesData: LineTitles.getTitleData(),
                gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (val) {
                      return FlLine(color: Colors.lightBlue, strokeWidth: 1);
                    },
                    drawVerticalLine: true,
                    getDrawingVerticalLine: (value) {
                      return FlLine(color: Colors.lightBlue, strokeWidth: 1);
                    }),
                borderData: FlBorderData(
                  border: Border.all(color: Colors.blue),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0,
                          double.parse(totalAmount.totalAmount(0).toString())),
                      FlSpot(1,
                          double.parse(totalAmount.totalAmount(1).toString())),
                      FlSpot(2,
                          double.parse(totalAmount.totalAmount(2).toString())),
                      FlSpot(3,
                          double.parse(totalAmount.totalAmount(3).toString())),
                      FlSpot(4,
                          double.parse(totalAmount.totalAmount(4).toString())),
                      FlSpot(5,
                          double.parse(totalAmount.totalAmount(5).toString())),
                      FlSpot(6,
                          double.parse(totalAmount.totalAmount(6).toString())),
                      FlSpot(7,
                          double.parse(totalAmount.totalAmount(7).toString())),
                      FlSpot(8,
                          double.parse(totalAmount.totalAmount(8).toString())),
                      FlSpot(9,
                          double.parse(totalAmount.totalAmount(9).toString())),
                      FlSpot(10,
                          double.parse(totalAmount.totalAmount(10).toString())),
                      FlSpot(11,
                          double.parse(totalAmount.totalAmount(11).toString())),
                    ],
                    isCurved: true,
                    colors: [Colors.deepPurple, Colors.blueGrey],
                    barWidth: 5,
                    belowBarData: BarAreaData(
                      colors: [
                        Colors.white.withOpacity(0.4),
                        Colors.lightBlueAccent.withOpacity(0.3)
                      ],
                      show: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        arrow_down
            ? Positioned(
                right: 5,
                child: Container(
                  color: Colors.black54,
                  child: DropDown(),
                  height: 300,
                  width: 35,
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }
}
