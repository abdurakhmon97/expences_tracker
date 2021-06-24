
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> trList;
  final Function removeItem;

  TransactionList(this.trList, this.removeItem);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('\$${trList[index].amount}'),
                ),
              ),
            ),
            title: Text(
              trList[index].title,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(trList[index].date),
            ),
            trailing:
                FlatButton.icon(
                    onPressed: () {removeItem(trList[index].id);},
                    icon: Icon(Icons.delete),
                    textColor: Colors.red,
                    label: Text('Delete')),
          ),
        );
      },
      itemCount: trList.length,
    );
  }
}
