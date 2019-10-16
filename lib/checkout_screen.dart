import 'package:f_groceries/HomeScreen.dart';
import 'package:f_groceries/Payment_Screen.dart';
import 'package:f_groceries/pick_map_myloction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => check_out();
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class check_out extends State<Checkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  var isLoading = false;




// Get Town
   List<globals.Towninfo> TowninfoList = List();
  // List<String>  townsList = List();
  void _getTown() async {
  
    setState(() {
      isLoading = true;
    });
    final response =
      
     await http.post("https://monah.store/index.php?api&GetTown", body: {
         'city_id': globals.selectedcityid}); 
    if (response.statusCode == 200) {
      TowninfoList = (json.decode(response.body) as List)
          .map((data) => new globals.Towninfo.fromJson(data))
          .toList();   
           globals.townsList.clear();  
              for (int i = 0; i < TowninfoList.length; i++){
          globals.townsList.add(TowninfoList[i].id + '.'+ TowninfoList[i].name) ;
           }
         
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
// Get Town



// Get City
   List<globals.Cityinfo> CityinfoList = List();
  void _getCity() async {
    globals.citiesList = ['2.أبو عريش', '1.جيزان'];
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://monah.store/index.php?api&GetCity");
    if (response.statusCode == 200) {
      CityinfoList = (json.decode(response.body) as List)
          .map((data) => new globals.Cityinfo.fromJson(data))
          .toList();     
           
            globals.citiesList.clear();  
              for (int i = 0; i < CityinfoList.length; i++){
          globals.citiesList.add(CityinfoList[i].id + '.'+ CityinfoList[i].name) ;
           }
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
// Get City


// Get Delivery Time
   List<globals.DeliveryTimeinfo> delveryTimelist = List();
  void _getDeliveryTime() async {
   globals.delveryTimelist = [ '1. الفترة المسائية'];

    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://monah.store/index.php?api&GetTime");
    if (response.statusCode == 200) {
      delveryTimelist = (json.decode(response.body) as List)
          .map((data) => new globals.DeliveryTimeinfo.fromJson(data))
          .toList();     
              
            globals.delveryTimelist.clear();  
              for (int i = 0; i < delveryTimelist.length; i++){
          globals.delveryTimelist.add(delveryTimelist[i].id + '.'+ delveryTimelist[i].name) ;
           }
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
// Get  Delivery Time


  @override
void initState() {
   _getCity();
    _getDeliveryTime();
   }
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

 
  String toolbarname = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final double height = MediaQuery.of(context).size.height;
//




onSucess(String _result ) {
  
 print("successed");
          final snackBar = SnackBar(content: Text( "  تم ارسال الطلب بنجاح "));                 
       //         Scaffold.of(context).showSnackBar(snackBar);
              final scaffoldKey = GlobalKey<ScaffoldState>();
               //   scaffoldKey.currentState.showSnackBar(snackBar);
                      print(_result);
                      globals.ordersended = true ; 
                      globals.Cart.clear();
                      globals.itemcount.clear();
                      globals.itemidlist.clear();
      
_scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text(' تم ارسال الطلب بنجاح'),
    duration: Duration(seconds: 2),
     
  ));
 Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
 Future.delayed(const Duration(milliseconds: 500), () {



   setState(() {
     // Here you can write your code for open new view
   });

 });
//  Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
} // succussed 



var isLoading = false;
 
 bool orderfill_validation() {
if (globals.selectedcityid == null){
_scaffoldKey.currentState.showSnackBar(
  SnackBar(    content: Text('اختر  المدينة'),    duration: Duration(seconds: 1),  
  ));
 return false;
} else if (globals.selectedTownid == null){
_scaffoldKey.currentState.showSnackBar(
  SnackBar(    content: Text('اختر الضاحية'),    duration: Duration(seconds: 1),  
  ));
 return false;
}else if (globals.delveryTimeid == null){
_scaffoldKey.currentState.showSnackBar(
  SnackBar(    content: Text('اختر زمن التوصيل '),    duration: Duration(seconds: 1),  
  ));
 return false;
} else if (globals.latitude == null){
_scaffoldKey.currentState.showSnackBar(
  SnackBar(    content: Text('اختر موقعك على الخريطة '),    duration: Duration(seconds: 1),  
  ));

 return false;
}

   return true;
 }

void _sendOrder() async {
   String _id = globals.userlist.elementAt(0).id.toString();
 String _itemId = globals.itemidlist.toString();
  String quantity = globals.itemcount.toString();
  String _comments = globals.comments;
  String _address = globals.userlist.elementAt(0).adress;
 
 check_out parent;
 // check_out(this.parent);
  setState(() {
     isLoading = true;
    
        });
    
 final response =
        await http.post("https://monah.store/index.php?api&SendRequests", 
        body: {'uid': _id ,      
         'item_id': _itemId,   'address': globals.selectedcity+","+ globals.selectedTown ,'comments': globals.comments ,  
         'quantity': quantity,          'city_id': globals.selectedcityid,  
           'town_id': globals.selectedTownid,   'dlev_time_id': globals.delveryTimeid ,
           'lat': globals.latitude.toString(),  'lng': globals.longitude.toString()  });         
                  print('Response status: ${response.statusCode}');
            if (response.statusCode == 200) { 
             String    _result=   response.body.toString();
         setState(() {
            isLoading = false;
          print(_result);
          if (_result == "ok"){
              onSucess  (_result) ; // show snackbar and clear the cart
           
   }else {
  //  final snackBar = SnackBar(content: Text(_result));                 
                 //   Scaffold.of(_scaffoldKey).showSnackBar(snackBar);
      print(_result);
   }     
    });       
      
    } else {
      throw Exception('Failed to load photos');
    }
  }
// send Order


    AppBar appBar = AppBar(
       backgroundColor: globals.appbarcolor,

      leading: IconButton(
        icon: Icon(_backIcon()),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(toolbarname),
     // backgroundColor: Colors.white,
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Container(
            height: 110.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
              },
            ),
          ),
        )
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body:       isLoading? Center(
                child: CircularProgressIndicator(),
              )
          : new Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(2.0),
              
                      ),
          _verticalDivider(),
          new Container(
            alignment: Alignment.topRight,
            margin:
                EdgeInsets.only(left: 12.0, top:0.0, right: 12.0, bottom: 0.0),
            child: new Text(
              'عنوان التوصيل',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          new Container(
              height: 127.0,
              child: Row(
             //   scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                       alignment: Alignment.bottomCenter,
                    height: 80.0,
                    width: 70.0,
                  
                      // child: Container(
                      //         alignment: Alignment.bottomCenter,
                      child: Column(
                    //    crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: <Widget>[
                          new Container(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                  icon: Icon(Icons.map), onPressed:() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MapSample()));
                    }
                                  )),
                                new Container(
                              alignment: Alignment.bottomCenter,
                               child: new Text(
              'موقعي',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
                                  ),   
                        ],
                     
                      ),
                   //   ),//culomn
                  //  ),
                  ),
                  Container(
                    height: 125.0,
                    width: 225.0,
                    margin: EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 3.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(
                                    left: 12.0,
                                    top: 0.0,
                                    right: 0.0,
                                    bottom: 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      globals.userlist.elementAt(0).name,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                   // _verticalDivider(),
                                    // new Text(
                                    //   globals.userlist.elementAt(0).adress,
                                    //   style: TextStyle(
                                    //       color: Colors.black45,
                                    //       fontSize: 10.0,
                                    //       letterSpacing: 0.5),
                                    // ),
                                 //   _verticalDivider(),
                                  //   new Text(
                                  //    globals.userlist.elementAt(0).town,
                                  //     style: TextStyle(
                                  //         color: Colors.black45,
                                  //         fontSize: 10.0,
                                  //         letterSpacing: 0.5),
                                  //   ),
                                  // //
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                           DropdownButton(
                                     hint: Text(globals.selectedTown), // Not necessary for Option 1
                                       items: globals.townsList.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location,
                                           style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 8.0,
                                          letterSpacing: 0.5),
                                          ),
                                          
                                          value: location,
                                        );
                                      }).toList(),
                                  // value: selectedcity,
                                      onChanged: (newValue) {
                              
                                List<String>  selectedTownList = newValue.toString().split('.');
                                 globals.selectedTown = selectedTownList [1];
                                 globals.selectedTownid = selectedTownList [0];
                               
                                        setState(() {                                        
                                        }
                                        );
                                      },
                                    ), 
                                      DropdownButton(
                                        
                                     hint: Text(globals.selectedcity,
                                     style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 10.0,
                                          letterSpacing: 0.5),), // Not necessary for Option 1
                                     items: globals.citiesList.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location,
                                           style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 10.0,
                                          letterSpacing: 0.5),
                                          ),
                                          
                                          value: location,
                                        );
                                      }).toList(),
                                  // value: selectedcity,
                                      onChanged: (newValue) {
                              
                              List<String>  selectedcityidList = newValue.toString().split('.');
                                 globals.selectedcity = selectedcityidList [1];
                                 globals.selectedcityid = selectedcityidList [0];
                                   globals.selectedTown = 'أختر الضاحية';
                                 _getTown(); 
                                        setState(() {   
                                         
                                                               
                                        }
                                           
                                        );
                                      },
                                    ),
                                        //
                                   // drop down
    ],
                                      ), // row city and Town
                                 //   _verticalDivider(),
                                       new Container(
                                      margin: EdgeInsets.only(
                                          left: 00.0,
                                          top: 0.0,
                                          right: 0.0,
                                          bottom: 0.0),
                                      child:  DropdownButton(
                                     hint: Text(globals.delveryTime,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 10.0,
                                          letterSpacing: 0.5),), // Not necessary for Option 1
                                       items: globals.delveryTimelist.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location,
                                           style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 10.0,
                                          letterSpacing: 0.5),
                                          ),
                                          
                                          value: location,
                                        );
                                      }).toList(),
                                  // value: selectedcity,
                                      onChanged: (newValue) {
                              
                                 List<String>  delveryTimeList = newValue.toString().split('.');
                                  globals.delveryTime  = delveryTimeList [1];
                                  globals.delveryTimeid = delveryTimeList [0];
                               
                                        setState(() {                                        
                                        }
                                        );
                                      },
                                    ), 
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                 
                ],
              )),

                                            // start of  comment sction
                                            const SizedBox(height: 18.0),
                                     TextField( 
                              decoration: InputDecoration(
                                icon: Icon(Icons.comment,color: Colors.black38,),
                                    labelText: 'أضف تعليق ',
                                      border: InputBorder.none,
                                    hintText: 'أترك ملاحظة'
                          ),
                                     onChanged: (text) {
                                    print("First text field: $text");
                                     globals.comments =  text;
                                  },
                                ),  // end of 
  


          _verticalDivider(),
          new Container(
            alignment: Alignment.topRight,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 12.0, bottom: 5.0),
            child: new Text(
              'ملخص الطلبية ',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 12.0, bottom: 5.0),
              height: 140.0,
              child: ListView.builder(
                  itemCount: globals.Cart.length,
                  itemBuilder: (BuildContext cont, int ind) {
                    return SafeArea(
                        child: Column(
                      children: <Widget>[
                        Divider(height: 10.0),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(

                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Text(globals.Cart[ind].itemname,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                    Text(globals.itemcount[ind].toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                    Text(globals.Cart[ind].itmprice.toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87,
                                            
                                            fontWeight: FontWeight.bold)),
                                  ],

                          ),
                        ),

                      ],
                    ));
                  })),
          Container(
              alignment: Alignment.bottomLeft,
              height: 75.0,
              child: Card(
                    child: Column(

                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            child:                 Text("سعر توصيل الطلب 13 ريال ",
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black87,

                        fontWeight: FontWeight.bold)),
    ),

                 Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.info),  onPressed: null ),
                    Text(
                     ( globals.totalsum+ int.parse(globals.monahnfo.chargereq)).toString() + "ريال",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' :المجموع ',
                      style: TextStyle(fontSize: 15.0, color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                                BorderSide(color: Colors.amber.shade500),
                            child: const Text('أرسل الطلب'),
                            textColor: Colors.amber.shade500,
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Patment()));
                              
                              if (orderfill_validation()== true)
                              {
                              _sendOrder() ;
                              }
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                    ),
                  ],
                ),// row
                ],),
              )),
        ],
      ),
    );
  }
  IconData _add_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.add;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }
  IconData _sub_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.remove;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
