class Password{
  int id;
  String platformName;
  String userName;
  String password;

  Password({this.platformName,this.userName,this.password});

  Password.withId({this.id,this.platformName,this.userName,this.password});

  Map<String,dynamic> toMap() {
    var map = Map<String,dynamic>();
    map["platformName"] = platformName;
    map["userName"] = userName;
    map["password"] = password;
    if(id != null){
      map["id"] = id;
    }
    return map;

  }

  Password.fromObject(dynamic o){
    this.id = o["id"];
    this.platformName = o["platformName"];
    this.userName = o["userName"];
    this.password = o["password"];
  }



}