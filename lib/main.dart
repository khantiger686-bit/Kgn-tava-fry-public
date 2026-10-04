import 'package:flutter/material.dart';
void main(){runApp(MaterialApp(debugShowCheckedModeBanner:false,home:Login()));}
class Login extends StatefulWidget{ @override State<Login> createState()=>_L();}
class _L extends State<Login>{
 String s="Salman";
 @override Widget build(BuildContext c){
  return Scaffold(backgroundColor:Color(0xFFFFF3E0),body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
   Icon(Icons.restaurant,size:60,color:Colors.deepOrange),
   Text("KGN TAWA FRY",style:TextStyle(fontSize:24,fontWeight:FontWeight.bold,color:Colors.deepOrange)),
   Text("PRO NO GST",style:TextStyle(color:Colors.grey)),
   SizedBox(height:20),
   for(var w in ["Salman","Aslam","Imran","Admin"]) Card(child:RadioListTile(title:Text(w),value:w,groupValue:s,onChanged:(v){setState(()=>s=v.toString());})),
   SizedBox(height:10),
   ElevatedButton(onPressed:(){Navigator.pushReplacement(c,MaterialPageRoute(builder:(_)=>Home(waiter:s)));},child:Text("LOGIN "+s),style:ElevatedButton.styleFrom(backgroundColor:Colors.deepOrange,foregroundColor:Colors.white,minimumSize:Size(200,45)))
  ])));
 }
}
class Home extends StatefulWidget{final String waiter;Home({required this.waiter});@override State<Home> createState()=>_H();}
class _H extends State<Home>{
 int idx=0;
 List<Map> tables=List.generate(8,(i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amt":0.0,"pax":1,"items":[],"time":"","disc":0.0,"waiter":""});
 List<Map> hist=[]; double day=0;
 List<Map> menu=[
  {"n":"Murgh Do Pyaza","h":160,"f":300,"c":"Chicken"},
  {"n":"Mughlai","h":170,"f":320,"c":"Chicken"},
  {"n":"Handi","h":160,"f":300,"c":"Chicken"},
  {"n":"Malai Tikka","h":180,"f":350,"c":"Chicken"},
  {"n":"Butter Chicken","h":170,"f":320,"c":"Chicken"},
  {"n":"Chicken Fry","h":120,"f":220,"c":"Chicken"},
  {"n":"Chicken Biryani","h":80,"f":120,"c":"Biryani"},
  {"n":"Mutton Fry","h":120,"f":220,"c":"Mutton"},
  {"n":"Fish Fry","h":80,"f":160,"c":"Fish"},
  {"n":"Dal Fry","h":50,"f":100,"c":"Veg"},
  {"n":"Jeera Rice","h":50,"f":100,"c":"Rice"},
  {"n":"Roti","h":7,"f":7,"c":"Roti"},
 ];
 void clear(int i){setState(()=>tables[i]={"id":i+1,"name":"T-${i+1}","status":"Empty","amt":0.0,"pax":1,"items":[],"time":"","disc":0.0,"waiter":""});}
 @override Widget build(BuildContext c){
  var pages=[
   GridView.builder(padding:EdgeInsets.all(12),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:tables.length,itemBuilder:(co,i){
    var t=tables[i];
    Color col=t["status"]=="Empty"?Colors.green.shade100:Colors.red.shade100;
    return InkWell(onTap:(){Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderPage(table:t,menu:menu,onSave:(o){setState((){o["waiter"]=widget.waiter;tables[i]=o;hist.add(o);day+=(o["amt"]-o["disc"]);});})));},child:Container(decoration:BoxDecoration(color:col,borderRadius:BorderRadius.circular(14),border:Border.all(color:Colors.orange.shade200)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(t["name"],style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text(t["status"],style:TextStyle(fontWeight:FontWeight.bold,color:t["status"]=="Empty"?Colors.green:Colors.red)),if(t["amt"]>0) Text("Rs ${(t["amt"]-t["disc"]).toInt()}",style:TextStyle(fontWeight:FontWeight.bold)),Text("${t["pax"]}P ${t["items"].length}I",style:TextStyle(fontSize:10))])));}),
   ListView.builder(padding:EdgeInsets.all(10),itemCount:tables.length,itemBuilder:(co,i){var t=tables[i];return Card(child:ListTile(title:Text(t["name"]+" - "+t["status"]),subtitle:Text(t["status"]=="Occupied"?"Rs ${(t["amt"]-t["disc"]).toInt()}":"Empty"),onTap:(){Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderPage(table:t,menu:menu,onSave:(o){setState((){o["waiter"]=widget.waiter;tables[i]=o;hist.add(o);day+=(o["amt"]-o["disc"]);});})));}));}),
   Center(child:Text("KOT - Tables se order karo")),
   Builder(builder:(co){var occ=tables.where((t)=>t["status"]=="Occupied").toList();if(occ.isEmpty) return Center(child:Text("No Bills"));return ListView.builder(padding:EdgeInsets.all(10),itemCount:occ.length,itemBuilder:(co,i){var t=occ[i];int ri=tables.indexWhere((x)=>x["id"]==t["id"]);double sub=t["items"].fold(0.0,(s,it)=>s+it["price"]*it["qty"]);double d=t["disc"]??0;return Card(child:ListTile(title:Text(t["name"]+" Rs ${(sub-d).toInt()}"),subtitle:Text(t["waiter"]),trailing:ElevatedButton(onPressed:()=>clear(ri),child:Text("Paid"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white))));});}),
   ListView(padding:EdgeInsets.all(14),children:[Card(color:Colors.deepOrange,child:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text("Today No GST",style:TextStyle(color:Colors.white)),Text("Rs ${day.toInt()}",style:TextStyle(color:Colors.white,fontSize:30,fontWeight:FontWeight.bold))]))),ElevatedButton(onPressed:(){setState((){day=0;hist.clear();});},child:Text("Reset"),style:ElevatedButton.styleFrom(backgroundColor:Colors.red,foregroundColor:Colors.white))]),
  ];
  return Scaffold(appBar:AppBar(title:Text("KGN ${widget.waiter}"),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),body:pages[idx],bottomNavigationBar:BottomNavigationBar(currentIndex:idx,onTap:(i)=>setState(()=>idx=i),selectedItemColor:Colors.deepOrange,unselectedItemColor:Colors.grey,type:BottomNavigationBarType.fixed,items:[BottomNavigationBarItem(icon:Icon(Icons.table_restaurant),label:"Tables"),BottomNavigationBarItem(icon:Icon(Icons.add_circle),label:"New"),BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu),label:"KOT"),BottomNavigationBarItem(icon:Icon(Icons.receipt_long),label:"Bills"),BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label:"Report")]));
 }
}
class OrderPage extends StatefulWidget{final Map table;final List<Map> menu;final Function(Map) onSave;OrderPage({required this.table,required this.menu,required this.onSave});@override State<OrderPage> createState()=>_OP();}
class _OP extends State<OrderPage>{
 late Map tbl;int pax=1;List<Map> cart=[];double disc=0;String cat="All";
 @override void initState(){super.initState();tbl=Map.from(widget.table);if(tbl["items"]!=null && (tbl["items"] as List).isNotEmpty){cart=List<Map>.from(tbl["items"].map((e)=>Map.from(e)));pax=tbl["pax"]??1;disc=(tbl["disc"]??0).toDouble();}}
 double get sub{double s=0;for(var it in cart){s+=it["price"]*it["qty"];}return s;}
 double get tot=>sub-disc;
 void add(Map m,String por){int price=por=="Half"?m["h"]:m["f"];setState((){int i=cart.indexWhere((e)=>e["n"]==m["n"] && e["por"]==por);if(i>=0) cart[i]["qty"]++;else cart.add({"n":m["n"],"price":price,"qty":1,"por":por});});}
 @override Widget build(BuildContext context){
  var filt=cat=="All"?widget.menu:widget.menu.where((e)=>e["c"]==cat).toList();
  return Scaffold(appBar:AppBar(title:Text(tbl["name"]+" Rs ${tot.toInt()}"),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),body:Column(children:[
   Container(padding:EdgeInsets.all(8),color:Colors.orange.shade50,child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Row(children:[IconButton(icon:Icon(Icons.remove),onPressed:()=>setState(()=>pax=pax>1?pax-1:1)),Text(pax.toString()),IconButton(icon:Icon(Icons.add),onPressed:()=>setState(()=>pax++))]),Text("Rs ${tot.toInt()}",style:TextStyle(fontWeight:FontWeight.bold))])),
   Container(height:36,child:ListView(scrollDirection:Axis.horizontal,children:["All","Chicken","Mutton","Fish","Veg","Rice","Roti"].map((ch)=>Padding(padding:EdgeInsets.all(2),child:ChoiceChip(label:Text(ch,style:TextStyle(fontSize:10)),selected:cat==ch,onSelected:(v)=>setState(()=>cat=ch)))).toList())),
   Expanded(flex:2,child:GridView.builder(padding:EdgeInsets.all(6),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:2.2,crossAxisSpacing:5,mainAxisSpacing:5),itemCount:filt.length,itemBuilder:(c,i){var m=filt[i];return InkWell(onTap:(){showDialog(context:context,builder:(_)=>AlertDialog(title:Text(m["n"]),content:Text("H Rs ${m["h"]} F Rs ${m["f"]}"),actions:[TextButton(onPressed:(){Navigator.pop(context);add(m,"Half");},child:Text("HALF")),ElevatedButton(onPressed:(){Navigator.pop(context);add(m,"Full");},child:Text("FULL"))]));},child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(8),border:Border.all(color:Colors.grey.shade300)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(m["n"],textAlign:TextAlign.center,style:TextStyle(fontSize:9,fontWeight:FontWeight.bold)),Text("H${m["h"]} F${m["f"]}",style:TextStyle(fontSize:8,color:Colors.deepOrange))])));})),
   Expanded(flex:1,child:cart.isEmpty?Center(child:Text("Tap menu")):ListView.builder(itemCount:cart.length,itemBuilder:(c,i){var it=cart[i];return ListTile(dense:true,title:Text("${it["n"]} [${it["por"]}]",style:TextStyle(fontSize:11)),trailing:Row(mainAxisSize:MainAxisSize.min,children:[IconButton(icon:Icon(Icons.remove,size:14),onPressed:(){setState((){if(it["qty"]>1)it["qty"]--; else cart.removeAt(i);});},padding:EdgeInsets.zero,constraints:BoxConstraints()),Text(it["qty"].toString()),IconButton(icon:Icon(Icons.add,size:14),onPressed:(){setState(()=>it["qty"]++;});},padding:EdgeInsets.zero,const
