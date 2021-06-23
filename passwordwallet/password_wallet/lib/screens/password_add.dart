import 'package:flutter/material.dart';
import 'package:password_wallet/data/dbHelper.dart';
import 'package:password_wallet/models/password.dart';

class PasswordAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasswordAddState();
  }
}

class FlutterColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  FlutterColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class _PasswordAddState extends State {
  var dbHelper = DbHelper();
  var txtPlatformName = TextEditingController();
  var txtUserName = TextEditingController();
  var txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: getCustomAppBar(),
        body: buildBody(),
      ),
    );
  }

  Widget buildPlatformName() {
    return TextField(
      style: TextStyle(color: Colors.red),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1)),
        icon: Icon(
          Icons.play_arrow,
          color: Colors.red,
        ),
        labelText: "Platform Adı",
        labelStyle: TextStyle(color: Colors.red),
      ),
      controller: txtPlatformName,
    );
  }

  Widget buildUserName() {
    return TextField(
      style: TextStyle(color: Colors.red),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1)),
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.red,
        ),
        labelText: "Kullanıcı Adı",
        labelStyle: TextStyle(color: Colors.red),
      ),
      controller: txtUserName,
    );
  }

  Widget buildPassword() {
    return TextField(
      style: TextStyle(color: Colors.red),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1)),
        icon: Icon(
          Icons.add_moderator,
          color: Colors.red,
        ),
        labelText: "Şifre",
        labelStyle: TextStyle(color: Colors.red),
      ),
      controller: txtPassword,
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      onPressed: () {
        addPassword();
        setState(() {});
      },
      color: Colors.red,
      elevation: 15,
      textColor: Colors.black87,
      child: Text(
        "Yeni Platform Ekle",
        style: TextStyle(fontSize: 25.0, color: Colors.black87),
      ),
    );
  }

  void addPassword() async {
    var result = await dbHelper.insert(Password(
        platformName: txtPlatformName.text,
        userName: txtUserName.text,
        password: txtPassword.text));
    setState(() {
      Navigator.pop(context, true);
    });
  }

  getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.red,
              FlutterColor("1e1e1e"),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("PASSWORD WALLET",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image(
                image: AssetImage("lib/images/social.jpg"),
                width: 150,
                height: 150,
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: buildPlatformName()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: buildUserName()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: buildPassword()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: buildSubmitButton()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
