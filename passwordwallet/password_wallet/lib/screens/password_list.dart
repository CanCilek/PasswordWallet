import 'package:flutter/material.dart';
import 'package:password_wallet/data/dbHelper.dart';
import 'package:password_wallet/models/password.dart';
import 'package:password_wallet/screens/password_add.dart';
import 'package:password_wallet/screens/password_detail.dart';


class PasswordList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasswordListState();
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

class _PasswordListState extends State {
  //final AdvertService _advertService = AdvertService();
  var dbHelper = DbHelper();
  List<Password> password;
  int passwordCount = 0;

  @override
  void initState() {
    getPassword();
    //_advertService.showBanner();
    super.initState();
  }

//Icon(Icons.add_circle_outline,color: Colors.black,size: 35.0,
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
          backgroundColor: Colors.transparent,
          //backgroundColor: Image.asset('lib/images/ekran.png').color,
          appBar: getCustomAppBar(),
          body: buildPasswordList(),
        ));
  }

  Widget buildPasswordList() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: passwordCount,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      color: Colors.transparent,
                      elevation: 25.0,
                      child: ListTile(
                        title: Text(this.password[position].platformName,
                            style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        onTap: () {
                          goToDetail(this.password[position]);
                        },
                      ),
                    );
                  }),
            ),
            Container(
              padding:
              EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red,),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(color: Colors.black,width: 2),
                ),
                onPressed: (){goToPasswordAdd(); setState(() {

                });},
                color: Colors.red,
                elevation: 15,
                textColor: Colors.black87,
                child: Text("Platform Ekle",style:
                TextStyle(fontSize: 25.0, color: Colors.black87),),

              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToPasswordAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PasswordAdd()));
    if (result != null) {
      if (result) {
        getPassword();
      }
    }
  }

  void getPassword() async {
    var passwordFuture = dbHelper.getPassword();
    passwordFuture.then((data) {
      setState(() {
        this.password = data;
        passwordCount = data.length;
      });
    });
  }

  void goToDetail(Password password) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => PasswordDetail(password)));
    if (result != null) {
      if (result) {
        getPassword();
      }
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
}
