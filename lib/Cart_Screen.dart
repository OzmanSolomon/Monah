import 'package:f_groceries/checkout_screen.dart';
import 'package:f_groceries/item_screen.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
  import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}
class Cart_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Cart();
}

class Item {
  final String itemImage;
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemImage, this.itemName, this.itemQun, this.itemPrice});
}

class Cart extends State<Cart_screen> {
void initState() {
     
   globals.totalsum=calTotalSum ();
   }
 
  List<Item> itemList = <Item>[
    Item(
        itemImage: 'http://monah.store/panel/public/upload/file_1526728441.jpg',
        itemName: 'Black Grape',
        itemQun: 'Qty:1',
        itemPrice: '\₹ 100'),
    Item(
        itemImage: 'http://monah.store/panel/public/upload/file_1526728441.jpg',
        itemName: 'Tomato',
        itemQun: 'Qty:3',
        itemPrice: '\₹ 112'),
  
   
  ];
  String toolbarname = 'My Cart (4)';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  IconData _backIcon() {
    switch (Theme
        .of(context)
        .platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  String pincode;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.add_circle;
        case TargetPlatform.iOS:
          return Icons.add_circle;
      }
      assert(false);
      return null;
    }
    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.remove_circle;
        case TargetPlatform.iOS:
          return Icons.remove_circle;
      }
      assert(false);
      return null;
    }
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    double dd = width * 0.77;
    double hh = height - 215.0;
    int  item =  5;
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(
        color: theme.textTheme.caption.color);

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
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
                },
                child: Stack(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(
                          Icons.home,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
              child: Card(
                  child: Container(
                      padding:
                      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // three line description
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Pincode : ',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 2.0),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      '  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: Colors.black),
                                    ),
                                    onTap: () {
                                      showDemoDialog<DialogDemoAction>(
                                          context: context,
                                          child: AlertDialog(
                                              title: const Text(
                                                  'Location/Area Pincode'),
                                              content:SizedBox(
                                                height: 24.0,
                                              child: TextFormField(
                                                  keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                                                  decoration: new InputDecoration(
                                                      hintText: '******',
                                                      labelText: 'Pincode'
                                                  ),
                                                //  validator: this._validateEmail,
                                                  onSaved: (String value) {
                                                    this.pincode = value;
                                                  }
                                              ),),

                                              actions: <Widget>[
                                                FlatButton(
                                                    child: const Text(
                                                        'CANCEL'),
                                                    onPressed: () {
                                                      Navigator.pop(context,
                                                          DialogDemoAction
                                                              .disagree);
                                                    }
                                                ),
                                                FlatButton(
                                                    child: const Text('SAVE'),
                                                    onPressed: () {
                                                      Navigator.pop(context,
                                                          DialogDemoAction
                                                              .agree);
                                                    }
                                                )
                                              ]
                                          )
                                      );
                                    },
                                  )

                                ],
                              ),
                            ],
                          ))))),
          Container(
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 12.0, bottom: 10.0),
              height: hh,
              child: ListView.builder(
                  itemCount: globals.Cart.length,
                  itemBuilder: (BuildContext cont, int ind) {
                    return SafeArea(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              Container(

                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Container(

                                        height: 130.0,
                                        width: dd,
                                        child: Card(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                  height: 120.0,
                                                  width: 100.0,
                                                  // child: Image.asset(
                                                  //   itemList[ind].itemImage,
                                                   child:  CachedNetworkImage(
                            imageUrl: globals.Cart[ind].imagename,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                                    fit: BoxFit.fill,
                                                  )),
                                              SizedBox(
                                                  height: 120.0,
                                                  child: Container(
                                                    alignment: Alignment
                                                        .topLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        _verticalD(),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Text(
                                                              globals.Cart[ind]
                                                                  .itemname,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 18.0,
                                                                  color:
                                                                  Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                        _verticalD(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.max,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              globals.Cart[ind]
                                                                  .unit.toString(),
                                                              style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  color:
                                                                  Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            new IconButton(
                                                              icon: Icon(
                                                                  _add_icon(),
                                                                  color: Colors
                                                                      .amber
                                                                      .shade500),
                                                              onPressed: () {
                                                              //    globals.itemcount[ind] =  globals.itemcount[ind] + 1;
                                                          
                                                               setState(() {
                                                            globals.itemcount[ind] =  globals.itemcount[ind] +1;
                                                          globals.totalsum= calTotalSum ();
                                                          });
                                                             print( globals.itemcount[ind]);
                                                              },

                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  left: 2.0),
                                                            ),
                                                            Text(
                                                           //   item.toString(),
                                                           globals.itemcount[ind].toString(),
                                                              /*     style: descriptionStyle.copyWith(
                                                   fontSize: 20.0,
                                                   color: Colors.black87),*/
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  right: 2.0),
                                                            ),
                                                            new IconButton(
                                                              icon: Icon(
                                                                  _sub_icon(),
                                                                  color: Colors
                                                                      .amber
                                                                      .shade500),
                                                              onPressed: () {
                                                                 if( globals.itemcount[ind]>0){
                                                                setState(() {
                                                          globals.itemcount[ind] =  globals.itemcount[ind] -1;
                                                                            globals.totalsum= calTotalSum ();
                                                                            });
                                                    print( globals.itemcount[ind]);
                                                 }                                                
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                          height: 110.0,
                                          width: 50.0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                            (  globals.Cart[ind].itmprice * double.parse( globals.itemcount[ind].toString())).toString() + "ريال",
                                            ),
                                          )

                                      ),

                                    ],
                                  )),

                            ],
                          ),
                        ));
                  })),
          Container(
              alignment: Alignment.bottomLeft,
              height: 60.0,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.info), onPressed: null),
                    Text(
                      'Total :',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      globals.totalsum.toString(),
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: const Text('CONFIRM ORDER'),
                            textColor: Colors.amber.shade500,
                            onPressed: () {
                              int minreqvalue = int.parse(globals.monahnfo.minrequests);
                              if (globals.totalsum >= minreqvalue){
                           
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkout()));
                            }else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('أقل قيمة للطلب $minreqvalue ريال')
        ));
                            }
                            
                             },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
   
   
    );
  }

  verticalDivider() =>
      Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() =>
      Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 07.0, bottom: 0.0),
      );


 calTotalSum (){
   double totalsum =0 ;
    for (int i = 0; i < globals.itemcount.length; i++){
       totalsum = totalsum + (globals.itemcount[i] * globals.Cart[i].itmprice);
      
    }
  return totalsum;

 }

  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));
      }
    });
  }
}