import 'package:f_groceries/HomeScreen.dart';
import 'package:f_groceries/signup_screen.dart';
import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;
class Login_Screen extends StatefulWidget {


  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const Login_Screen({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);



  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.yellow,
            fontSize: 24.0
        ),
      ),
    );
  }
  @override
  State<StatefulWidget> createState() => login();
}
class Loginstatuse {
  final bool statuse;
  // final String name;
  // final List<Image> images;

  Loginstatuse({this.statuse});
  factory Loginstatuse.fromJson(Map<String, dynamic> parsedJson){

  return Loginstatuse(
    statuse: parsedJson['login_success'],
   
  );
}
}
class login extends State<Login_Screen> {

  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;
  String _result = "";
  String _statuse = "";
  
  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }
  var isLoading = false;
void _fetchData() async {
    setState(() {
     isLoading = true;
    });
    final response =
        await http.post("https://monah.store/index.php?api&ApiLogin", body: {'phone': _email,
         'password': _password}); 
         print('Response status: ${response.statusCode}');
            if (response.statusCode == 200) { 
     //_statuse =  login_success
      _result = response.body ;
      setState(() {
     isLoading = false;
    });
     // ProductsList = (json.decode(response.body) as List)
     // Loginstatuse = json.decode(response.body);
      Loginstatuse loginstatuse = new Loginstatuse.fromJson(json.decode(response.body));
      print(loginstatuse.statuse);
      if (loginstatuse.statuse == true ){
        setState(() {
        isLoading = false;
      });
      UpdateLogininfo();

      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
       
      }
      else       {
      showInSnackBar('خطأ في اسم المتسخدم او كلمة المرور ');

      }
      //     .map((data) => new Item.fromJson(data))
      //     .toList();
      
    } else {
      throw Exception('Failed to load photos');
    }
  }
//


 UpdateLogininfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('logedinstate', 'true');
  prefs.setString('logedinemail', _email);
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _obscureText = true;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('تسجيل الدخول '),
         // backgroundColor: Colors.white,
           backgroundColor: globals.appbarcolor, 
        ),
         
            
        body: SafeArea(   
             child:     isLoading? Center(
                child: CircularProgressIndicator(),
              )
          : new SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  height: 50.0,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 7.0),
                  child: new Row(
                    children: <Widget>[
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => login_screen()));
                        },
                        child: new Text(
                          'دخول',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup_Screen()));
                        },
                        child: new Text(
                          'انشاء حساب',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                new SafeArea(

                    top: false,
                    bottom: false,
                    child: Card(
                        elevation: 5.0,
                        child: Form(
                            key: formKey,
                            autovalidate: _autovalidate,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.phone,color: Colors.black38,),
                                          hintText: 'أدخل رقم الهاتف ',
                                          labelText: 'رقم الهاتف ',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),
                                     keyboardType: TextInputType.phone,

                                    //   validator: (val) =>
                                    //  !val.contains('@') ? 'ادخل ايميل صحيح' : null,
                                      onSaved: (val) => _email = val,
                                    ),

                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.lock,color: Colors.black38,),
                                          hintText: 'أدخل كلمة المرور',
                                          labelText: 'كلمة المرور',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),

                                      validator: (val) =>
                                      val.length < 6 ? 'قصير جدا.' : null,
                                      onSaved: (val) => _password = val,
                                    ),

                                    SizedBox(height: 35.0,),
                                    new Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          new Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(left: 10.0),
//                                            child: new GestureDetector(
//                                              onTap: (){
//
//                                              },
//                                              child: Text('نسيت كلمة المرور',style: TextStyle(
//                                                  color: Colors.blueAccent,fontSize: 13.0
//                                              ),
//                                              ),
//                                            ),
                                          ),
                                          new Container(
                                            alignment: Alignment.bottomRight,
                                            child: new GestureDetector(
                                              onTap: (){
                                                _submit();
                                              },
                                              child: Text('دخول',style: TextStyle(
                                                  color: Colors.orange,fontSize: 20.0,fontWeight: FontWeight.bold
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*   const SizedBox(height:24.0),

                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),

                              ],
                            )


*/
                                  ]
                              ),
                            )

                        )        //login,
                    ))
              ],
            ),
          )
        ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin();
    }
    else{
      showInSnackBar('الرجاء اصلاح الاخطاء بالأحمر اولا');

    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
  void _performLogin() {
    // This is just a demo, so no actual login here.
    _fetchData();
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  }
