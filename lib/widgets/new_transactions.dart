import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addNewTransaction;

  NewTransactions(this.addNewTransaction);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitter() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  /*onChanged: (value) {
                            titleInput = value;
                          },*/
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: 'Amount'),
                  onSubmitted: (value) {
                    submitter();
                  }
                  /*onChanged: (value) {
                            amountInput = value;
                          },*/
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: presentDatePicker,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: RaisedButton(
                    textColor: Colors.purple,
                    onPressed: () {
                      submitter();
                      //FocusScope.of(context).requestFocus(FocusNode());
                      print(titleController.text);
                      print(amountController.text);
                      // titleController.clear();
                      // amountController.clear();
                    },
                    child: Text(
                      'Add transaction',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
