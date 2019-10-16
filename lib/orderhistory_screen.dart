import 'package:f_groceries/Cart_Screen.dart';
import 'package:f_groceries/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class Oder_History extends StatefulWidget {
  final String toolbarname;

  Oder_History({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => oder_history(toolbarname);
}

class CancelOrder_Response {
  final bool success;
final String  message ;

  // final String name;
  // final List<Image> images;

  CancelOrder_Response({this.success, this.message});
  factory CancelOrder_Response.fromJson(Map<String, dynamic> parsedJson){

  return CancelOrder_Response(
    success: parsedJson['success'],
    message: parsedJson['message'],
   
  );
}
}
// class Item {
//   final String name;
//   final String deliveryTime;
//   final String oderId;
//   final String oderAmount;
//   final String paymentType;
//   final String address;
//   final String cancelOder;

//   Item(
//       {this.name,
//       this.deliveryTime,
//       this.oderId,
//       this.oderAmount,
//       this.paymentType,
//       this.address,
//       this.cancelOder});
// }

class oder_history extends State<Oder_History> {
String  _id =  globals.userlist.elementAt(0).id;

   var isLoading = false;
  @override
void initState() {
   _fetchData();
   }
   
  void _fetchData() async {

//List<globals.OrderDetials> OrderDetialsList = List();
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://monah.store/index.php?api&requestsHistory&id="+ _id);
    if (response.statusCode == 200) {
      globals.OrderDetialsList = (json.decode(response.body) as List)
          .map((data) => new globals.OrderDetials.fromJson(data))
          .toList();
          
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load OrderDetials');
    }
  }
//
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;
  // List<Item> itemList = <Item>[
  //   Item(
  //       name: 'Jhone Miller',
  //       deliveryTime: '26-5-2106',
  //       oderId: '#CN23656',
  //       oderAmount: '\₹ 650',
  //       paymentType: 'online',
  //       address: '1338 Karen Lane,Louisville,Kentucky',
  //       cancelOder: 'Cancel Order'),
  //   Item(
  //       name: 'Gautam Dass',
  //       deliveryTime: '10-8-2106',
  //       oderId: '#CN33568',
  //       oderAmount: '\₹ 900',
  //       paymentType: 'COD',
  //       address: '319 Alexander Drive,Ponder,Texas',
  //       cancelOder: 'View Receipt'),
  //   Item(
  //       name: 'Jhone Hill',
  //       deliveryTime: '23-3-2107',
  //       oderId: '#CN75695',
  //       oderAmount: '\₹ 250',
  //       paymentType: 'online',
  //       address: '92 Jarvis Street,Buffalo,New York',
  //       cancelOder: 'View Receipt'),
  //   Item(
  //       name: 'Miller Root',
  //       deliveryTime: '10-5-2107',
  //       oderId: '#CN45238',
  //       oderAmount: '\₹ 500',
  //       paymentType: 'Bhim/upi',
  //       address: '103 Romrog Way,Grand Island,Nebraska',
  //       cancelOder: 'Cancel Order'),
  //   Item(
  //       name: 'Lag Gilli',
  //       deliveryTime: '26-10-2107',
  //       oderId: '#CN69532',
  //       oderAmount: '\₹ 1120',
  //       paymentType: 'online',
  //       address: '8 Clarksburg Park,Marble Canyon,Arizona',
  //       cancelOder: 'View Receipt'),
  // ];

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  oder_history(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

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
        body: 
          isLoading? Center(
                child: CircularProgressIndicator(),
              )
              : ListView.builder(
            itemCount:  globals.OrderDetialsList.length,
            itemBuilder: (BuildContext cont, int ind) {
              int invind = globals.OrderDetialsList.length-1- ind;
              return SafeArea(
                  child: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                    color:Colors.black12,
                    child: Card(
                        elevation: 4.0,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 10.0),
                            child: GestureDetector(
                                child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // three line description
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                  "رقم الطلب: "+   globals.OrderDetialsList[ invind].order_id,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 3.0),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'To Deliver On :' +
                                         globals.OrderDetialsList[ invind].Date,
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.amber.shade500,
                                ),

                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'تعليق',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 3.0),
                                              child: Text(
                                                 globals.OrderDetialsList[invind].comments,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black87),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'المدينة',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 3.0),
                                              child: Text(
                                                 globals.OrderDetialsList[invind].address_text,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(3.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'طريقة الدفع',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 3.0),
                                              child: Text(
                                             //  globals.OrderDetialsList[invind].paymentType",
                                                "كاش",
                                              
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black87),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.amber.shade500,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 20.0,
                                        color: Colors.amber.shade500,
                                    ),
                                    Text( globals.OrderDetialsList[invind].address,
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black54)),
                                  ],
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.amber.shade500,
                                ),
                                  Container(
                                 child:Text( "المشتروات: " + globals.OrderDetialsList[invind].items +".",
                                  textDirection: TextDirection.rtl, )
                                 
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.amber.shade500,
                                ),
                                 Container(
                                 child:Text( " قيمة السلة: " + globals.OrderDetialsList[invind].order_value.toString() + " ريال."
                                 + "     السعر مع التوصيل:  " + (globals.OrderDetialsList[invind].order_value + double.parse(globals.monahnfo.chargereq)).toString()+ " ريال.",
                                 textDirection: TextDirection.rtl,
                                 )
                               
                                ),
                                Divider(
                                  height: 10.0,
                                  color: Colors.amber.shade500,
                                ),
                                Container(
                                 child:_status( globals.OrderDetialsList[invind].stats,globals.OrderDetialsList[invind].order_id)
                                )

                               
                              ],
                            ))))),
              ]));
            }));
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  Widget _status(status,String order_id) {
    if(status == 'قيد التوصيل'){
     return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.red),),
          icon: const Icon(Icons.highlight_off, size: 18.0,color: Colors.red,),
          onPressed: () {
            
           cancelorder(order_id);
          }
      );
    }
    else{
     return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.green),),
          icon: const Icon(Icons.check_circle, size: 18.0,color: Colors.green,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }
 erticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;



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

void  cancelorder(String order_id) {
  final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
    theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

     showDemoDialog<DialogDemoAction>(
                                        context: context,
                                        child: AlertDialog(
                                            title: const Text('الغاء الطلب',
                                              textDirection: TextDirection.rtl, ),
                                            content: Text(
                                             "مواصلة الغاء الطلب",
                                              textDirection: TextDirection.rtl,
                                                style: dialogTextStyle),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: const Text('مواصلة'),
                                                  onPressed: () {
                                                    Navigator.pop(context,
                                                        DialogDemoAction.agree);
                                                        print("مواصلة الحذف");
                                                         cancelorder_request(order_id);
                                                  }),
                                              FlatButton(
                                              child: const Text('رجوع'),
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    DialogDemoAction.disagree);
                                              })
                                            ]));
                            
  
     
}


void cancelorder_request(String order_id)  async {
    setState(() {
     isLoading = true;
    });
    final response =
        await http.post("https://monah.store/index.php?api&cancel_order", body: {
          'uid':  _id,
         'order_id': order_id}); 
         print('Response status: ${response.statusCode}');
          setState(() {
    // isLoading = false;
    }); 
            if (response.statusCode == 200) { 
          //   String    _result=   response.body.toString();
        CancelOrder_Response cancelOrder_Response = new CancelOrder_Response.fromJson(json.decode(response.body));

      _scaffoldKey.currentState.showSnackBar(SnackBar( content: Text(cancelOrder_Response.message)    ));
           print("respnse code:  "+ cancelOrder_Response.message);
            _fetchData();
//     if (changepassresponse.success == "true"){
// setState(() {
//      isLoading = false;
//    print("respnse code:  "+changepassresponse.code);
  
//  _allowediting_userpass = false;
      
//     });
            }
    

      
     else {
      throw Exception('Failed to load photos');
    }
  }
//
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
