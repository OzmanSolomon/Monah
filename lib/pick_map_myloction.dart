import 'package:f_groceries/HomeScreen.dart';
import 'package:f_groceries/logind_signup.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'globals.dart' as globals;
// import 'package:flutter_launcher_icons/android.dart';
// import 'package:flutter_launcher_icons/constants.dart';
// import 'package:flutter_launcher_icons/custom_exceptions.dart';
// import 'package:flutter_launcher_icons/ios.dart';
// import 'package:flutter_launcher_icons/main.dart';
// import 'package:flutter_launcher_icons/xml_templates.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.

            primaryColor: Colors.green,
            primaryColorDark: Colors.white30,
            accentColor: Colors.green

        ),
      home: new MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
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
    zoom: 2.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(globals.latitude, globals.longitude),
      //tilt: 59.440717697143555,
      zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
  appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child:new  AppBar(
        backgroundColor: globals.appbarcolor,
 ), 
    ),

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
   Align(
  alignment: Alignment.center,
  child: Icon(
  Icons.location_on,
 color: Colors.lightGreen,
  size: 50.0,
)
      
),

 Align(
  alignment: Alignment.bottomCenter,
  child: RaisedButton(
  
          onPressed: () {_sendlaglat();
          },
          child: const Text(
            'أرسل موقعي',
            style: TextStyle(fontSize: 20, color: Colors.lightGreen,)
          ),
        ),
      
)

      //   Padding(

      // padding: const EdgeInsets.all(14.0),
      // child: Align(
      //   alignment: Alignment.center,
      //   child: 
      //   FloatingActionButton(
      // //    onPressed: _getLocation,
      //     materialTapTargetSize: MaterialTapTargetSize.padded,
      //    backgroundColor: Colors.transparent,
      //     child: const Icon(Icons.location_on, size: 50.0),
      //   ),
      //  ), //center marler
      //    ),

   
  ], ),
    

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
//     ), // cente // center marler
      // end of stack

      //start fluting bt
      floatingActionButton: FloatingActionButton.extended(
         backgroundColor: globals.appbarcolor,
        onPressed:_getLocation,
        label: Text('',
         style: TextStyle(color: Colors.black54,
                          fontSize: 10.0,
                          fontWeight: FontWeight.normal),),
        icon: Icon(Icons.location_searching,size: 14.0),
      ), 
      
      
      // floating bt
    );
  }

//onCameraMove: ((_position) => _updateMarker(_position)),   
  Future<void> _sendlaglat ()async{
   Navigator.pop(context);
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



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }


  void navigationPage() {
    
    isLogin() ;

  }

    isLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final logedinstate = prefs.getString('logedinstate') ?? '';
    print(logedinstate);
if (logedinstate == 'true'){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Home_screen()));
} else 
{
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen()));

}
}
   
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(color: Colors.white),
      child: new Container(
        color: Colors.white,
        margin: new EdgeInsets.all(30.0),
        width: 250.0,
        height: 250.0,
        child: new Image.asset(
          'images/gro.jpg',
        ),
      ),
    );
  }

}
