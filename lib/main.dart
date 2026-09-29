import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false, home:TableListScreen()));

class TableListScreen extends StatefulWidget{ @override State<TableListScreen> createState()=>_TableListScreenState();}
class _TableListScreenState extends State<TableListScreen>{
  List<Map<String,dynamic>> tables = List.generate(6, (i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0,"pax":2,"items":[]});
  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFF8F9FF),
      appBar:AppBar(title:Text("TABLE by KGN Tava Fry"), backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white, centerTitle:true),
      body:Column(children:[
        Container(padding:EdgeInsets.all(12), color:Colors.white, child:Row(children:[
          _chip("Dine-in",true), _chip("Takeaway",false), _chip("Delivery",false),
        ])),
        Expanded(child:GridView.builder(padding:EdgeInsets.all(12), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, crossAxisSpacing:12, mainAxisSpacing:12, childAspectRatio:1.2), itemCount:6, itemBuilder:(c,i){
          var t=tables[i];
          Color col = t["status"]=="Empty"?Colors.green.shade100:Colors.red.shade100;
          return InkWell(onTap:(){Navigator.push(context, MaterialPageRoute(builder:(_)=>OrderScreen(table:t, onSave:(u){setState(()=>tables[i]=u);}))).then((_)=>setState((){}));}, child:Container(decoration:BoxDecoration(color:col, borderRadius:BorderRadius.circular(16)), padding:EdgeInsets.all(12), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text(t["name"], style:TextStyle(fontSize:22, fontWeight:FontWeight.bold)), Icon(Icons.table_restaurant)]),
            SizedBox(height:8),
            Text(t["status"], style:TextStyle(fontWeight:FontWeight.bold, color:t["status"]=="Empty"?Colors.green:Colors.red)),
            Spacer(),
            if(t["amount"]>0) Text("₹${t["amount"]}", style:TextStyle(fontWeight:FontWeight.bold, fontSize:18, color:Color(0xFFA33900))),
            Text("${t["pax"]} PAX | ${t["items"].length} Items", style:TextStyle(fontSize:11))
          ])));
        }))
      ]),
      bottomNavigationBar:BottomNavigationBar(selectedItemColor:Color(0xFFA33900), type:BottomNavigationBarType.fixed, items:[
        BottomNavigationBarItem(icon:Icon(Icons.table_restaurant), label:"Tables"),
        BottomNavigationBarItem(icon:Icon(Icons.add_circle), label:"New"),
        BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu), label:"Live KOT"),
        BottomNavigationBarItem(icon:Icon(Icons.receipt_long), label:"Orders"),
        BottomNavigationBarItem(icon:Icon(Icons.bar_chart), label:"Summary"),
      ]),
    );
  }
  Widget _chip(String t,bool sel)=>Container(margin:EdgeInsets.only(right:6), padding:EdgeInsets.symmetric(horizontal:10,vertical:5), decoration:BoxDecoration(color:sel?Color(0xFFA33900):Color(0xFFE5EEFF), borderRadius:BorderRadius.circular(20)), child:Text(t, style:TextStyle(color:sel?Colors.white:Colors.black, fontSize:11, fontWeight:FontWeight.bold)));
}

class OrderScreen extends StatefulWidget{
  final Map<String,dynamic> table;
  final Function(Map<String,dynamic>) onSave;
  OrderScreen({required this.table, required this.onSave});
  @override State<OrderScreen> createState()=>_OrderScreenState();
}
class _OrderScreenState extends State<OrderScreen>{
  String cat="All"; String search="";
  List<String> cats=["All","Chicken Fry","Mutton Item","Zinga-Machhi","Anda Item","Veg Item","Roti-Rice"];
  late List<Map<String,dynamic>> menu;
  @override void initState(){
    super.initState();
    menu=[
      {"id":1,"name":"Murga Do Pyaza","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":2,"name":"Murga Moghlai","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":3,"name":"Chicken Handi","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":4,"name":"Chicken Pisawar","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":5,"name":"Murg Shahi","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":6,"name":"Malai Tikka","priceH":180,"priceF":350,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":7,"name":"Tikka Masala","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":8,"name":"Chicken Kadhai","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":9,"name":"Chicken Garlic","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":10,"name":"Chicken India","priceH":250,"priceF":450,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":11,"name":"Butter Boneless","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":12,"name":"White Chicken","priceH":180,"priceF":350,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":13,"name":"Green Chicken","priceH":180,"priceF":350,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":14,"name":"Chicken Fry","priceH":120,"priceF":220,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":15,"name":"Chicken Masala","priceH":120,"priceF":220,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":16,"name":"Chicken Biryani","priceH":80,"priceF":120,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":17,"name":"Tandoori Masala","priceH":250,"priceF":480,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":18,"name":"Amdavadi Masala","priceH":160,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":19,"name":"Tikka Rice","priceH":
