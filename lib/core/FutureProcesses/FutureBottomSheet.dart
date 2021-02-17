import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:personal_expenses_app/view/model/productModel.dart';

class After {
  TextEditingController textController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime newdate;

  Future showMyDialog(context, productList) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(hintText: "title"),
                ),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(hintText: "amount"),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 228,
                    ),
                    FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2020, 3, 5),
                              maxTime: DateTime(2022, 6, 7), onConfirm: (date) {
                            newdate = date;
                          }, currentTime: DateTime.now(), locale: LocaleType.tr);
                        },
                        child: Text("Choose Date"))
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 205,
                    ),
                    FlatButton(
                        onPressed: () {
                          ProductModel ek = ProductModel(
                              title: textController.text,
                              amount: double.tryParse(amountController.text),
                              date: newdate);
                          return Navigator.pop(context, ek);
                        },
                        child: Text("Add Transaction"))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
