import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/core/FutureProcesses/FutureBottomSheet.dart';
import 'package:personal_expenses_app/view/model/productModel.dart';
import 'package:personal_expenses_app/view/widgets/ChartWidget.dart';
import 'package:personal_expenses_app/view/widgets/Customtile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> productList = [];
  List<ProductModel> get _recentProduction {
    return productList.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget  appBar = buildAppBar();
    return Scaffold(
      appBar: appBar,
      body: buildCenter(context, appBar),
      floatingActionButton: buildIconButton(context),
    );
  }

  AppBar buildAppBar() {
    return Platform.isIOS ? buildCupertinoNavigationBar() : buildAppBar2();
  }

  AppBar buildAppBar2() {
    return AppBar(
    title: Text("Personal Expenses"),
    actions: <Widget>[buildIconButton(context)],
  );
  }

  CupertinoNavigationBar buildCupertinoNavigationBar() {
    return CupertinoNavigationBar(
          middle: Text(
            'Personal Expenses',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => buildIconButton(context),
              ),
            ],
          ),
        );
  }

  Center buildCenter(BuildContext context, AppBar appBar) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(
                recentTransactions: _recentProduction,
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return CustomTile(
                      productList: productList,
                      index: index,
                      deleteItem: deleteitems,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  IconButton buildIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () => After().showMyDialog(context, productList).then((value) {
        setState(() {
          productList.add(value);
        });
        print(productList);
      }),
    );
  }

  IconButton deleteitems(List<ProductModel> productList, int index) {
    return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            productList.remove(productList[index]);
          });
        });
  }
}
