library my_prj.globals;

import 'package:flutter/material.dart';

bool isLoggedIn = false;
String logedEmail = "";
  double latitude ;
 double longitude ;
String selectedcity = 'أختر المدينة';
String selectedTown = 'أختر المدينة اولا';
String delveryTime = 'زمن التوصيل ';
String selectedcityid = null;
String selectedTownid = null;
String delveryTimeid = null;
List<String>  citiesList = List();
List<String>  townsList = List();
List<String>  delveryTimelist = List();
Color appbarcolor = Colors.green;

Color drawercolor = Colors.white24;

 
List<Item> Cart = List();
List<String> itemidlist = List();
List<double> itemcount = List();
List<Userinfo> userlist = List();
List<OrderDetials> OrderDetialsList = List();
String catogryval ;
bool ordersended = false;
String comments = "comments";
double totalsum = 0;
double count =0 ;
 
class Item {
  final String itemname;
  final String imagename;
   var itmprice;
  final String id;
  final String unit;

  Item({this.itemname, this.imagename, this.itmprice, this.id, this.unit});
  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(
      itemname: json['name'],
      itmprice: json['price'],
      unit: json['unit'],
      imagename: json['image'],
      id: json['id'],
    );
  }
}

//order hisotry detials
class OrderDetials {
   String items ="";
   String address="";
   String address_text ='0';
   String comments='0';
   String Date='0';
   String stats='0';
  String order_id='0';
   var order_value;
   //var  order_value = 0;
  

  OrderDetials({this.items, this.address, this.address_text, this.comments, this.Date,this.stats,
   this.order_id, this.order_value});
  factory OrderDetials.fromJson(Map<String, dynamic> json) {
    return new OrderDetials(
      address: json['address'],
      comments: json['comments'],
       Date: json['Date'],
      stats: json['stats'],
      order_id: json['order_id'],
      items: json['items'],
      address_text: json['address_text'],
      order_value: json['order_value'],

    );
}


}
class DeliveryTimeinfo {
  final String  id; 
  final String  name;
  
  DeliveryTimeinfo({this.id,this.name});
  factory DeliveryTimeinfo.fromJson(Map<String, dynamic> parsedJson){
  return DeliveryTimeinfo(
    id: parsedJson['id'],
    name: parsedJson['time'], 
  );
}
}
 
 class Cityinfo {
  final String  id; 
  final String  name;
  
  Cityinfo({this.id,this.name});
  factory Cityinfo.fromJson(Map<String, dynamic> parsedJson){
  return Cityinfo(
    id: parsedJson['id'],
    name: parsedJson['name'], 
  );
}
}
class Towninfo {
  final String  id; 
  final String  name;
  
  Towninfo({this.id,this.name});
  factory Towninfo.fromJson(Map<String, dynamic> parsedJson){
  return Towninfo(
    id: parsedJson['id'],
    name: parsedJson['name'], 
  );
}
}
Monahnfo monahnfo;
class Monahnfo {
  final String  monahtitle ; 
  final String  monagemail;
final String  monahphone; 
  final String  monahwhatsapp;
final String  monahfacebook; 
  final String  monahtwitter;
final String  monahgogle; 
  final String  chargereq;
final String  minrequests; 
  final String  aboutus;


  
  Monahnfo({this.monahtitle,this.monagemail,this.monahphone,this.monahwhatsapp,this.monahfacebook,
  this.monahtwitter
  ,this.monahgogle,this.chargereq,this.minrequests,this.aboutus});
  
  factory Monahnfo.fromJson(Map<String, dynamic> parsedJson){
  return Monahnfo(
    monahtitle: parsedJson['title'],
    monagemail: parsedJson['email'], 
 monahphone: parsedJson['phone'],
 monahwhatsapp: parsedJson['whatsapp'],
    monahfacebook: parsedJson['facebook'], 
 monahtwitter: parsedJson['twitter'],
    monahgogle: parsedJson['google'], 
 chargereq: parsedJson['charge_req'], 
 minrequests: parsedJson['min_requests'],
    aboutus: parsedJson['about_us'], 


    




  );
}
}
 
 class Userinfo {
  final String  id;
   final String  email;
   final String  phone;
   final String  name;
   final String  adress;
   final String  town;
  
  Userinfo({this.id,this.email,this.phone,this.name,this.adress,this.town});
  factory Userinfo.fromJson(Map<String, dynamic> parsedJson){


  return Userinfo(
    id: parsedJson['online_id'],
    email: parsedJson['email'],
    phone: parsedJson['phone'],
    name: parsedJson['full_name'],
    adress: parsedJson['address'],
    town: parsedJson['Town'],
   
  );
}
}