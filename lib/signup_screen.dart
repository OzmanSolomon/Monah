import 'package:f_groceries/logind_signup.dart';
import 'package:flutter/material.dart';
import 'package:f_groceries/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

class Signup_Screen extends StatefulWidget {


  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const Signup_Screen({Key key, this.fieldKey, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted}) : super(key: key);

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
  State<StatefulWidget> createState() => signup();
}

class Signupstatuse {
  final bool statuse;
  // final String name;
  // final List<Image> images;

  Signupstatuse({this.statuse});
  factory Signupstatuse.fromJson(Map<String, dynamic> parsedJson){

  return Signupstatuse(
    statuse: parsedJson['login_success'],
   
  );
}
}
class signup extends State<Signup_Screen> {

  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _firstname;
  String _lastname;
  String _phone;
  String _adress = "The adress";
  String _town = "The town";
 UpdateLogininfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('logedinstate', 'true');
  prefs.setString('logedinemail', _phone);
}
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  bool _formWasEdited = false;
var isLoading = false;

void _fetchData() async {
    setState(() {
     isLoading = true;
    });
    final response =
        await http.post("https://monah.store/index.php?api&createUser", 
        body: {'email': _email,
         'password': _password, 'name':_firstname,'phone':_phone , 'address':_adress, 'town':_town }); 
         print('Response status: ${response.statusCode}');
            if (response.statusCode == 200) { 
             String    _result=   response.body.toString();
        setState(() {
     isLoading = false;
   print(_result);
   if (_result == "0"){
     print("successed");
       showInSnackBar("تم انشا حساب بنجاح");
        UpdateLogininfo() ;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
   }else {
      showInSnackBar(_result);
      print("not successed");
   }

      
    });
    
         
      
    } else {
      throw Exception('Failed to load photos');
    }
  }
//

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _obscureText = true;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('انشاء حساب'),
           backgroundColor: globals.appbarcolor, 
        ),
        body: SafeArea(
           child:     isLoading? Center(
                child: CircularProgressIndicator(),
              )
          :  new SingleChildScrollView(
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
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_Screen()));
                          },
                          child: new Text(
                            'تسجيل دخول',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _verticalD(),
                        new GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_screen()));*/
                          },
                          child: new Text(
                            'انشاء حساب',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
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
                                            icon: Icon(Icons.person,color: Colors.black38,),
                                            hintText: 'ادخل الاسم ثلاثي',
                                            labelText: 'الاسم ثلاثي ',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (val) =>
                                        val.length < 1 ? 'ادخل الاسم ثلاثي' : null,
                                        onSaved: (val) => _firstname = val,
                                      ),
                                      
                                      const SizedBox(height: 24.0),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            icon: Icon(Icons.email,color: Colors.black38,),
                                            hintText: 'البريد الالكتروني',
                                            labelText: 'البريد الالكتروني',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: validateEmail,
                                        onSaved: (String val) {
                                          _email = val;
                                        },
                                      ),

                                      const SizedBox(height: 24.0),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            icon: Icon(Icons.phone_android,color: Colors.black38,),
                                            hintText: 'رقك هانفك',
                                            labelText: 'الهاتف',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: validateMobile,
                                        onSaved: (String val) {
                                          _phone = val;
                                        },
                                      ),
                                      const SizedBox(height: 24.0),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            icon: Icon(Icons.perm_identity,color: Colors.black38,),
                                            hintText: 'ادخل العنوان',
                                            labelText: 'العنوان',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (val) =>
                                        val.length < 1 ? 'ادخل العنوان ' : null,
                                        onSaved: (val) => _adress = val,
                                      ),
                                      const SizedBox(height: 24.0),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            focusedBorder:  UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                            ),
                                            icon: Icon(Icons.perm_identity,color: Colors.black38,),
                                            hintText: 'ادخل المدينة',
                                            labelText: 'المدينة',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (val) =>
                                        val.length < 1 ? 'ادخل المدينة ' : null,
                                        onSaved: (val) => _town = val,
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
                                            hintText: 'ادخل كلمة',
                                            labelText: 'كلمة مرور',
                                            labelStyle: TextStyle(color: Colors.black54)
                                        ),

                                        validator: (val) =>
                                        val.length < 6 ? 'قصير جدا' : null,
                                        onSaved: (val) => _password = val,
                                      ),

                                      SizedBox(height: 35.0,),
                                      new Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[

                                            new Container(
                                              alignment: Alignment.bottomRight,
                                              child: new GestureDetector(
                                                onTap: (){
                                                  _submit();
                                                },
                                                child: Text('انشاء',style: TextStyle(
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'الايميل غير صالح';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'مطلوب 10 خانات';
    else
      return null;
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
      showInSnackBar('اصلح الاخطاء بالاحمر اولا');

    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
  void _performLogin() {
    // This is just a demo, so no actual login here.
   /* final snackbar = SnackBar(
      content: Text('Email: $_email, password: $_password'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);*/
    _fetchData();
  // Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_Screen()));
  }

  _verticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

}
