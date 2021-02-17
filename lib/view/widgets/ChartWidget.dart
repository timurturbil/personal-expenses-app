import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/view/model/productModel.dart';
import 'package:personal_expenses_app/view/widgets/chart_Bar.dart';

class Chart extends StatefulWidget {
  final List<ProductModel> recentTransactions;
  
  const Chart({Key key, this.recentTransactions}) : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (int i = 0; i < widget.recentTransactions.length; i++) {
        if (widget.recentTransactions[i].date.day == weekDay.day &&
            widget.recentTransactions[i].date.month == weekDay.month &&
            widget.recentTransactions[i].date.year == weekDay.year) {
          totalAmount += widget.recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    double totalSum = 0.0;
    for (int i = 0; i < groupedTransactionValues.length; i++) {
      totalSum += groupedTransactionValues[i]['amount'];
    }
    return totalSum;
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'],
              data['amount'],
              totalSpending == 0.0
                  ? 0.0
                  : (data['amount'] as double) / totalSpending,
            ),
          );
        }).toList(),
      ),
    );
  }
}
