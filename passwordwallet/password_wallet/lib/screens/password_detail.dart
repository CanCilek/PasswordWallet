import 'package:flutter/material.dart';
import 'package:password_wallet/data/dbHelper.dart';
import 'package:password_wallet/models/password.dart';

class PasswordDetail extends StatefulWidget {
  Password password;
  PasswordDetail(this.password);
  @override
  State<StatefulWidget> createState() {
    return _PasswordDetailState(password);
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

enum Options { delete, update }

class _PasswordDetailState extends State {
  Password password;
  _PasswordDetailState(this.password);

  var dbHelper = DbHelper();
  var txtPlatformName = TextEditingController();
  var txtUserName = TextEditingController();
  var txtPassword = TextEditingController();

  void initState() {
    txtPlatformName.text = password.platformName;
    txtUserName.text = password.userName;
    txtPassword.text = password.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getCustomAppBar(),
      body: buildPasswordDetail(),
    );
  }

  buildPasswordDetail() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("lib/images/social.jpg"),width: 250,height: 250,)
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child:Container(
                      margin: EdgeInsets.only(left: 20.0,top: 20.0),
                      child:buildPlatformName()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child:Container(
                      margin: EdgeInsets.only(left: 20.0,top: 20.0),
                      child:buildUserName()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child:Container(
                      margin: EdgeInsets.only(left: 20.0,top: 20.0),
                      child:buildPassword()),
                ),
              ],
            ),

          ],
        ),
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

  void selectedProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(password.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Password.withId(
            id: password.id,
            platformName: txtPlatformName.text,
            userName: txtUserName.text,
            password: txtPassword.text));
        Navigator.pop(context, true);
        break;
      default:
    }
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(""),
            Text("PASSWORD WALLET",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
            PopupMenuButton<Options>(
              color: Colors.red,
              icon: Icon(Icons.edit_location_outlined,color: Colors.red,),
              onSelected: selectedProcess,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                PopupMenuItem<Options>(
                  value: Options.delete,
                  child: Text("Sil"),
                ),
                PopupMenuItem(value: Options.update, child: Text("Güncelle")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
