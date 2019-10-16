import 'package:flutter/material.dart';
import 'package:f_groceries/model/Address_model.dart';
import 'package:f_groceries/services/address_services.dart';
 import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;


class Changepassresponse {
  final String code;
final String  msg ;

  // final String name;
  // final List<Image> images;

  Changepassresponse({this.code, this.msg});
  factory Changepassresponse.fromJson(Map<String, dynamic> parsedJson){

  return Changepassresponse(
    code: parsedJson['code'],
    msg: parsedJson['msg'],
   
  );
}
}

class Account_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => account();
}
String changeandsubmituserinfo_lable = 'تعديل';
String changeandsubmituserpass_lable = 'تغيير كلمة المرور';

String _newusername ="";
String _newuseremail ="";
String _newusertown ="";
String _newusercity ="";
String _newuserepass ="";
String _olduserepass ="";

String _newusere_repass ;
bool _allowediting_userinfo = false;
bool _allowediting_userpass = false;

class account extends State<Account_Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   String username = 'Naomi A. Schultz';
  String mobilenumber = '410-422-9171';
  String eid = 'NaomiASchultz@armyspy.com';
  String uid = "0";
  String uadress = 'adress';
  String utwon = 'town';
 var isLoading = false;

 void mapuserinfo (){
List<globals.Userinfo> userlist = List();
  userlist = globals.userlist;
 print(userlist.elementAt(0).id);
            uid = userlist.elementAt(0).id.toString();
             username = userlist.elementAt(0).name;
             mobilenumber = userlist.elementAt(0).phone;
             eid = userlist.elementAt(0).email;
             uadress = userlist.elementAt(0).adress;
             utwon = userlist.elementAt(0).town;
 }
@override
void initState() {
   //_fetchData();
mapuserinfo ();

   }
   List<globals.Userinfo> userlist = List();
  
 



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = new Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );

    Icon menu = new Icon(
      Icons.more_vert,
      color: Colors.black38,
    );
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;

    //List<address> addresLst = loadAddress() as List<address> ;
    return new Scaffold(
       key: _scaffoldKey,
      appBar: new AppBar(
         backgroundColor: globals.appbarcolor,
        title: Text(
          'My Account',
        ),
      ),
      body: new Container(
        
           child:     isLoading? Center(
                child: CircularProgressIndicator(),
              )
              : SingleChildScrollView(
            child: new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(7.0),
            alignment: Alignment.topCenter,
            height: 270.0,
            child: new Card(
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  new Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0),
                        // padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: Image.network(
                              'https://www.fakenamegenerator.com/images/sil-female.png'),
                        ),
                      )),

                  new FlatButton(
                   onPressed:(){ _editusericfo ();},
                    child: Text(
                      changeandsubmituserinfo_lable,
                      style:
                          TextStyle(fontSize: 13.0, color: Colors.blueAccent),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.blueAccent)),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(
                            left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              username,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            _verticalDivider(),
                            new Text(
                              mobilenumber,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                            _verticalDivider(),
                            new Text(
                              eid,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: ofericon,
                            color: Colors.blueAccent,
                            onPressed: (){_editusericfo();}),
                      )
                    ],
                  ),
                  // VerticalDivider(),
                ],
              ),
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 10.0, bottom: 5.0),
            child: new Text(
              ' معلوماتي الشخصية',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
           _verticalD(),
           new TextField(
             enabled: _allowediting_userinfo,
             maxLength: 20,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
               _newusername = text;
              print(text) ;
              },
              //Icon(Icons.verified_user),
              decoration: InputDecoration(
                  icon: Icon(Icons.supervised_user_circle),
                alignLabelWithHint: true,
                hintText: 'ادخل الاسم ثلاثي',
                labelText: username
              ),
            ),
         new TextField(
             enabled: _allowediting_userinfo,
             maxLength: 40,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
                 _newuseremail = text;
              print(text) ;
              },
              //Icon(Icons.verified_user),
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                alignLabelWithHint: true,
                hintText: 'ادخل البريد الاكتروني',
                 labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                labelText: eid
              ),
            ),
         _verticalD(),
         new Container(
            alignment: Alignment.topRight,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 10.0, bottom: 5.0),
            child: new Text(
              'عنواني',

              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          _verticalD(),
         new TextField(
             enabled: _allowediting_userinfo,
             maxLength: 20,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
                 _newusercity = text;
              print(text) ;
              },
              
              //Icon(Icons.verified_user),
              decoration: InputDecoration(
                  icon: Icon(Icons.location_city),
                alignLabelWithHint: true,
                hintText: 'ادخل اسم المدينة',
                labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                labelText: utwon
              ),
            ),
         new TextField(
             enabled: _allowediting_userinfo,
             maxLength: 20,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
                 _newusertown = text; 
              print(uadress) ;
              },
              //Icon(Icons.verified_user),
              decoration: InputDecoration(
                  icon: Icon(Icons.location_city),
                alignLabelWithHint: true,
                 labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                hintText: 'ادخل اسم الضاحية',
                labelText: uadress
              ),
            ),
        

          new Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.all(7.0),
            child: Card(
              elevation: 1.0,
              child: Row(
                children: <Widget>[
                  new IconButton(icon: keyloch, onPressed: (){
_edituserpass ();
                  }),
                  _verticalD(),
                  new FlatButton(
                   onPressed:(){_edituserpass ();},
                    child: Text(
                      changeandsubmituserpass_lable,
                      style:
                          TextStyle(fontSize: 13.0, color: Colors.black),
                    ),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: new BorderRadius.circular(30.0),
                    //     side: BorderSide(color: Colors.blueAccent)),
                  ),

                   
                  
                ],
              ),
            ),
            
          ),
          
         new TextField(
             enabled: _allowediting_userpass,
             maxLength: 20,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
                 _olduserepass = text;
              print(text) ;
               
              },
              obscureText: true,
              //Icon(Icons.verified_user),
              decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key),
                alignLabelWithHint: true,
                hintText: 'ادخل كلمة المرور القديمة ',
                 labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                labelText: 'Old Password'
              ),
            ),

 new TextField(
             enabled: _allowediting_userpass,
             maxLength: 20,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
                 _newuserepass = text;
              print(text) ;
              },
              obscureText: true,
              //Icon(Icons.verified_user),
              decoration: InputDecoration(
                  icon: Icon(Icons.security),
                alignLabelWithHint: true,
                hintText: 'ادخل كلمة المرور الجديدة ',
                 labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                labelText: 'New Password'
              ),
            ),

new TextField(
             enabled: _allowediting_userpass,
             maxLength: 20,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
             onChanged: (text) {
                 _newusere_repass = text;
              print(text) ;
              },
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.security),
                alignLabelWithHint: true,
                hintText: 'أعد ادخال كلمة المرور الجديدة ',
                 labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                labelText: 'Repeate New Password'
              ),
            ),




        ],
      )
          )
      ),
    );
  }


_editusericfo (){
if (_allowediting_userinfo == false){
   setState(() {
                            _allowediting_userinfo = true;
                            changeandsubmituserinfo_lable = 'أرسال';
                            });


}else { 
  _verfiyuserinfo_fields ();
 
}

}


_edituserpass (){
if (_allowediting_userpass == false){
   setState(() {
                            _allowediting_userpass = true;
                            changeandsubmituserpass_lable = 'أرسال';
                            });


}else { 
  _verfiyuserpass_fields ();
 
}

}

 _verfiyuserinfo_fields (){
if (_newusername.length == 0 ||  _newusercity.length == 0 ||  _newuseremail.length == 0 || _newusertown.length == 0 ){
                                 _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('أدخل كل الحقول ')
        ));

}else { 
  _update_userinfo_request();
   setState(() {
  
                            });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
            // content: Text(' جاري الارسال')
        ));
          
}
//return true;
}

_verfiyuserpass_fields (){
if (_newuserepass.length == 0 || _newusere_repass.length == 0 || _olduserepass.length == 0){
                                 _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('أدخل كل الحقول ')
        ));

}else if (_newuserepass !=  _newusere_repass ){
                                 _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('كلمة المرور الجديد غير متطابقة')
        ));

}else { 
   _update_pass_request();
 setState(() {
  changeandsubmituserpass_lable = 'تغيير كلمة المرور';
                           
                            });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
           
            
        ));
        
}

}


  
void _update_userinfo_request()  async {
    setState(() {
     isLoading = true;
    });
    
    final response =
        await http.post("https://monah.store/index.php?api&updateInfo", body: {
          'uid':   uid,
         'name': _newusername, 'address': _newusertown,
         'city': _newusercity, 'email':  _newuseremail
         
         }); 
         print('Response status: ${response.statusCode}');
          setState(() {
     isLoading = false;
    });
            if (response.statusCode == 200) { 
          //   String    _result=   response.body.toString();
        //Changepassresponse changepassresponse = new Changepassresponse.fromJson(json.decode(response.body));

         
    if (response.body.toString().length > 0){
        _fetchData(globals.logedEmail);
setState(() {
     //isLoading = false;
     changeandsubmituserinfo_lable = 'تعديل';
                            _allowediting_userinfo = false;
   print(response.body.toString());
     _scaffoldKey.currentState.showSnackBar(SnackBar( content: Text('تم التغيير بنجاح')    ));
      
  
    });
      
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar( content: Text('حصل خطأ')    ));
     
    }

      
    } else {
      throw Exception('Failed to load photos');
    }
  }
//

void _update_pass_request()  async {
    setState(() {
     isLoading = true;
    });
    final response =
        await http.post("https://monah.store/index.php?api&UpdatePassword", body: {
          'uid':  int.parse( uid),
         'password': _newuserepass, 'old_password': _olduserepass}); 
         print('Response status: ${response.statusCode}');
          setState(() {
     isLoading = false;
    });
            if (response.statusCode == 200) { 
          //   String    _result=   response.body.toString();
        Changepassresponse changepassresponse = new Changepassresponse.fromJson(json.decode(response.body));

      _scaffoldKey.currentState.showSnackBar(SnackBar( content: Text(changepassresponse.msg)    ));
           
    if (changepassresponse.code == "0"){
setState(() {
     isLoading = false;
   print("respnse code:  "+changepassresponse.code);
  
 _allowediting_userpass = false;
      
    });
      
    }

      
    } else {
      throw Exception('Failed to load photos');
    }
  }
//

    // get user info
  void _fetchData(String _email) async {
    
    setState(() {
     isLoading = true;
    });
    final response =
        await http.get("https://monah.store/index.php?api&userInfo&phone="+ _email);
       print('Response status: ${response.statusCode}');
            if (response.statusCode == 200) { 
        globals.userlist = (json.decode(response.body) as List)
          .map((data) => new globals.Userinfo.fromJson(data))
          .toList();
            setState(() {
              
     isLoading = false;
     mapuserinfo ();
    });
        } else {
      throw Exception('Failed to load photos');
    }
  }
//get user info

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
       );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );


}
