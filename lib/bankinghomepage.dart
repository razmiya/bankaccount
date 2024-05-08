
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankingHomePage extends StatefulWidget {
  @override
  _BankingHomePageState createState() => _BankingHomePageState();
}

class _BankingHomePageState extends State<BankingHomePage> {
  BankAccount _bankAccount = BankAccount(
    accountNumber: 123456789, // You can generate a random number here
    accountHolder: 'Rose Mary',
    balance: 100000,
  );

  TextEditingController _amountController = TextEditingController();

  void _deposit(double amount) {
    setState(() {
      _bankAccount.deposit(amount);
    });
  }

  void _withdraw(double amount) {
    setState(() {
      _bankAccount.withdraw(amount, context);
    });
  }

  void _showAccountInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Account Number: ${_bankAccount.accountNumber}'),
              Text('Account Holder: ${_bankAccount.accountHolder}'),
              Text('Current Balance: \$${_bankAccount.balance.toStringAsFixed(2)}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('BANKING APP'),
        centerTitle: true,backgroundColor: Colors.cyan, ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(style: TextStyle(color: Colors.white),
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'please enter the amount to deposit or withdrowel!'
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    double amount = double.tryParse(_amountController.text) ?? 0.0;
                    _deposit(amount);
                    _amountController.clear();
                  },
                  child: Text('Deposit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double amount = double.tryParse(_amountController.text) ?? 0.0;
                    _withdraw(amount);
                    _amountController.clear();
                  },
                  child: Text('Withdraw'),
                ),
              ],
            ),
             SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showAccountInfo();
              },
              child: Text('Account Info'),
            ),
          ],
        ),
      ),
    );
  }
}

class BankAccount {
  int accountNumber;
  String accountHolder;
  double balance;

  BankAccount({
    required this.accountNumber,
    required this.accountHolder,
    required this.balance,
  });

  void deposit(double amount) {
    balance += amount;
  }

  void withdraw(double amount, BuildContext context) {
    if (amount <= balance) {
      balance -= amount;
    } else {
      // Show insufficient balance message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Insufficient Balance'),
            content: Text('You do not have enough balance to withdraw \$${amount.toStringAsFixed(2)}.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}