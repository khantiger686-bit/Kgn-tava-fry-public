import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
void main(){runApp(MaterialApp(debugShowCheckedModeBanner:false,home:MainApp()));}
class MainApp extends StatefulWidget{ @override State<MainApp> createState()=>_MainAppState();}
class _MainAppState extends State<MainApp>{
 int idx=0;
 List<Map<String,dynamic>> tables=List.generate(6,(i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0.0,"pax":0,"items":[],"time":"","isHold":false});
 List<Map<String,dynamic>> history=[]; double dayCollection=0; FlutterTts tts=FlutterTts();
 void speak(String t) async {await tts.setLanguage("en-IN"); await tts.speak(t);}
 void clearTable(int i){setState(()=>tables[i]={"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0.0,"pax":0,"items":[],"time":"","isHold":false});}
 @override Widget build(BuildContext c){
  List<Widget> pages=[
    TableGrid(tables:tables,onTapTable:(i){Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderScreen(table:tables[i],onSave:(o){setState((){tables[i]=o; history.add({...o,"savedAt":DateTime.now().toString()}); dayCollection+=(o['amount'] as num).toDouble();}); speak("New order "+o['name'].toString());})));}),
    NewOrderQuick(tables:tables,onSelect:(i){setState(()=>idx=0); Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderScreen(table:tables[i],onSave:(o){setState((){tables[i]=o; history.add({...o,"savedAt":DateTime.now().toString()}); dayCollection+=(o['amount'] as num).toDouble();});})));}),
    KOTScreen(tables:tables), OrdersScreen(tables:tables,onClear:(i)=>clearTable(i)), SummaryScreen(tables:tables,history:history,dayCollection:dayCollection,onResetDay:(){setState((){dayCollection=0; history.clear();});}),
  ];
  return Scaffold(backgroundColor:Color(0xFFFFF9F5),appBar:AppBar(title:Text(idx==0?"KGN TAWA FRY - TABLES":idx==1?"New Order":idx==2?"Live KOT":idx==3?"All Orders":"Day Summary"),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),body:pages[idx],bottomNavigationBar:BottomNavigationBar(currentIndex:idx,onTap:(i)=>setState(()=>idx=i),selectedItemColor:Colors.deepOrange,unselectedItemColor:Colors.grey,type:BottomNavigationBarType.fixed,items:[BottomNavigationBarItem(icon:Icon(Icons.table_restaurant),label:"Tables"),BottomNavigationBarItem(icon:Icon(Icons.add_circle),label:"New"),BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu),label:"KOT"),BottomNavigationBarItem(icon:Icon(Icons.receipt_long),label:"Orders"),BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label:"Summary")]));
 }
}class TableGrid extends StatelessWidget{final List<Map<String,dynamic>> tables; final Function(int) onTapTable; TableGrid({required this.tables,required this.onTapTable}); @override Widget build(BuildContext c){return GridView.builder(padding:EdgeInsets.all(12),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.3,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:tables.length,itemBuilder:(co,i){var t=tables[i]; Color col=t["status"]=="Empty"?Colors.green.shade100:Colors.red.shade100; return InkWell(onTap:()=>onTapTable(i),child:Container(decoration:BoxDecoration(color:col,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.orange.shade200)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(t["name"],style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),Text(t["status"],style:TextStyle(fontWeight:FontWeight.bold,color:t["status"]=="Empty"?Colors.green:Colors.red)),if((t["amount"] as num)>0) Text("Rs "+t["amount"].toString(),style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),Text("PAX "+t["pax"].toString()+" | "+t["items"].length.toString()+" Items",style:TextStyle(fontSize:11)),if(t["time"]!="") Text(t["time"],style:TextStyle(fontSize:9)),if(t["isHold"]==true) Text("HOLD",style:TextStyle(fontSize:10,color:Colors.orange,fontWeight:FontWeight.bold))])));});}}
class NewOrderQuick extends StatelessWidget{final List<Map<String,dynamic>> tables; final Function(int) onSelect; NewOrderQuick({required this.tables,required this.onSelect}); @override Widget build(BuildContext c){return ListView.builder(padding:EdgeInsets.all(12),itemCount:6,itemBuilder:(co,i){var t=tables[i]; return Card(child:ListTile(leading:CircleAvatar(backgroundColor:t["status"]=="Empty"?Colors.green:Colors.red,child:Text(t["name"],style:TextStyle(color:Colors.white,fontSize:12))),title:Text(t["name"].toString()+" - "+t["status"].toString()),subtitle:Text(t["status"]=="Occupied"?"Rs "+t["amount"].toString():"Empty Table"),trailing:Icon(Icons.arrow_forward),onTap:()=>onSelect(i)));});}}
class KOTScreen extends StatelessWidget{final List<Map<String,dynamic>> tables; KOTScreen({required this.tables}); @override Widget build(BuildContext c){var live=tables.where((t)=>t["status"]=="Occupied").toList(); if(live.isEmpty) return Center(child:Text("No Live Orders")); return ListView.builder(padding:EdgeInsets.all(12),itemCount:live.length,itemBuilder:(co,i){var t=live[i]; return Card(color:Color(0xFFFFF3E0),child:Padding(padding:EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(t["name"].toString()+" - KOT",style:TextStyle(fontWeight:FontWeight.bold)),Text(t["time"].toString())]),Divider(),...List.generate(t["items"].length,(j){var it=t["items"][j]; int ex=it["extraButter"]==true?20:0; int pr=(it["price"] as num).toInt()*(it["qty"] as int)+ex; String portion=it["portion"]??"Full"; return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Expanded(child:Text((j+1).toString()+". "+it["name"].toString()+" ["+portion+"] "+(it["extraButter"]==true?"[Extra Butter]":""),style:TextStyle(fontSize:12))),Text("x"+it["qty"].toString()+" Rs "+pr.toString(),style:TextStyle(fontSize:12))]);}),if(t["isHold"]==true) Container(margin:EdgeInsets.only(top:8),padding:EdgeInsets.all(6),color:Colors.yellow.shade200,child:Text("HOLD - Kitchen Wait",style:TextStyle(fontWeight:FontWeight.bold,fontSize:12)))])));});}}
class OrdersScreen extends StatelessWidget{final List<Map<String,dynamic>> tables; final Function(int) onClear; OrdersScreen({required this.tables,required this.onClear}); @override Widget build(BuildContext c){var occ=tables.where((t)=>t["status"]=="Occupied").toList(); if(occ.isEmpty) return Center(child:Text("No Orders")); return ListView.builder(padding:EdgeInsets.all(12),itemCount:occ.length,itemBuilder:(co,i){var t=occ[i]; int ri=tables.indexWhere((x)=>x["id"]==t["id"]); return Card(child:ExpansionTile(title:Text(t["name"].toString()+" - Rs "+t["amount"].toString()),subtitle:Text(t["pax"].toString()+" Pax | "+t["time"].toString()),children:[...List.generate(t["items"].length,(j){var it=t["items"][j]; int ex=it["extraButter"]==true?20:0; int pr=(it["price"] as num).toInt()*(it["qty"] as int)+ex; String portion=it["portion"]??"Full"; return ListTile(title:Text(it["name"].toString()+" ["+portion+"]",style:TextStyle(fontSize:13)),subtitle:Text("Qty:"+it["qty"].toString()+" "+(it["extraButter"]==true?"+Butter Rs20":""),style:TextStyle(fontSize:11)),trailing:Text("Rs "+pr.toString(),style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)));}),Padding(padding:EdgeInsets.all(8),child:ElevatedButton(onPressed:()=>onClear(ri),child:Text("Bill Paid - Clear"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white))),SizedBox(height:10)]));});}}
class SummaryScreen extends StatelessWidget{final List<Map<String,dynamic>> tables; final List<Map<String,dynamic>> history; final double dayCollection; final VoidCallback onResetDay; SummaryScreen({required this.tables,required this.history,required this.dayCollection,required this.onResetDay}); @override Widget build(BuildContext c){int occ=tables.where((t)=>t["status"]=="Occupied").length; double live=tables.fold(0,(s,t)=>s+(t["amount"] as num).toDouble()); return ListView(padding:EdgeInsets.all(16),children:[Card(color:Colors.deepOrange,child:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text("Today Collection",style:TextStyle(color:Colors.white)),Text("Rs "+dayCollection.toStringAsFixed(0),style:TextStyle(color:Colors.white,fontSize:32,fontWeight:FontWeight.bold)),Text("Live Rs "+live.toStringAsFixed(0)+" | "+occ.toString()+"/6 Occupied",style:TextStyle(color:Colors.white70,fontSize:12))]))),SizedBox(height:12),ElevatedButton(onPressed:onResetDay,child:Text("Reset Day"),style:ElevatedButton.styleFrom(backgroundColor:Colors.red,foregroundColor:Colors.white)),SizedBox(height:20),Text("History ("+history.length.toString()+")",style:TextStyle(fontWeight:FontWeight.bold)),...history.reversed.take(50).map((h)=>Card(child:ListTile(title:Text(h["name"].toString()+" - Rs "+h["amount"].toString(),style:TextStyle(fontSize:14,fontWeight:FontWeight.bold)),subtitle:Text(h["pax"].toString()+" Pax | "+h["time"].toString()+" | "+(h["items"]?.length??0).toString()+" items",style:TextStyle(fontSize:11))))).toList()]);}}
class OrderScreen extends StatefulWidget{final Map<String,dynamic> table; final Function(Map<String,dynamic>) onSave; OrderScreen({required this.table,required this.onSave}); @override State<OrderScreen> createState()=>_OrderScreenState();}
class _OrderScreenState extends State<OrderScreen>{
 late Map<String,dynamic> tbl; int pax=1; bool isHold=false; List<Map<String,dynamic>> cart=[];
 final List<Map<String,dynamic>> menu=[
  {"name":"Murgh Do Pyaza (Chicken)","half":160,"full":300,"cat":"Chicken"},
  {"name":"Murgh Mughlai","half":170,"full":320,"cat":"Chicken"},
  {"name":"Chicken Handi","half":160,"full":300,"cat":"Chicken"},
  {"name":"Chicken Pesawar","half":170,"full":320,"cat":"Chicken"},
  {"name":"Murgh Shahi Chicken","half":170,"full":320,"cat":"Chicken"},
  {"name":"Chicken Malai Tikka","half":180,"full":350,"cat":"Chicken"},
  {"name":"Chicken Tikka Masala","half":170,"full":320,"cat":"Chicken"},
  {"name":"Chicken Karahi","half":160,"full":300,"cat":"Chicken"},
  {"name":"Chicken Garlic","half":160,"full":300,"cat":"Chicken"},
  {"name":"Chicken India","half":250,"full":450,"cat":"Chicken"},
  {"name":"Butter Chicken Boneless","half":170,"full":320,"cat":"Chicken"},
  {"name":"White Chicken","half":180,"full":350,"cat":"Chicken"},
  {"name":"Green Chicken","half":180,"full":350,"cat":"Chicken"},
  {"name":"Chicken Fry","half":120,"full":220,"cat":"Chicken"},
  {"name":"Chicken Masala","half":120,"full":220,"cat":"Chicken"},
  {"name":"Chicken Biryani","half":80,"full":120,"cat":"Biryani"},
  {"name":"Chicken Tandoori Masala","half":250,"full":480,"cat":"Chicken"},
  {"name":"Chicken Ahmedabadi Masala","half":160,"full":320,"cat":"Chicken"},
  {"name":"Chicken Tikka Rice","half":170,"full":320,"cat":"Rice"},
  {"name":"Mughlai Mutton","half":150,"full":280,"cat":"Mutton"},
  {"name":"DalBati Gos","half":150,"full":280,"cat":"Mutton"},
  {"name":"White Mutton","half":160,"full":300,"cat":"Mutton"},
  {"name":"Green Mutton","half":150,"full":280,"cat":"Mutton"},
  {"name":"Mutton Kurma","half":160,"full":300,"cat":"Mutton"},
  {"name":"Mutton Fry","half":120,"full":220,"cat":"Mutton"},
  {"name":"Mutton Masala","half":120,"full":220,"cat":"Mutton"},
  {"name":"Kaleji Masala","half":120,"full":220,"cat":"Mutton"},
  {"name":"Bhaji Gos","half":130,"full":240,"cat":"Mutton"},
  {"name":"Paya Fry","half":120,"full":220,"cat":"Mutton"},
  {"name":"Champ Fry","half":120,"full":220,"cat":"Mutton"},
  {"name":"Bheja Fry","half":130,"full":240,"cat":"Mutton"},
  {"name":"Boti Masala","half":120,"full":220,"cat":"Mutton"},
  {"name":"Kheema Fry","half":80,"full":160,"cat":"Mutton"},
  {"name":"Kheema Pulav","half":100,"full":180,"cat":"Rice"},
  {"name":"Machhi Fry (Fish Fry)","half":80,"full":160,"cat":"Fish"},
  {"name":"Machhi Kadhi","half":100,"full":200,"cat":"Fish"},
  {"name":"Jhinga Fry (Prawns)","half":130,"full":240,"cat":"Fish"},
  {"name":"Jhinga Rice","half":170,"full":320,"cat":"Rice"},
  {"name":"Anda Kadhi","half":80,"full":160,"cat":"Egg"},
  {"name":"Anda Kheema","half":80,"full":160,"cat":"Egg"},
  {"name":"Anda Bhurji","half":50,"full":100,"cat":"Egg"},
  {"name":"Anda Pulav","half":60,"full":120,"cat":"Rice"},
  {"name":"Dal Tadka","half":70,"full":140,"cat":"Veg"},
  {"name":"Dal Gotala","half":80,"full":160,"cat":"Veg"},
  {"name":"Butter Dal Fry","half":70,"full":140,"cat":"Veg"},
  {"name":"Dal Fry","half":50,"full":100,"cat":"Veg"},
  {"name":"Sabji Fry","half":50,"full":100,"cat":"Veg"},
  {"name":"Sev Tameta","half":50,"full":100,"cat":"Veg"},
  {"name":"Masala Rice","half":50,"full":100,"cat":"Rice"},
  {"name":"Biryani Rice","half":50,"full":100,"cat":"Rice"},
  {"name":"Jeera Rice","half":50,"full":100,"cat":"Rice"},
  {"name":"Kadhi Khichdi","half":30,"full":60,"cat":"Rice"},
  {"name":"Dal Pulav","half":50,"full":100,"cat":"Rice"},
  {"name":"Plain Rice","half":50,"full":100,"cat":"Rice"},
  {"name":"Special Roti","half":15,"full":15,"cat":"Roti"},
  {"name":"Special Paratha","half":20,"full":20,"cat":"Roti"},
  {"name":"Butter Roti","half":15,"full":15,"cat":"Roti"},
  {"name":"Chapati Roti","half":7,"full":7,"cat":"Roti"},
  {"name":"Papad Fry","half":10,"full":10,"cat":"Roti"},
 ];
 String selectedCat="All";
 @override void initState(){super.initState(); tbl=Map.from(widget.table); if(tbl["items"]!=null && (tbl["items"] as List).isNotEmpty){cart=List<Map<String,dynamic>>.from(tbl["items"].map((e)=>Map<String,dynamic>.from(e))); pax=tbl["pax"]??1; isHold=tbl["isHold"]??false;}}
 double get total{double s=0; for(var it in cart){s+=(it["price"]*it["qty"])+(it["extraButter"]==true?20:0);} return s;}
 void addToCart(Map<String,dynamic> m, String portion){int finalPrice=portion=="Half"?m["half"] as int:m["full"] as int; setState((){int idx=cart.indexWhere((e)=>e["name"]==m["name"] && (e["portion"]??"Full")==portion && e["extraButter"]==false); if(idx>=0){cart[idx]["qty"]+=1;} else {cart.add({"name":m["name"],"price":finalPrice,"half":m["half"],"full":m["full"],"qty":1,"extraButter":false,"portion":portion});}});}
 void showPortionDialog(Map<String,dynamic> m){showDialog(context:context,builder:(c){return AlertDialog(title:Text(m["name"],style:TextStyle(fontWeight:FontWeight.bold)),content:Column(mainAxisSize:MainAxisSize.min,children:[Text("Portion select karo:"),SizedBox(height:10),Text("Half = Rs "+m["half"].toString(),style:TextStyle(fontSize:14)),Text("Full = Rs "+m["full"].toString(),style:TextStyle(fontSize:14,fontWeight:FontWeight.bold)),]),actions:[TextButton(onPressed:(){Navigator.pop(c); addToCart(m,"Half");},child:Text("HALF - Rs "+m["half"].toString())),ElevatedButton(onPressed:(){Navigator.pop(c); addToCart(m,"Full");},child:Text("FULL - Rs "+m["full"].toString()),style:ElevatedButton.styleFrom(backgroundColor:Colors.deepOrange,foregroundColor:Colors.white))]);});}
 @override Widget build(BuildContext context){
  List<String> cats=["All","Chicken","Mutton","Fish","Veg","Rice","Roti","Biryani","Egg"]; var filtered=selectedCat=="All"?menu:menu.where((e)=>e["cat"]==selectedCat).toList();
  return Scaffold(appBar:AppBar(title:Text(tbl["name"].toString()+" - Rs "+total.toStringAsFixed(0)),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),body:Column(children:[Container(padding:EdgeInsets.all(8),color:Colors.orange.shade50,child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Row(children:[Text("PAX:",style:TextStyle(fontSize:12)),IconButton(icon:Icon(Icons.remove,size:18),onPressed:()=>setState(()=>pax=pax>1?pax-1:1)),Text(pax.toString(),style:TextStyle(fontWeight:FontWeight.bold)),IconButton(icon:Icon(Icons.add,size:18),onPressed:()=>setState(()=>pax++))]),Row(children:[Text("HOLD",style:TextStyle(fontSize:12)),Switch(value:isHold,onChanged:(v)=>setState(()=>isHold=v),activeColor:Colors.orange)]),Text("Rs "+total.toStringAsFixed(0),style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))])),Container(height:40,child:ListView(scrollDirection:Axis.horizontal,padding:EdgeInsets.symmetric(horizontal:8),children:cats.map((ch)=>Padding(padding:EdgeInsets.symmetric(horizontal:3),child:ChoiceChip(label:Text(ch,style:TextStyle(fontSize:11)),selected:selectedCat==ch,onSelected:(v)=>setState(()=>selectedCat=ch)))).toList())),Expanded(flex:3,child:GridView.builder(padding:EdgeInsets.all(8),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:2.2,crossAxisSpacing:6,mainAxisSpacing:6),itemCount:filtered.length,itemBuilder:(c,i){var m=filtered[i]; return InkWell(onTap:()=>showPortionDialog(m),child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(8),border:Border.all(color:Colors.grey.shade300)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(m["name"],textAlign:TextAlign.center,style:TextStyle(fontSize:9,fontWeight:FontWeight.bold)),SizedBox(height:2),Text("H "+m["half"].toString()+" | F "+m["full"].toString(),style:TextStyle(fontSize:8,color:Colors.deepOrange))])));})),Divider(height:1),Expanded(flex:2,child:cart.isEmpty?Center(child:Text("No Items - Menu pe tap karo",textAlign:TextAlign.center,style:TextStyle(color:Colors.grey))):ListView.builder(itemCount:cart.length,itemBuilder:(c,i){var it=cart[i]; int ex=it["extraButter"]==true?20:0; int pr=(it["price"] as int)*(it["qty"] as int)+ex; String portion=it["portion"]??"Full"; return ListTile(dense:true,title:Text(it["name"].toString()+" ["+portion+"]",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)),subtitle:Row(children:[Checkbox(value:it["extraButter"],onChanged:(v){setState(()=>it["extraButter"]=v??false);},materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,visualDensity:VisualDensity.compact),Text("Butter +20",style:TextStyle(fontSize:9))]),trailing:Row(mainAxisSize:MainAxisSize.min,children:[IconButton(icon:Icon(Icons.remove,size:16),padding:EdgeInsets.zero,constraints:BoxConstraints(),onPressed:(){setState((){if(it["qty"]>1)it["qty"]--; else cart.removeAt(i);});}),Padding(padding:EdgeInsets.symmetric(horizontal:6),child:Text(it["qty"].toString(),style:TextStyle(fontSize:12))),IconButton(icon:Icon(Icons.add,size:16),padding:EdgeInsets.zero,constraints:BoxConstraints(),onPressed:(){setState(()=>it["qty"]++;});}),SizedBox(width:8),Text("Rs "+pr.toString(),style:TextStyle(fontSize:11,fontWeight:FontWeight.bold)),IconButton(icon:Icon(Icons.delete,size:16,color:Colors.red),padding:EdgeInsets.zero,constraints:BoxConstraints(),onPressed:()=>setState(()=>cart.removeAt(i)))]));})),Container(padding:EdgeInsets.all(10),color:Colors.white,child:Row(children:[Expanded(child:ElevatedButton(onPressed:cart.isEmpty?null:(){var order={"id":tbl["id"],"name":tbl["name"],"status":cart.isEmpty?"Empty":"Occupied","amount":total,"pax":pax,"items":cart,"time":DateTime.now().hour.toString()+":"+DateTime.now().minute.toString().padLeft(2,'0'), "isHold":isHold}; widget.onSave(order); Navigator.pop(context);},child:Text(isHold?"HOLD TABLE - Rs "+total.toStringAsFixed(0):"SAVE KOT - Rs "+total.toStringAsFixed(0),style:TextStyle(fontSize:13,fontWeight:FontWeight.bold)),style:ElevatedButton.styleFrom(backgroundColor:isHold?Colors.orange:Colors.green,foregroundColor:Colors.white,minimumSize:Size(double.infinity,48))))])),]));}
}
