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
 List<Map> tables=List.generate(8,(i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amt":0.0,"pax":1,"items":[],"time":"","hold":false,"waiter":"","disc":0.0});
 List<Map> hist=[];
 double day=0;
 List<Map> menu=[
  {"n":"Murgh Do Pyaza","h":160,"f":300,"c":"Chicken"},
  {"n":"Mughlai","h":170,"f":320,"c":"Chicken"},
  {"n":"Chicken Handi","h":160,"f":300,"c":"Chicken"},
  {"n":"Malai Tikka","h":180,"f":350,"c":"Chicken"},
  {"n":"Tikka Masala","h":170,"f":320,"c":"Chicken"},
  {"n":"Butter Chicken","h":170,"f":320,"c":"Chicken"},
  {"n":"Chicken Fry","h":120,"f":220,"c":"Chicken"},
  {"n":"Chicken Biryani","h":80,"f":120,"c":"Biryani"},
  {"n":"Mughlai Mutton","h":150,"f":280,"c":"Mutton"},
  {"n":"Mutton Fry","h":120,"f":220,"c":"Mutton"},
  {"n":"Kheema Fry","h":80,"f":160,"c":"Mutton"},
  {"n":"Fish Fry","h":80,"f":160,"c":"Fish"},
  {"n":"Prawns Fry","h":130,"f":240,"c":"Fish"},
  {"n":"Anda Bhurji","h":50,"f":100,"c":"Egg"},
  {"n":"Dal Tadka","h":70,"f":140,"c":"Veg"},
  {"n":"Dal Fry","h":50,"f":100,"c":"Veg"},
  {"n":"Masala Rice","h":50,"f":100,"c":"Rice"},
  {"n":"Jeera Rice","h":50,"f":100,"c":"Rice"},
  {"n":"Roti","h":7,"f":7,"c":"Roti"},
  {"n":"Paratha","h":20,"f":20,"c":"Roti"},
  {"n":"Papad","h":10,"f":10,"c":"Roti"},
 ];
 void clear(int i){setState(()=>tables[i]={"id":i+1,"name":"T-${i+1}","status":"Empty","amt":0.0,"pax":1,"items":[],"time":"","hold":false,"waiter":"","disc":0.0});}
 @override Widget build(BuildContext c){
  List<Widget> p=[
   GridView.builder(padding:EdgeInsets.all(12),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:tables.length,itemBuilder:(co,i){
    var t=tables[i];
    Color col=t["status"]=="Empty"?Colors.green.shade100:t["hold"]==true?Colors.yellow.shade100:Colors.red.shade100;
    return InkWell(onTap:(){Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderPage(table:t,menu:menu,onSave:(o){setState((){o["waiter"]=widget.waiter;tables[i]=o;hist.add(o);day+=(o["amt"]-o["disc"]);});}));},child:Container(decoration:BoxDecoration(color:col,borderRadius:BorderRadius.circular(14),border:Border.all(color:Colors.orange.shade200)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(t["name"],style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),Text(t["status"],style:TextStyle(color:t["status"]=="Empty"?Colors.green:Colors.red,fontWeight:FontWeight.bold)),if(t["amt"]>0) Text("Rs ${(t["amt"]-t["disc"]).toInt()}",style:TextStyle(fontWeight:FontWeight.bold)),Text("${t["pax"]}PAX ${t["items"].length} items",style:TextStyle(fontSize:10)),if(t["waiter"]!="") Text(t["waiter"],style:TextStyle(fontSize:9,color:Colors.blue)),if(t["hold"]==true) Text("HOLD",style:TextStyle(fontSize:9,color:Colors.orange))])));}),
   ListView.builder(padding:EdgeInsets.all(10),itemCount:tables.length,itemBuilder:(co,i){var t=tables[i];return Card(child:ListTile(title:Text(t["name"]+" - "+t["status"]),subtitle:Text(t["status"]=="Occupied"?"Rs ${(t["amt"]-t["disc"]).toInt()} | ${t["waiter"]}":"Empty"),onTap:(){setState(()=>idx=0);Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderPage(table:t,menu:menu,onSave:(o){setState((){o["waiter"]=widget.waiter;tables[i]=o;hist.add(o);day+=(o["amt"]-o["disc"]);});})));}));}),
   Builder(builder:(co){var live=tables.where((t)=>t["status"]=="Occupied").toList();if(live.isEmpty) return Center(child:Text("No KOT"));return ListView.builder(padding:EdgeInsets.all(10),itemCount:live.length,itemBuilder:(co,i){var t=live[i];return Card(color:Color(0xFFFFF3E0),child:Padding(padding:EdgeInsets.all(10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t["name"]+" KOT [${t["waiter"]}]",style:TextStyle(fontWeight:FontWeight.bold)),Divider(),for(var it in t["items"]) Text("${it["name"]} [${it["portion"]}] x${it["qty"]} Rs ${it["price"]*it["qty"]+(it["extra"]==true?20:0)}",style:TextStyle(fontSize:12)),if(t["hold"]==true) Text("HOLD",style:TextStyle(color:Colors.orange,fontWeight:FontWeight.bold))]))) ;});}),
   Builder(builder:(co){var occ=tables.where((t)=>t["status"]=="Occupied").toList();if(occ.isEmpty) return Center(child:Text("No Bills"));return ListView.builder(padding:EdgeInsets.all(10),itemCount:occ.length,itemBuilder:(co,i){var t=occ[i];int ri=tables.indexWhere((x)=>x["id"]==t["id"]);double sub=t["items"].fold(0.0,(s,it)=>s+it["price"]*it["qty"]+(it["extra"]==true?20:0));double d=t["disc"]??0;return Card(child:ExpansionTile(title:Text(t["name"]+" Rs ${(sub-d).toInt()}",style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text("${t["pax"]}PAX ${t["waiter"]}"),children:[for(var it in t["items"]) ListTile(title:Text(it["name"]+" [${it["portion"]}]"),trailing:Text("Rs ${it["price"]*it["qty"]+(it["extra"]==true?20:0)}")),Divider(),ListTile(title:Text("TOTAL (No GST)",style:TextStyle(fontWeight:FontWeight.bold)),trailing:Text("Rs ${(sub-d).toInt()}",style:TextStyle(fontWeight:FontWeight.bold))),Padding(padding:EdgeInsets.all(8),child:Row(children:[Expanded(child:ElevatedButton(onPressed:(){showDialog(context:co,builder:(_)=>AlertDialog(title:Text("BILL "+t["name"]),content:Text("KGN TAWA FRY\n"+t["name"]+"\nTotal Rs ${(sub-d).toInt()}\nUPI:kgn@upi"),actions:[TextButton(onPressed:()=>Navigator.pop(co),child:Text("OK"))]));},child:Text("Print Bill"),style:ElevatedButton.styleFrom(backgroundColor:Colors.blue,foregroundColor:Colors.white))),SizedBox(width:8),Expanded(child:ElevatedButton(onPressed:()=>clear(ri),child:Text("Paid Clear"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white))) ])) ]));});}),
   ListView(padding:EdgeInsets.all(14),children:[Card(color:Colors.deepOrange,child:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text("Today Collection No GST",style:TextStyle(color:Colors.white)),Text("Rs ${day.toInt()}",style:TextStyle(color:Colors.white,fontSize:30,fontWeight:FontWeight.bold))]))),SizedBox(height:10),ElevatedButton(onPressed:(){setState((){day=0;hist.clear();});},child:Text("Reset Day"),style:ElevatedButton.styleFrom(backgroundColor:Colors.red,foregroundColor:Colors.white)),SizedBox(height:10),Text("History ${hist.length}",style:TextStyle(fontWeight:FontWeight.bold)),for(var h in hist.reversed.take(30)) Card(child:ListTile(title:Text(h["name"]+" Rs ${(h["amt"]-h["disc"]).toInt()} | ${h["waiter"]}",style:TextStyle(fontSize:13)),subtitle:Text("${h["pax"]}PAX ${h["time"]}")))]),
   AdminPage(menu:menu,onSave:(m){setState(()=>menu=m);}),
  ];
  return Scaffold(appBar:AppBar(title:Text(idx==0?"KGN ${widget.waiter}":idx==1?"New":idx==2?"KOT":idx==3?"Bills":idx==4?"Report":"Admin"),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white,actions:[IconButton(icon:Icon(Icons.logout),onPressed:(){Navigator.pushReplacement(c,MaterialPageRoute(builder:(_)=>Login()));})]),body:p[idx],bottomNavigationBar:BottomNavigationBar(currentIndex:idx,onTap:(i)=>setState(()=>idx=i),selectedItemColor:Colors.deepOrange,unselectedItemColor:Colors.grey,type:BottomNavigationBarType.fixed,items:[BottomNavigationBarItem(icon:Icon(Icons.table_restaurant),label:"Tables"),BottomNavigationBarItem(icon:Icon(Icons.add_circle),label:"New"),BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu),label:"KOT"),BottomNavigationBarItem(icon:Icon(Icons.receipt_long),label:"Bills"),BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label:"Report"),BottomNavigationBarItem(icon:Icon(Icons.settings),label:"Admin")]));
 }
}
class AdminPage extends StatefulWidget{final List<Map> menu;final Function(List<Map>) onSave;AdminPage({required this.menu,required this.onSave});@override State<AdminPage> createState()=>_AP();}
class _AP extends State<AdminPage>{
 late List<Map> lm;
 @override void initState(){super.initState();lm=List<Map>.from(widget.menu.map((e)=>Map.from(e)));}
 @override Widget build(BuildContext c){return Column(children:[Container(padding:EdgeInsets.all(8),color:Colors.blue.shade50,child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text("Admin Rate Edit",style:TextStyle(fontWeight:FontWeight.bold)),ElevatedButton(onPressed:(){widget.onSave(lm);ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text("Saved!")));},child:Text("Save"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white))])),Expanded(child:ListView.builder(padding:EdgeInsets.all(8),itemCount:lm.length,itemBuilder:(co,i){var m=lm[i];return Card(child:ListTile(title:Text(m["n"],style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)),subtitle:Text("${m["c"]} H:${m["h"]} F:${m["f"]}"),trailing:IconButton(icon:Icon(Icons.edit,size:16),onPressed:(){var h=TextEditingController(text:m["h"].toString());var f=TextEditingController(text:m["f"].toString());showDialog(context:co,builder:(_)=>AlertDialog(title:Text(m["n"]),content:Column(mainAxisSize:MainAxisSize.min,children:[TextField(controller:h,decoration:InputDecoration(labelText:"Half")),TextField(controller:f,decoration:InputDecoration(labelText:"Full"))]),actions:[TextButton(onPressed:()=>Navigator.pop(co),child:Text("Cancel")),ElevatedButton(onPressed:(){setState((){m["h"]=int.tryParse(h.text)??m["h"];m["f"]=int.tryParse(f.text)??m["f"];});Navigator.pop(co);},child:Text("Update"))]));}));}))]);}
}
class OrderPage extends StatefulWidget{final Map table;final List<Map> menu;final Function(Map) onSave;OrderPage({required this.table,required this.menu,required this.onSave});@override State<OrderPage> createState()=>_OP();}
class _OP extends State<OrderPage>{
 late Map tbl;int pax=1;bool hold=false;List<Map> cart=[];double disc=0;TextEditingController dc=TextEditingController();String cat="All";
 @override void initState(){super.initState();tbl=Map.from(widget.table);if(tbl["items"]!=null && (tbl["items"] as List).isNotEmpty){cart=List<Map>.from(tbl["items"].map((e)=>Map.from(e)));pax=tbl["pax"]??1;hold=tbl["hold"]??false;disc=(tbl["disc"]??0).toDouble();dc.text=disc>0?disc.toString():"";}}
 double get sub{double s=0;for(var it in cart){s+=it["price"]*it["qty"]+(it["extra"]==true?20:0);}return s;}
 double get tot=>sub-disc;
 void add(Map m,String portion){int price=portion=="Half"?m["h"]:m["f"];setState((){int i=cart.indexWhere((e)=>e["n"]==m["n"] && e["portion"]==portion);if(i>=0) cart[i]["qty"]++;else cart.add({"name":m["n"],"n":m["n"],"price":price,"h":m["h"],"f":m["f"],"qty":1,"extra":false,"portion":portion});});}
 void showP(Map m){showDialog(context:context,builder:(c)=>AlertDialog(title:Text(m["n"]),content:Text("Half Rs ${m["h"]}\nFull Rs ${m["f"]}"),actions:[TextButton(onPressed:(){Navigator.pop(c);add(m,"Half");},child:Text("HALF ${m["h"]}")),ElevatedButton(onPressed:(){Navigator.pop(c);add(m,"Full");},child:Text("FULL ${m["f"]}"),style:ElevatedButton.styleFrom(backgroundColor:Colors.deepOrange,foregroundColor:Colors.white))]));}
 @override Widget build(BuildContext context){
  var filt=cat=="All"?widget.menu:widget.menu.where((e)=>e["c"]==cat).toList();
  return Scaffold(appBar:AppBar(title:Text(tbl["name"]+" Rs ${tot.toInt()}",style:TextStyle(fontSize:16)),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),body:Column(children:[
   Container(padding:EdgeInsets.all(8),color:Colors.orange.shade50,child:Column(children:[Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Row(children:[Text("PAX",style:TextStyle(fontSize:11)),IconButton(icon:Icon(Icons.remove,size:16),onPressed:()=>setState(()=>pax=pax>1?pax-1:1)),Text(pax.toString(),style:TextStyle(fontWeight:FontWeight.bold)),IconButton(icon:Icon(Icons.add,size:16),onPressed:()=>setState(()=>pax++))]),Row(children:[Text("HOLD",style:TextStyle(fontSize:11)),Switch(value:hold,onChanged:(v)=>setState(()=>hold=v),activeColor:Colors.orange)]),Text("Rs ${tot.toInt()}",style:TextStyle(fontWeight:FontWeight.bold))]),Row(children:[Expanded(child:TextField(controller:dc,decoration:InputDecoration(labelText:"Discount",isDense:true,border:OutlineInputBorder(),contentPadding:EdgeInsets.all(8)),keyboardType:TextInputType.number,onChanged:(v){setState(()=>disc=double.tryParse(v)??0);} )),SizedBox(width:6),Text("No GST",style:TextStyle(fontSize:10,color:Colors.green,fontWeight:FontWeight.bold))])])),
   Container(height:36,child:ListView(scrollDirection:Axis.horizontal,padding:EdgeInsets.symmetric(horizontal:6),children:["All","Chicken","Mutton","Fish","Veg","Rice","Roti","Biryani","Egg"].map((ch)=>Padding(padding:EdgeInsets.symmetric(horizontal:2),child:ChoiceChip(label:Text(ch,style:TextStyle(fontSize:10)),selected:cat==ch,onSelected:(v)=>setState(()=>cat=ch)))).toList())),
   Expanded(flex:3,child:GridView.builder(padding:EdgeInsets.all(6),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:2.2,crossAxisSpacing:5,mainAxisSpacing:5),itemCount:filt.length,itemBuilder:(c,i){var m=filt[i];return InkWell(onTap:()=>showP(m),child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(8),border:Border.all(color:Colors.grey.shade300)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(m["n"],textAlign:TextAlign.center,style:TextStyle(fontSize:8,fontWeight:FontWeight.bold)),Text("H${m["h"]} F${m["f"]}",style:TextStyle(fontSize:8,color:Colors.deepOrange))])));})),
   Divider(height:1),
   Expanded(flex:2,child:cart.isEmpty?Center(child:Text("Tap menu to add")):ListView.builder(itemCount:cart.length,itemBuilder:(c,i){var it=cart[i];int ex=it["extra"]==true?20:0;int pr=it["price"]*it["qty"]+ex;return ListTile(dense:true,title:Text("${it["n"]} [${it["portion"]}]",style:TextStyle(fontSize:11,fontWeight:FontWeight.bold)),subtitle:Row(children:[Checkbox(value:it["extra"],onChanged:(v){setState(()=>it["extra"]=v??false);},visualDensity:VisualDensity.compact,materialTapTargetSize:MaterialTapTargetSize.shrinkWrap),Text("Butter+20",style:TextStyle(fontSize:8))]),trailing:Row(mainAxisSize:MainAxisSize.min,children:[IconButton(icon:Icon(Icons.remove,size:14),onPressed:(){setState((){if(it["qty"]>1)it["qty"]--; else cart.removeAt(i);});},padding:EdgeInsets.zero,constraints:BoxConstraints()),Text(it["qty"].toString(),style:TextStyle(fontSize:11)),IconButton(icon:Icon(Icons.add,size:14),onPressed:(){setState(()=>it["qty"]++;});},padding:EdgeInsets.zero,constraints:BoxConstraints()),SizedBox(width:4),Text("Rs$pr",style:TextStyle(fontSize:10,fontWeight:FontWeight.bold)),IconButton(icon:Icon(Icons.delete,size:14,color:Colors.red),onPressed:()=>setState(()=>cart.removeAt(i)),padding:EdgeInsets.zero,constraints:BoxConstraints())]));})),
   Container(padding:EdgeInsets.all(8),color:Colors.white,child:Row(children:[Expanded(child:ElevatedButton(onPressed:cart.isEmpty?null:(){var o={"id":tbl["id"],"name":tbl["name"],"status":cart.isEmpty?"Empty":"Occupied","amt":sub,"pax":pax,"items":cart,"time":"${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2,'0')}","hold":hold,"disc":disc};widget.onSave(o);Navigator.pop(context);},child:Text(hold?"HOLD Rs ${tot.toInt()}":"SAVE KOT Rs ${tot.toInt()}",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)),style:ElevatedButton.styleFrom(backgroundColor:hold?Colors.orange:Colors.green,foregroundColor:Colors.white,minimumSize:Size(double.infinity,42))))]))
  ]));
 }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
