import 'package:flutter/material.dart';
import 'package:password_wallet/screens/password_list.dart';

void main() {
  runApp(PasswordWallet());
}

class PasswordWallet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PasswordList(),
    );
  }

}
