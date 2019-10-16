import 'package:f_groceries/Cart_Screen.dart';
import 'package:f_groceries/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'globals.dart' as globals;
class Help_Screen extends StatefulWidget {
  final String toolbarname;

  Help_Screen({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Help(toolbarname);
}

class Help extends State<Help_Screen> {
  List list = ['12', '11'];

  bool switchValue = false;

   String toolbarname = 'مساعدة';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 // String toolbarname;

  Help(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
    theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(_backIcon()),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(toolbarname),
          backgroundColor: globals.appbarcolor,
        ),
        body: Container(
          child: Column(
            children: <Widget>[

              new Container(
                height: 50.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: new Row(
                  children: <Widget>[
                    _verticalD(),
                     new 
                     GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_screen()));*/
                      },
                      child: Container(
                       // alignment: Alignment.topRight,
                      child: new Text( 
                                       
                        'تواصل معنا',
                        
                      //    textAlign: TextAlign.right,
                        
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),//text 
                        ),
                    ),
              
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Container(
                      //  padding: EdgeInsets.only(left: 10.0,top: 15.0,bottom: 5.0,right: 5.0),

                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                          
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                            //       textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Icon(Icons.mail, color: Colors.black54),
                                    Container(
                                      margin: EdgeInsets.only(left: 5.0),
                                    ),
                                    Text(
                                      'أرسل ايميل',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  showDemoDialog<DialogDemoAction>(
                                      context: context,
                                      child: AlertDialog(
                                          title: const Text('أرسل أيميل'),
                                          content: Text(
                                           globals.monahnfo.monagemail +   "أرسل لنا ايميل على ",
                                              style: dialogTextStyle),
                                          actions: <Widget>[
                                            // FlatButton(
                                            //     child: const Text('Afree'),
                                            //     onPressed: () {
                                            //       Navigator.pop(context,
                                            //           DialogDemoAction.disagree);
                                            //     }),
                                              FlatButton(
                                            child: const Text('تم'),
                                            onPressed: () {
                                              Navigator.pop(context,
                                                  DialogDemoAction.agree);
                                            })
                                          ]));
                                },
                              )),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.info,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      Text(
                                        'عن مؤنه',
                                        style: TextStyle(
                                            fontSize: 17.0, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showDemoDialog<DialogDemoAction>(
                                        context: context,
                                        child: AlertDialog(
                                            title: const Text('عن مؤنه '),
                                            content: Text(
                                          globals.monahnfo.aboutus,
                                                style: dialogTextStyle),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: const Text('تم'),
                                                  onPressed: () {
                                                    Navigator.pop(context,
                                                        DialogDemoAction.disagree);
                                                  }),
                                              /* FlatButton(
                                              child: const Text('AGREE'),
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    DialogDemoAction.agree);
                                              })*/
                                            ]));
                                  })),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.feedback,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      Text(
                                        'أرسل أقتراح',
                                        style: TextStyle(
                                            fontSize: 17.0, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showDemoDialog<DialogDemoAction>(
                                        context: context,
                                        child: AlertDialog(
                                            title: const Text('أرسل أقتراح'),
                                            content: Text(
                                              "أرسل اقتراح الينا عبر: " +
                                              "\n - Whatsapp: \n" +  globals.monahnfo.monahwhatsapp +"."+
                                             "\n - phone: \n" + globals.monahnfo.monahphone +  "."+
                                             "\n - Twitter: \n" + globals.monahnfo.monahtwitter + "."+
                                            "\n - Facebook: \n" + globals.monahnfo.monahfacebook +".", 
                                                style: dialogTextStyle),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: const Text('تم'),
                                                  onPressed: () {
                                                    Navigator.pop(context,
                                                        DialogDemoAction.disagree);
                                                  }),
                                              /* FlatButton(
                                              child: const Text('AGREE'),
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    DialogDemoAction.agree);
                                              })*/
                                            ]));
                            
                                  })),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        /*_scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));*/
      }
    });
  }

  _verticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  Widget _status(status) {
    if (status == 'Cabcel Order') {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.green),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
          });
    }
  }

  erticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
