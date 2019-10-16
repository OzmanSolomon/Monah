import 'package:f_groceries/Cart_Screen.dart';
import 'package:f_groceries/help_screen.dart';
import 'package:f_groceries/item_screen.dart';
import 'package:f_groceries/logind_signup.dart';
import 'package:f_groceries/orderhistory_screen.dart';
import 'package:f_groceries/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'Account_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class Home_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new home();
// TODO: implement createState

}

class Photo {
  Photo({

    this.assetName,
    this.assetPackage,
    this.title,
    this.caption,
    this.id,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String caption;
   final String id;
}

class home extends State<Home_screen> {
  List list = ['12', '11'];
 String userEmail = "";
String userName = "";
  
  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'images/veg.jpg',
      title: 'خضروات',
       id: '1',
    ),
  
    Photo(
      assetName: 'images/bev.jpg',
      title: 'فواكه',
       id: '2',
    ),
    
  
  ];

  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  static const double height = 366.0;
  String name ='My Wishlist';
 var isLoading = false;

 updatelogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('logedinstate', 'false');
  prefs.setString('logedinemail', "");
}
 void initState() {
   GetLogedEmail() ;

 }
String _logedEmail = "";
 GetLogedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   _logedEmail = prefs.getString('logedinemail') ?? '';
globals.logedEmail = _logedEmail;
  // _logedEmail= "omerahmed41@gmail.com";
   _fetchData(_logedEmail);
   print(_logedEmail);
    }

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
               userEmail = globals.userlist.elementAt(0).email ;
    userName = globals.userlist.elementAt(0).name ;
     isLoading = false;
    });
        } else {
      throw Exception('Failed to load photos');
    }
  }
//get user info




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  //  final Orientation orientation = MediaQuery.of(context).orientation;
   // final ThemeData theme = Theme.of(context);
    //final TextStyle titleStyle =        theme.textTheme.headline.copyWith(color:  globals.appbarcolor);
   // final TextStyle descriptionStyle = theme.textTheme.subhead;
    ShapeBorder shapeBorder;
 
    return Scaffold(

      drawer: new Drawer(
        
        child: new ListView(
          children: <Widget>[
           new Card(
              elevation: 4.0,
        
             child:  DrawerHeader(
               decoration: new BoxDecoration(            
                  color: globals.drawercolor,             

                ),
      //  child:UserAccountsDrawerHeader(
          child: new Column(
            
             children: <Widget>[
          
            ListTile(
                      leading: Icon(Icons.supervised_user_circle, color: globals.appbarcolor,),
                      title: new Text(userName),
           ),
      
        ListTile(
                      leading: Icon(Icons.email, color: globals.appbarcolor,),
                      title: new Text(userEmail , style:
                        new TextStyle( fontSize: 10.0),),
                        onTap: (){
                  Navigator.push(  context,    MaterialPageRoute(
                          builder: (context) => Account_Screen()));
               
        
                }, ),
                
         
               
          
             ],),
                // onDetailsPressed: () {
                //   Navigator.push(  context,    MaterialPageRoute(
                //           builder: (context) => Account_Screen()));
               
               
                // },
                
                // decoration: new BoxDecoration(            
                //   color: globals.drawercolor,             

                // ),
                // currentAccountPicture: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         "https://www.fakenamegenerator.com/images/sil-female.png")
                //         ),
              // ),
            // ),
             ),  
        ),
            // new Card(
            //   elevation: 4.0,
            //   child: new Column(
            //     children: <Widget>[
            //       // new ListTile(
            //       //     leading: Icon(Icons.favorite),
            //       //     title: new Text(name),
            //       //     onTap: () {
            //       //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: name,)));
            //       //     }),
            //       // new Divider(),
                
            //     ],
            //   ),
            // ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                    new ListTile(
                      leading: Icon(Icons.history, color: globals.appbarcolor,),
                      title: new Text("طلباتي"),


                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Oder_History(toolbarname: 'طلباتي',)));

                      }),
                  // new ListTile(
                    
                  //     leading: Icon(Icons.settings, color: globals.appbarcolor,),
                  //     title: new Text("الاعدادات"),
                  //     onTap: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                  //     }),
                 // new Divider(),
                  new ListTile(
                      leading: Icon(Icons.help, color: globals.appbarcolor,),
                      title: new Text("مساعدة"),
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));

                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new ListTile(
                  leading: Icon(Icons.power_settings_new, color: globals.appbarcolor,),
                  title: new Text(
                    "تسجيل الخروج",
                    style:
                        new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                  ),
                  onTap: () {
                    updatelogout();
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Login_Screen()));
                  }),
            )
          ],
        ),
      ),
     

      appBar: new AppBar(
        backgroundColor: globals.appbarcolor,

        title: Text("مؤنة"),
        actions: <Widget>[
          IconButton(
            tooltip: 'بحث',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                //delegate: _delegate,
              );

            },
          ),
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
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                        }),
                    list.length == 0
                        ? new Container()
                        : new Positioned(
                            child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.orange.shade500),
                              new Positioned(
                                  top: 4.0,
                                  right: 5.5,
                                  child: new Center(
                                    child: new Text(
                                       globals.itemcount.length.toString(),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      
      body: new SingleChildScrollView(
        child: Container(
          child: new Column(children: <Widget>[
            new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _verticalD(),
                  new GestureDetector(
                    onTap: () {
               //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                    },
                    child: new Text(
                      'العروض المميزة',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _verticalD(),
                  // new GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                  //   },
                  //   child: new Text(
                  //     'Top sellers',
                  //     style: TextStyle(
                  //         fontSize: 20.0,
                  //         color: Colors.black26,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // _verticalD(),
                  // new Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     new GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                  //       },
                  //       child: new Text(
                  //         'All',
                  //         style: TextStyle(
                  //             fontSize: 20.0,
                  //             color: Colors.black26,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     _verticalD(),
                  //     IconButton(
                  //       icon: keyloch,
                  //       color: Colors.black26,
                  //     )
                  //   ],
                  // )
                ]),
            new Container(
              height: 188.0,
              margin: EdgeInsets.only(left: 5.0),
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/grthre.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )

                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/grtwo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )

                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/groceries.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )

                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/back.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )

                          /*Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('',
                              style: titleStyle,
                            ),
                          ),
                        ),*/
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
              ]),
            ),
            new Container(
              margin: EdgeInsets.only(top: 7.0,right: 0.0),
              child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                     // globals.catogryval = "AllItems";
                     //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'كل المنتجات',)));
                      },
                      child: new Text(
                        'التصنيفات',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // _verticalD(),
                    // new GestureDetector(
                    //   onTap: () {
                    //    // Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                    //   },
                    //   child: new Text(
                    //     'الأكثر طلبا',
                    //     style: TextStyle(
                    //         fontSize: 20.0,
                    //         color: Colors.black26,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                 
                    _verticalD(),
                    new Row(
                      children: <Widget>[
                        // new GestureDetector(
                        //   onTap: () {
                        //  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                        //   },
                        //   child: new Text(
                        //     'اضيف حديثا',
                        //     style: TextStyle(
                        //         fontSize: 20.0,
                        //         color: Colors.black26,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
              
                      ],
                    )
                  ]),
            ),
            new Container(
              alignment: Alignment.topCenter,
              height: 700.0,

              child: new GridView.builder(
                  itemCount: photos.length,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: (){
                        if (photos[index].id == '2'){
                          globals.catogryval = "fruit";
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'فواكه',)));
                      } else if (photos[index].id == '1'){
                          globals.catogryval = "Veg";
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'خضروات',)));
                      }
                   
                      },

                        child: new Container(
                            margin: EdgeInsets.all(5.0),
                            child: new Card(
                              shape: shapeBorder,
                              elevation: 3.0,
                              child: new Container(
                                //  mainAxisSize: MainAxisSize.max,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 152.0,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                              child: Image.asset(
                                            photos[index].assetName,
                                            fit: BoxFit.cover,
                                          )),
                                          Container(
                                            color: Colors.black38,
                                          ),
                                          Container(
                                            //margin: EdgeInsets.only(left: 10.0),
                                            padding: EdgeInsets.only(
                                                left: 3.0, bottom: 3.0),
                                            alignment: Alignment.bottomLeft,
                                            child: new GestureDetector(
                                              onTap: () {
                                             //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                                              },
                                              child: new Text(
                                                photos[index].title,
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),

                                          /*Positioned(
                                    child: FittedBox(

                                     fit: BoxFit.fill,
                                      alignment: Alignment.centerLeft,
                                      child: Text(photos[index].title,
                                        style: TextStyle(color: Colors.black87,fontSize: 15.0),
                                      ),

                                  )
                                  )*/
                                        ],
                                      ),
                                    ),

                                    // new Text(photos[index].title.toString()),
                                  ],
                                ),
                              ),
                            )
                        )

                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }

/*
  new Container(
  alignment: Alignment.topCenter,
  child: GridView.count(
  primary: true,
  crossAxisCount: 2,
  childAspectRatio: 0.80,
  children: List.generate(photos.length, (index) {
  return getStructuredGridCell(photos[index]);
  }),
  ))*/
  Icon keyloch = new Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0, bottom: 0.0),
      );


}
