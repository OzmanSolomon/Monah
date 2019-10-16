import 'package:f_groceries/Cart_Screen.dart';
import 'package:f_groceries/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;


// Fav button
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
@override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        
      ],
    );
  }
  
void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _favoriteCount -= 1;
      _isFavorited = false;
    } else {
      _favoriteCount += 1;
      _isFavorited = true;
    }
  });
}

}

// end of fav button

// start of cart itemss number
class CartItemNumeWidget extends StatefulWidget {
  @override
  _CartItemNumeWidgetState createState() => _CartItemNumeWidgetState();
}
class _CartItemNumeWidgetState extends State<CartItemNumeWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
@override
  Widget build(BuildContext context) {
    return
   
              //  StatefulBuilder(
              // builder: (BuildContext context, StateSetter setState) {
              //   return 
                Stack(
                  children:
                   <Widget>[
                    new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_screen()));
                        }),
                    // globals.itemcount.length == 0
                    //     ? new Container()
                    //     :
                        //  new Positioned(
                        // child: new Stack(
                        //   children: <Widget>[
                        //     new Icon(Icons.brightness_1,
                        //         size: 20.0, color: Colors.red.shade500),
                        //     new Positioned(
                        //         top: 4.0,
                        //         right: 5.5,
                        //         child: new Center(
                        //           child: new Text(
                        //             // globals.count.toString(),
                        //            globals.Cart.length.toString(),
                        //             style: new TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 11.0,
                        //                 fontWeight: FontWeight.w500),
                        //           ),
                        //         )),
                        //   ],
                        // )
                        // ),
            
                  ],
                );
                  // },);
            
            ///
 
 
 
  }
  


}

// end of Cart items number

// start of( add Remove Quan amount
class QuantityeWidget extends StatefulWidget {
  QuantityeWidget({ @required this.destination})
      : assert(destination != null);
  final globals.Item destination;



  @override
  _QuantityeWidgetState createState() => _QuantityeWidgetState(destination: destination);
}

class _QuantityeWidgetState extends State<QuantityeWidget> {
  _QuantityeWidgetState({ @required this.destination})
      : assert(destination != null);

  final globals.Item destination;
  bool _isFavorited = true;
  double _qunt = 1 ;
  int _myid = globals.itemcount.length;
  
@override
  Widget build(BuildContext context) {
     final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =        theme.textTheme.headline.copyWith(color: Colors.white);
  final TextStyle descriptionStyle = theme.textTheme.subhead;

 
    return 
                           
                                  Column( 
                                      children: <Widget>[Container(
                                           margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 00.0, bottom: 0.0),
                                             child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            new IconButton(
                                                              icon: Icon(
                                                                  Icons.plus_one,
                                                                  color: Colors
                                                                      .amber
                                                                      .shade500),
                                                              onPressed: () {
                                                              //    globals.itemcount[ind] =  globals.itemcount[ind] + 1;
                                                          
                                                 setState(() {
                                                        _qunt +=1;
                                                         });
                                                             print( _qunt);
                                                              },

                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  left: 2.0),
                                                            ),
                                                            Text(
                                                           //   item.toString(),
                                                          _qunt.toString(),
                                                                  style: descriptionStyle.copyWith(
                                                   fontSize: 20.0,
                                                   color: Colors.black87),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  right: 2.0),
                                                            ),
                                                            new IconButton(
                                                              icon: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .amber
                                                                      .shade500),
                                                              onPressed: () {
                                                                 if( _qunt >0){
                                                          setState(() {
                                                          _qunt -= 1;
                                                                           });
                                                    print( _qunt);
                                                 }                                                
                                                              },
                                                            ),
                                                          ],
                                                        ),

      ),
       //add  buttons

                Container(
                  alignment: Alignment.center,
                  child: OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: const Text('أضف'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                     //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
                   print(destination.itemname + "  تمت الاضافة ");
                                 globals.Cart.add(destination);            
                  final snackBar = SnackBar(content: Text(destination.itemname + "  تمت الاضافة "));                 
                    Scaffold.of(context).showSnackBar(snackBar);
                //  Scaffold.of(context).
                  setState(() {
                          globals.itemcount.add(_qunt ); // add count
                          globals.itemidlist.add(destination.id );
                           print("item count list:  "+globals.itemcount.toString()  );
                           print("item id list:  "+globals.itemidlist.toString()  );
                          globals.count+=1;        });
                  print( globals.Cart.length.toString() + "item||count" + globals.itemcount.length.toString() );
                                      },
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                
              
                ),

                           //   },),
                                         ]  
                                          );
  }


}

// end of add Remove Quan amount


class Item_Screen extends StatefulWidget {
  final String toolbarname;

  Item_Screen({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => item(toolbarname);
}



class item extends State<Item_Screen> {
  List<globals.Item> ProductsList = List();
  final List<globals.Item> Cart = List();
  int count = 0;
  var isLoading = false;
  @override
void initState() {
   _fetchData();
   }
   
  void _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://monah.store/index.php?api&Load"+  globals.catogryval);
    if (response.statusCode == 200) {
      ProductsList = (json.decode(response.body) as List)
          .map((data) => new globals.Item.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
//
  
  List list = ['12', '11','13'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  item(this.toolbarname);

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
  

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
     _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://monah.store/index.php?api&LoadVeg");
    if (response.statusCode == 200) {
      ProductsList = (json.decode(response.body) as List)
          .map((data) => new globals.Item.fromJson(data))
          .toList();
      setState(() {
        
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
//




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
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                //delegate: _delegate,
              );

            },
          ),
          IconButton(
            tooltip: 'Sort',
            icon: const Icon(Icons.filter_list),
            onPressed: () {
          //  _fetchData();
          // _sendOrder();
            //  _showBottomSheet();
            }

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
                
             child:   CartItemNumeWidget(),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            // height: 500.0,
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                //list2
                //itemList
                
                children: ProductsList.map((globals.Item Item) {
                  return TravelDestinationItem(
                    destination: Item,

                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),

      /* return new GestureDetector(

                  onTap: (){},
                  child: Container(
                    height: 360.0,
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          new Container(

                         child: SizedBox(
                        height: 184.0,
                           child:Image.asset(
                                    itemList[index].imagename,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          ),
                          new Container(

                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(itemList[index].itemname,style: TextStyle(color: Colors.black87,fontSize: 17.0,fontWeight: FontWeight.bold),),
                                Text(itemList[index].itemname,style: TextStyle(color: Colors.black38,fontSize: 17.0),)
                              ],
                            ),
                          )


                          // description and share/explore buttons

                        ],

                      ),

                    ),
                  ),
                );*/
    );
  }


  _verticalDivider() =>
      Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() =>
      Container(
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

  List<RangeSliderData> rangeSliders;
  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
        setState(() {
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));
      // Add an extra padding at the bottom of each RangeSlider
      children.add(new SizedBox(height: 8.0));
    }

    return children;
  }
  void _showBottomSheet() {
    setState(() { // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      final ThemeData themeData = Theme.of(context);
      return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: themeData.disabledColor))
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

              Row(

                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[

                  IconButton(icon: const Icon(Icons.close), onPressed: (){
                    Navigator.pop(context);
                  }),
                  Text('FILTER/SORTING',
                    style: TextStyle(fontSize: 12.0, color: Colors.black26),),
                  _verticalD(),
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: const Text('CLEAR'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {},
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),

                  _verticalD(),
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.amber.shade500),
                      child: const Text('APPLY'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {},
                      shape: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),

                ],
              ),

              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Sort', style: TextStyle(color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),
              Container(
                  height: 115.0,
                  margin: EdgeInsets.only(left: 7.0,top: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'LOWEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),



                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'HEGHEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'POPULER',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'NEWEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),



                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),Container(
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(


                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'BEST',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'PRICE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'FIRST',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),



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
                  )
              ),
              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Filter', style: TextStyle(color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                      ),
                      _verticalDivider(),
                      Text('PRICE', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),

      /*  Container(
          padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: new Column(
              children: <Widget>[]
                ..add(
                  //
                  // Simple example
                  //
                  new RangeSlider(
                    min: 0.0,
                    max: 100.0,
                    lowerValue: _lowerValue,
                    upperValue: _upperValue,
                    divisions: 5,
                    showValueIndicator: true,
                    valueIndicatorMaxDecimals: 1,
                    onChanged: (double newLowerValue, double newUpperValue) {
                      setState(() {
                        _lowerValue = newLowerValue;
                        _upperValue = newUpperValue;
                      });
                    },
                    onChangeStart:
                        (double startLowerValue, double startUpperValue) {
                      print(
                          'Started with values: $startLowerValue and $startUpperValue');
                    },
                    onChangeEnd: (double newLowerValue, double newUpperValue) {
                      print(
                          'Ended with values: $newLowerValue and $newUpperValue');
                    },
                  ),
                )
              // Add some space
                ..add(
                  new SizedBox(height: 24.0),
                )
              //
              // Add a series of RangeSliders, built as regular Widgets
              // each one having some specific customizations
              //
                ..addAll(_buildRangeSliders())),
        ),*/

              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      _verticalDivider(),
                      Text('SELECT OFFER', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),

              Container(
                  height: 80.0,
                  margin: EdgeInsets.only(left: 7.0,top: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.pink.shade100,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    color: Colors.pink.shade100,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Buy More,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'Save More',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.indigo.shade500,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(

                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Special,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'Price',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.teal.shade200,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(

                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Item of,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'The Day',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height:80.0,
                        width: 120.0,
                        child: Card(
                          color: Colors.yellow.shade100,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(

                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        new Text(
                                          'Buy 1,,',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'GET 1 FREE',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),



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
                  )
              ),

              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      _verticalDivider(),
                      Text('DISCOUNT', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),

              Container(
                  height: 90.0,
                  margin: EdgeInsets.only(left: 7.0,top: 5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '10%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),


                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '20%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '30%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      Container(
                        height:80.0,

                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: <Widget>[
                                        new Text(
                                          '40%',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        _verticalDivider(),
                                        new Text(
                                          'OR LESS',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                              letterSpacing: 0.5),
                                        ),




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
                  )
              ),

              _verticalDivider(),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      _verticalDivider(),
                      Text('AVAILIBILITY', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
              ),
              _verticalDivider(),
              Container(
                  child: Align(
                    alignment: const Alignment(0.0, -0.2),
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      _verticalDivider(),
                      Radio<int>(
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChanged
                      ),

                      Text('Available for this location', style: TextStyle(color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      ),



                    ],
                  )
                  )
              ),




            ]),
      );
    })
        .closed.whenComplete(() {
      if (mounted) {
        setState(() { // re-enable the button
          _showBottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }

  int radioValue = 0;
  bool switchValue = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }


}

class TravelDestinationItem extends StatelessWidget {
  TravelDestinationItem({Key key, @required this.destination, this.shape})
      : assert(destination != null),
        super(key: key);
  
  static const double height = 656.0;
  final globals.Item destination;
  final ShapeBorder shape;
//globals.Item des ;

  
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          height: height,
          child: GestureDetector(
            onTap: (){//image
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
              // print(destination.itemname + "تمت الاضافة");
            },

          child: Card(
            shape: shape,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // photo and title
                SizedBox(
                  height: 100.0,
                  child: Stack(
                    children: <Widget>[
                     Positioned.fill(
                        // child:  Image.asset(
                        //   destination.imagename,
                   
                   child:  CachedNetworkImage(
                            imageUrl: destination.imagename,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(Icons.error),

                          // package: destination.assetPackage,
                          fit: BoxFit.scaleDown,
                        ),
                     ),
                      Container(
                        alignment: Alignment.topLeft,
                       padding: EdgeInsets.all(5.0),
                      //  child:   FavoriteWidget(),
                        //IconButton(icon: const Icon(Icons.favorite_border), onPressed: (){

                     //   }),
                      ),
                    ],
                  ),

                ),
                // description and share/explore buttons
                Divider(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 1.0, 16.0, 0.0),
                    child: DefaultTextStyle(
                      style: descriptionStyle,
                      child: Column(
                        children: [
                        Row(
                            mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                      
                       
                          // three line description
                           Padding(
                             
                            padding: const EdgeInsets.only(bottom:0.0),
                            
                            child: Text(

                         
                            destination.unit.toString()    ,
                             
                              style: descriptionStyle.copyWith(
                              
                                fontSize: 12.0,
                                  color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Text(
                              destination.itemname,
                              style: descriptionStyle.copyWith(
                                  fontSize: 14.0,
                                  color: Colors.black87),
                            ),
                          ),
                         
                        ],),
                          // + & -Quan start of 
                         
                              QuantityeWidget( destination: destination),
                //end 
                          // Text(destination.description[1]),
                          // Text(destination.description[2]),
                        ],
                      ),
                    ),
                  ),
                ),
                 //statefullbuilder
              
              ],
            ),
          ),
        )
        )
    );



  }



 /* List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0, max: 100.0, lowerValue: 10.0, upperValue: 100.0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          overlayColor: Colors.red[100]),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: false,
          valueIndicatorMaxDecimals: 0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: true,
          valueIndicatorMaxDecimals: 0,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red[50],
          valueIndicatorColor: Colors.green),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          thumbColor: Colors.grey,
          valueIndicatorColor: Colors.grey),
    ];
  }*/
}

// ---------------------------------------------------
// Helper class aimed at simplifying the way to
// automate the creation of a series of RangeSliders,
// based on various parameters
//
// This class is to be used to demonstrate the appearance
// customization of the RangeSliders
// ---------------------------------------------------
class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xFF0175c2);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  // Builds a RangeSlider and customizes the theme
  // based on parameters
  //
  Widget build(BuildContext context, RangeSliderCallback callback) {
    return new Container(
      width: double.infinity,
      child: new Row(
        children: <Widget>[
          new Container(
            constraints: new BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: new Text(lowerValueText),
          ),
          new Expanded(
            child: new SliderTheme(
              // Customization of the SliderTheme
              // based on individual definitions
              // (see rangeSliders in _RangeSliderSampleState)
              data: SliderTheme.of(context).copyWith(
                overlayColor: overlayColor,
                activeTickMarkColor: activeTickMarkColor,
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                thumbColor: thumbColor,
                valueIndicatorColor: valueIndicatorColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: new RangeSlider(
                min: min,
                max: max,
                lowerValue: lowerValue,
                upperValue: upperValue,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          new Container(
            constraints: new BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: new Text(upperValueText),
          ),
        ],
      ),
    );
  }
}

