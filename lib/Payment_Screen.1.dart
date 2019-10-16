import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'globals.dart' as globals;

class Patment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapSampleState();
}



// class MapSample extends StatefulWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

class MapSampleState extends State<Patment> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
//var currentLocation = LocationData;
var location = new Location();

Future _getLocation() async {

 double  userLocation;
LocationData loc;
var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
try {

  
    loc =  await location.getLocation();
  globals.latitude  = loc.latitude;
 globals.longitude = loc.longitude;
 _goToMyLoction();
}  catch (e) {
  if (e.code == 'PERMISSION_DENIED') {
   String error = 'Permission denied' ;
   print(error); 
    } 
  loc = null;
};
  }
@override
  void initState() {
    super.initState();
   _getLocation();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    
   //userLocation = await location.getLocation();

    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(globals.latitude, globals.longitude),
      //tilt: 59.440717697143555,
      zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: Stack(
  children: <Widget>[
       GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onCameraMove: _onCameraMove,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),// maps

     Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.center,
        child: FloatingActionButton(
      //    onPressed: _getLocation,
          materialTapTargetSize: MaterialTapTargetSize.padded,
         backgroundColor: Colors.transparent,
          child: const Icon(Icons.location_on, size: 50.0),
        ),
      ),
    ), // center marler

 Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
         onPressed: _sendlaglat,
      
          materialTapTargetSize: MaterialTapTargetSize.padded,
         backgroundColor: Colors.lightGreen,
          child: const Icon(Icons.done, size: 50.0),
          
        ),
      ),
    ), // cente // center marler
      // end of stack
  ],),
      //start fluting bt
      floatingActionButton: FloatingActionButton.extended(
        onPressed:_getLocation,
        label: Text('',
         style: TextStyle(color: Colors.black54,
                          fontSize: 10.0,
                          fontWeight: FontWeight.normal),),
        icon: Icon(Icons.location_searching,size: 14.0),
      ), // floating bt
    );
  }

//onCameraMove: ((_position) => _updateMarker(_position)),   
  Future<void> _sendlaglat ()async{
  final GoogleMapController controller = await _controller.future;
 CameraPosition selectedpos;
 globals.latitude =  selectedpos.target.latitude;
globals.longitude =  selectedpos.target.longitude;
print('  تم الارسال');
}



void _onCameraMove(CameraPosition position) {
  globals.latitude =  position.target.latitude;
print('lat: ' +  globals.latitude.toString() );
globals.longitude =  position.target.longitude;
print('long: ' +  globals.longitude.toString() );
 
}
  Future<void> _goToMyLoction() async {
    final GoogleMapController controller = await _controller.future;
   
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class payment extends State<Patment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;

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
  int radioValue = 0;
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  List<Item> itemList = <Item>[
    Item(itemName: 'Black Grape', itemQun: 'Qty:1', itemPrice: '\₹ 100'),
    Item(itemName: 'Tomato', itemQun: 'Qty:3', itemPrice: '\₹ 112'),
    Item(itemName: 'Mango', itemQun: 'Qty:2', itemPrice: '\₹ 105'),
    Item(itemName: 'Capsicum', itemQun: 'Qty:1', itemPrice: '\₹ 90'),
    Item(itemName: 'Lemon', itemQun: 'Qty:2', itemPrice: '\₹ 70'),
    Item(itemName: 'Apple', itemQun: 'Qty:1', itemPrice: '\₹ 50'),
  ];
  String toolbarname = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final double height = MediaQuery.of(context).size.height;

    AppBar appBar = AppBar(
      leading: IconButton(
        icon: Icon(_backIcon()),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(toolbarname),
      backgroundColor: Colors.white,
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
            ),
          ),
        )
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      // body: MapSample(),
      // new Column(
      //   children: <Widget>[
      //     Container(
      //         margin: EdgeInsets.all(5.0),
      //         child: Card(
      //             child: Container(
      //                 padding: const EdgeInsets.all(10.0),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: <Widget>[
      //                     // three line description
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: <Widget>[
      //                         Padding(
      //                           padding: const EdgeInsets.only(bottom: 8.0),
      //                           child: Container(
      //                               alignment: Alignment.center,
      //                               child: Row(
      //                                 children: <Widget>[
      //                                   Text(
      //                                     'Delivery',
      //                                     style: TextStyle(
      //                                         fontSize: 18.0,
      //                                         fontWeight: FontWeight.bold,
      //                                         color: Colors.black38),
      //                                   ),
      //                                   IconButton(
      //                                       icon: Icon(
      //                                         Icons.play_circle_outline,
      //                                         color: Colors.black38,
      //                                       ),
      //                                       onPressed: null)
      //                                 ],
      //                               )),
      //                         ),
      //                         Padding(
      //                           padding: const EdgeInsets.only(bottom: 8.0),
      //                           child: Container(
      //                               alignment: Alignment.center,
      //                               child: Row(
      //                                 children: <Widget>[
      //                                   Text(
      //                                     'Payment',
      //                                     style: TextStyle(
      //                                         fontSize: 18.0,
      //                                         fontWeight: FontWeight.bold,
      //                                         color: Colors.black),
      //                                   ),
      //                                   IconButton(
      //                                       icon: Icon(
      //                                         Icons.check_circle,
      //                                         color: Colors.blue,
      //                                       ),
      //                                       onPressed: null)
      //                                 ],
      //                               )),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 )))),
      //     _verticalDivider(),
      //     Container(
      //         margin: EdgeInsets.all(10.0),
      //         child: Card(
      //           child: Container(
      //             color: Colors.green.shade100,
      //             child: Container(
      //                 padding:
      //                     const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      //                 child: Text(
      //                     "GET EXTRA 5% OFF* with MONEY bank Simply Save Credit card. T&C.",
      //                     maxLines: 10,
      //                     style: TextStyle(
      //                         fontSize: 13.0, color: Colors.black87))),
      //           ),
      //         )),
      //     new Container(
      //       alignment: Alignment.topLeft,
      //       margin:
      //           EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
      //       child: new Text(
      //         'Payment Method',
      //         style: TextStyle(
      //             color: Colors.black87,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 18.0),
      //       ),
      //     ),
      //     _verticalDivider(),
      //     new Container(
      //         height: 264.0,
      //         margin: EdgeInsets.all(10.0),
      //         child: Card(
      //           child: Container(
      //             child: Container(
      //                 child: Column(
      //               children: <Widget>[
      //                 Container(
      //                   padding: EdgeInsets.only(left: 10.0),
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[
      //                       Text("Wallet / UPI",
      //                           maxLines: 10,
      //                           style: TextStyle(
      //                               fontSize: 15.0, color: Colors.black)),
      //                       Radio<int>(
      //                           value: 0,
      //                           groupValue: 0,
      //                           onChanged: null),
      //                     ],
      //                   ),
      //                 ),
      //                 Divider(),
      //                 _verticalD(),
      //                 Container(
      //                     padding: EdgeInsets.only(left: 10.0),
      //                     child: Row(
      //                       mainAxisSize: MainAxisSize.max,
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: <Widget>[
      //                         Text("Net Banking",
      //                             maxLines: 10,
      //                             style: TextStyle(
      //                                 fontSize: 15.0, color: Colors.black)),
      //                         Radio<int>(
      //                             value: 0,
      //                             groupValue: radioValue,
      //                             onChanged: null),
      //                       ],
      //                     )),
      //                 Divider(),
      //                 _verticalD(),
      //                 Container(
      //                     padding: EdgeInsets.only(left: 10.0),
      //                     child: Row(
      //                       mainAxisSize: MainAxisSize.max,
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: <Widget>[
      //                         Text("Credit / Debit / ATM Card",
      //                             maxLines: 10,
      //                             style: TextStyle(
      //                                 fontSize: 15.0, color: Colors.black)),
      //                         Radio<int>(
      //                             value: 0,
      //                             groupValue: 0,
      //                             onChanged: handleRadioValueChanged),
      //                       ],
      //                     )),
      //                 Divider(),
      //                 _verticalD(),
      //                 Container(
      //                     padding: EdgeInsets.only(left: 10.0),
      //                     child: Row(
      //                       mainAxisSize: MainAxisSize.max,
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: <Widget>[
      //                         Text("Cash on Delivery",
      //                             maxLines: 10,
      //                             style: TextStyle(
      //                                 fontSize: 15.0, color: Colors.black)),
      //                         Radio<int>(
      //                             value: 0,
      //                             groupValue: 0,
      //                             onChanged: null),
      //                       ],
      //                     )),
      //                 Divider(),
      //               ],
      //             )),
      //           ),
      //         )),
      //     Container(
      //         alignment: Alignment.bottomLeft,
      //         height: 50.0,
      //         child: Card(
      //           child: Row(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               IconButton(icon: Icon(Icons.info), onPressed: null),
      //               Text(
      //                 'Total :',
      //                 style: TextStyle(
      //                     fontSize: 17.0,
      //                     color: Colors.black,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 '\₹ 524',
      //                 style: TextStyle(fontSize: 17.0, color: Colors.black54),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Container(
      //                   alignment: Alignment.center,
      //                   child: OutlineButton(
      //                       borderSide: BorderSide(color: Colors.green),
      //                       child: const Text('PROCEED TO PAY'),
      //                       textColor: Colors.green,
      //                       onPressed: () {
      //                         //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
      //                       },
      //                       shape: new OutlineInputBorder(
      //                         borderRadius: BorderRadius.circular(30.0),
      //                       )),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )),
      //   ],
      // ),
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0),
      );
}
