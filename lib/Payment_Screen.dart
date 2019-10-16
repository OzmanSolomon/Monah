import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'globals.dart' as globals;

class Patment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => payment();
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
// start of payment clas
class payment extends State<Patment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 Completer<GoogleMapController> _controller = Completer();



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

    //  Padding(// center marker
    //   padding: const EdgeInsets.all(16.0),
    //   child: Align(
    //     alignment: Alignment.center,
    //     child: FloatingActionButton(
    //   //    onPressed: _getLocation,
    //       materialTapTargetSize: MaterialTapTargetSize.padded,
    //      backgroundColor: Colors.transparent,
    //       child: const Icon(Icons.location_on, size: 50.0),
    //     ),
    //   ),
    // ), // center marker

//  Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: FloatingActionButton(
//          onPressed: _sendlaglat,
      
//           materialTapTargetSize: MaterialTapTargetSize.padded,
//          backgroundColor: Colors.lightGreen,
//           child: const Icon(Icons.done, size: 50.0),
          
//         ),
//       ),
//     ), // submit
      
  ],),// end of stack

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

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0),
      );
}
