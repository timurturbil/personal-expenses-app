import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/view/model/productModel.dart';

class CustomTile extends StatefulWidget {
  final List<ProductModel> productList;
  final int index;
  final Function deleteItem;
  const CustomTile({Key key, this.productList, this.index, this.deleteItem}) : super(key: key);

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    String newdate = DateFormat('yyyy-MM-dd').format(widget.productList[widget.index].date);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Text("\$${widget.productList[widget.index].amount}"),
            radius: 40.0,
            backgroundColor: Colors.brown,
          ),
          title: Text("${widget.productList[widget.index].title}"),
          subtitle: Text('$newdate'),
          trailing: widget.deleteItem(widget.productList, widget.index)
        ),
      ),
    );
  }
}
