import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main(){runApp(MaterialApp(debugShowCheckedModeBanner:false,home:MainApp()));}

class MainApp extends StatefulWidget{ @override State<MainApp> createState()=>_MainAppState();}

class _MainAppState extends State<MainApp>{
 int idx=0;
 List<Map<String,dynamic>> tables=List.generate(6,(i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0.0,"pax":0,"items":[],"time":"","isHold":false});
 List<Map<String,dynamic>> history=[];
 double dayCollection=0;
 FlutterTts tts=FlutterTts();

 void speak(String t) async {await tts.setLanguage("en-IN"); await tts.speak(t);}
 void clearTable(int i){setState(()=>tables[i]={"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0.0,"pax":0,"items":[],"time":"","isHold":false});}

 @override Widget build(BuildContext c){
  List<Widget> pages=[
    TableGrid(tables:tables,onTapTable:(i){Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderScreen(table:tables[i],onSave:(o){setState((){tables[i]=o; history.add({...o,"savedAt":DateTime.now().toString()}); dayCollection+=(o['amount'] as num).toDouble();}); speak("New order ${o['name']}");})));}),
    NewOrderQuick(tables:tables,onSelect:(i){setState(()=>idx=0); Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderScreen(table:tables[i],onSave:(o){setState((){tables[i]=o; history.add({...o,"savedAt":DateTime.now().toString()}); dayCollection+=(o['amount'] as num).toDouble();});})));}),
    KOTScreen(tables:tables),
    OrdersScreen(tables:tables,onClear:(i)=>clearTable(i)),
    SummaryScreen(tables:tables,history:history,dayCollection:dayCollection,onResetDay:(){setState((){dayCollection=0; history.clear();});}),
  ];
  return Scaffold(
    backgroundColor:Color(0xFFFFF9F5),
    appBar:AppBar(title:Text(idx==0?"KGN TAVA FRY - TABLES":idx==1?"New Order":idx==2?"Live KOT":idx==3?"All Orders":"Day Summary"),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),
    body:pages[idx],
    bottomNavigationBar:BottomNavigationBar(currentIndex:idx,onTap:(i)=>setState(()=>idx=i),selectedItemColor:Colors.deepOrange,unselectedItemColor:Colors.grey,type:BottomNavigationBarType.fixed,
      items:[BottomNavigationBarItem(icon:Icon(Icons.table_restaurant),label:"Tables"),BottomNavigationBarItem(icon:Icon(Icons.add_circle),label:"New"),BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu),label:"KOT"),BottomNavigationBarItem(icon:Icon(Icons.receipt_long),label:"Orders"),BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label:"Summary")]),
  );
 }
}

class TableGrid extends StatelessWidget{
  final List<Map<String,dynamic>> tables; final Function(int) onTapTable;
  TableGrid({required this.tables,required this.onTapTable});
  @override Widget build(BuildContext c){
    return GridView.builder(padding:EdgeInsets.all(12),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.3,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:tables.length,
      itemBuilder:(co,i){
        var t=tables[i]; Color col=t["status"]=="Empty"?Colors.green.shade100:Colors.red.shade100;
        return InkWell(onTap:()=>onTapTable(i),child:Container(decoration:BoxDecoration(color:col,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.orange.shade200)),
          child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
            Text(t["name"],style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
            Text(t["status"],style:TextStyle(fontWeight:FontWeight.bold,color:t["status"]=="Empty"?Colors.green:Colors.red)),
            if((t["amount"] as num)>0) Text("Rs ${t["amount"]}",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
            Text("PAX ${t["pax"]} | ${t["items"].length} Items",style:TextStyle(fontSize:11)),
            if(t["time"]!="") Text(t["time"],style:TextStyle(fontSize:9)),
            if(t["isHold"]==true) Text("HOLD",style:TextStyle(fontSize:10,color:Colors.orange,fontWeight:FontWeight.bold))
          ])));
      });
  }
}

class NewOrderQuick extends StatelessWidget{
  final List<Map<String,dynamic>> tables; final Function(int) onSelect;
  NewOrderQuick({required this.tables,required this.onSelect});
  @override Widget build(BuildContext c){
    return ListView.builder(padding:EdgeInsets.all(12),itemCount:6,itemBuilder:(co,i){
      var t=tables[i];
      return Card(child:ListTile(leading:CircleAvatar(backgroundColor:t["status"]=="Empty"?Colors.green:Colors.red,child:Text(t["name"],style:TextStyle(color:Colors.white,fontSize:12))),title:Text("${t["name"]} - ${t["status"]}"),subtitle:Text(t["status"]=="Occupied"?"Rs ${t["amount"]}":"Empty Table"),trailing:Icon(Icons.arrow_forward),onTap:()=>onSelect(i)));
    });
  }
}

class KOTScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables; KOTScreen({required this.tables});
  @override Widget build(BuildContext c){
    var live=tables.where((t)=>t["status"]=="Occupied").toList();
    if(live.isEmpty) return Center(child:Text("No Live Orders"));
    return ListView.builder(padding:EdgeInsets.all(12),itemCount:live.length,itemBuilder:(co,i){
      var t=live[i];
      return Card(color:Color(0xFFFFF3E0),child:Padding(padding:EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text("${t["name"]} - KOT",style:TextStyle(fontWeight:FontWeight.bold)),Text(t["time"])]),Divider(),
       ...List.generate(t["items"].length,(j){
          var it=t["items"][j]; int ex=it["extraButter"]==true?20:0; int pr=(it["price"] as num).toInt()*(it["qty"] as int)+ex; String portion=it["portion"]??"Full";
          return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Expanded(child:Text("${j+1}. ${it["name"]} [$portion] ${it["extraButter"]==true?"[Extra Butter]":""}",style:TextStyle(fontSize:12))),Text("x${it["qty"]} Rs $pr",style:TextStyle(fontSize:12))]);
        }),
        if(t["isHold"]==true) Container(margin:EdgeInsets.only(top:8),padding:EdgeInsets.all(6),color:Colors.yellow.shade200,child:Text("HOLD - Kitchen Wait",style:TextStyle(fontWeight:FontWeight.bold,fontSize:12)))
      ])));
    });
  }
}

class OrdersScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables; final Function(int) onClear;
  OrdersScreen({required this.tables,required this.onClear});
  @override Widget build(BuildContext c){
    var occ=tables.where((t)=>t["status"]=="Occupied").toList();
    if(occ.isEmpty) return Center(child:Text("No Orders"));
    return ListView.builder(padding:EdgeInsets.all(12),itemCount:occ.length,itemBuilder:(co,i){
      var t=occ[i]; int ri=tables.indexWhere((x)=>x["id"]==t["id"]);
      return Card(child:ExpansionTile(title:Text("${t["name"]} - Rs ${t["amount"]}"),subtitle:Text("${t["pax"]} Pax | ${t["time"]}"),children:[
       ...List.generate(t["items"].length,(j){
          var it=t["items"][j]; int ex=it["extraButter"]==true?20:0; int pr=(it["price"] as num).toInt()*(it["qty"] as int)+ex; String portion=it["portion"]??"Full";
          return ListTile(title:Text("${it["name"]} [$portion]",style:TextStyle(fontSize:13)),subtitle:Text("Qty:${it["qty"]} ${it["extraButter"]==true?"+Butter Rs20":""}",style:TextStyle(fontSize:11)),trailing:Text("Rs $pr",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)));
        }),
        Padding(padding:EdgeInsets.all(8),child:ElevatedButton(onPressed:()=>onClear(ri),child:Text("Bill Paid - Clear"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white))),SizedBox(height:10)
      ]));
    });
  }
}

class SummaryScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables; final List<Map<String,dynamic>> history; final double dayCollection; final VoidCallback onResetDay;
  SummaryScreen({required this.tables,required this.history,required this.dayCollection,required this.onResetDay});
  @override Widget build(BuildContext c){
    int occ=tables.where((t)=>t["status"]=="Occupied").length; double live=tables.fold(0,(s,t)=>s+(t["amount"] as num).toDouble());
    return ListView(padding:EdgeInsets.all(16),children:[
      Card(color:Colors.deepOrange,child:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text("Today Collection",style:TextStyle(color:Colors.white)),Text("Rs ${dayCollection.toStringAsFixed(0)}",style:TextStyle(color:Colors.white,fontSize:32,fontWeight:FontWeight.bold)),Text("Live Rs ${live.toStringAsFixed(0)} | $occ/6 Occupied",style:TextStyle(color:Colors.white70,fontSize:12))]))),
      SizedBox(height:12),ElevatedButton(onPressed:onResetDay,child:Text("Reset Day (New Day)"),style:ElevatedButton.styleFrom(backgroundColor:Colors.red,foregroundColor:Colors.white)),
      SizedBox(height:20),Text("Order History (${history.length})",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
     ...history.reversed.take(50).map((h)=>Card(child:ListTile(title:Text("${h["name"]} - Rs ${h["amount"]}",style:TextStyle(fontSize:14,fontWeight:FontWeight.bold)),subtitle:Text("${h["pax"]} Pax | ${h["time"]} | ${h["items"]?.length??0} items",style:TextStyle(fontSize:11))))).toList()
    ]);
  }
}

class OrderScreen extends StatefulWidget{
  final Map<String,dynamic> table; final Function(Map<String,dynamic>) onSave;
  OrderScreen({required this.table,required this.onSave});
  @override State<OrderScreen> createState()=>_OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>{
 late Map<String,dynamic> tbl; int pax=1; bool isHold=false; List<Map<String,dynamic>> cart=[];

 final List<Map<String,dynamic>> menu=[
  {"name":"Chicken Tava Fry","price":350,"cat":"Chicken"},
  {"name":"Chicken Handi","price":380,"cat":"Chicken"},
  {"name":"Chicken Tikka","price":320,"cat":"Chicken"},
  {"name":"Chicken Lollipop","price":300,"cat":"Chicken"},
  {"name":"Butter Chicken","price":360,"cat":"Chicken"},
  {"name":"Chicken Masala","price":340,"cat":"Chicken"},
  {"name":"Chicken 65","price":320,"cat":"Chicken"},
  {"name":"Chicken Manchurian","price":300,"cat":"Chicken"},
  {"name":"Mutton Tava Fry","price":480,"cat":"Mutton"},
  {"name":"Mutton Handi","price":500,"cat":"Mutton"},
  {"name":"Mutton Masala","price":470,"cat":"Mutton"},
  {"name":"Mutton Rogan Josh","price":490,"cat":"Mutton"},
  {"name":"Mutton Sukka","price":480,"cat":"Mutton"},
  {"name":"Fish Fry","price":380,"cat":"Fish"},
  {"name":"Prawns Fry","price":420,"cat":"Fish"},
  {"name":"Surmai Fry","price":450,"cat":"Fish"},
  {"name":"Fish Curry","price":350,"cat":"Fish"},
  {"name":"Prawns Masala","price":420,"cat":"Fish"},
  {"name":"Egg Masala","price":200,"cat":"Egg"},
  {"name":"Egg Bhurji","price":180,"cat":"Egg"},
  {"name":"Boiled Egg","price":40,"cat":"Egg"},
  {"name":"Paneer Tikka","price":280,"cat":"Veg"},
  {"name":"Paneer Handi","price":300,"cat":"Veg"},
  {"name":"Veg Handi","price":260,"cat":"Veg"},
  {"name":"Kadai Paneer","price":290,"cat":"Veg"},
  {"name":"Mix Veg","price":250,"cat":"Veg"},
  {"name":"Veg Kolhapuri","price":270,"cat":"Veg"},
  {"name":"Dal Fry","price":180,"cat":"Veg"},
  {"name":"Dal Tadka","price":190,"cat":"Veg"},
  {"name":"Green Salad","price":60,"cat":"Veg"},
  {"name":"Jeera Rice","price":150,"cat":"Rice"},
  {"name":"Veg Pulao","price":180,"cat":"Rice"},
  {"name":"Chicken Pulao","price":250,"cat":"Rice"},
  {"name":"Mutton Pulao","price":320,"cat":"Rice"},
  {"name":"Steam Rice","price":120,"cat":"Rice"},
  {"name":"Fried Rice","price":180,"cat":"Rice"},
  {"name":"Curd Rice","price":140,"cat":"Rice"},
  {"name":"Chicken Fried Rice","price":220,"cat":"Rice"},
  {"name":"Mutton Fried Rice","price":280,"cat":"Rice"},
  {"name":"Tandoor Roti","price":20,"cat":"Roti"},
  {"name":"Butter Roti","price":30,"cat":"Roti"},
  {"name":"Butter Naan","price":40,"cat":"Roti"},
  {"name":"Cheese Naan","price":60,"cat":"Roti"},
  {"name":"Garlic Naan","price":50,"cat":"Roti"},
  {"name":"Rumali Roti","price":25,"cat":"Roti"},
  {"name":"Chapati","price":15,"cat":"Roti"},
  {"name":"Laccha Paratha","price":35,"cat":"Roti"},
  {"name":"Tandoor Paratha","price":40,"cat":"Roti"},
  {"name":"Kulcha","price":35,"cat":"Roti"},
  {"name":"Chicken Biryani","price":300,"cat":"Biryani"},
  {"name":"Mutton Biryani","price":400,"cat":"Biryani"},
  {"name":"Veg Biryani","price":220,"cat":"Biryani"},
  {"name":"Egg Biryani","price":240,"cat":"Biryani"},
  {"name":"Water Bottle","price":20,"cat":"Drinks"},
  {"name":"Cold Drink","price":40,"cat":"Drinks"},
  {"name":"Lassi","price":50,"cat":"Drinks"},
  {"name":"Papad","price":20,"cat":"Extra"},
  {"name":"Raita","price":50,"cat":"Extra"},
  {"name":"Extra Butter","price":20,"cat":"Extra"},
 ];

 String selectedCat="All";
 @override void initState(){
  super.initState();
  tbl=Map.from(widget.table);
  if(tbl["items"]!=null && (tbl["items"] as List).isNotEmpty){
    cart=List<Map<String,dynamic>>.from(tbl["items"].map((e)=>Map<String,dynamic>.from(e)));
    pax=tbl["pax"]??1; isHold=tbl["isHold"]??false;
  }
 }
 double get total{double s=0; for(var it in cart){s+=(it["price"]*it["qty"])+(it["extraButter"]==true?20:0);} return s;}

 void addToCart(Map<String,dynamic> m, String portion){
  int base=m["price"] as int;
  int finalPrice=portion=="Half"?(base*0.6).toInt():base;
  setState((){
    int idx=cart.indexWhere((e)=>e["name"]==m["name"] && (e["portion"]??"Full")==portion && e["extraButter"]==false);
    if(idx>=0){cart[idx]["qty"]+=1;} else {cart.add({"name":m["name"],"price":finalPrice,"basePrice":base,"qty":1,"extraButter":false,"portion":portion});}
  });
 }

 void showPortionDialog(Map<String,dynamic> m){
  showDialog(context:context,builder:(c){
    return AlertDialog(
      title:Text(m["name"],style:TextStyle(fontWeight:FontWeight.bold)),
      content:Column(mainAxisSize:MainAxisSize.min,children:[
        Text("Portion select karo:"),
        SizedBox(height:10),
        Text("Half = Rs ${(m["price"]*0.6).toInt()} (60%)",style:TextStyle(fontSize:12)),
        Text("Full = Rs ${m["price"]}",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)),
      ]),
      actions:[
        TextButton(onPressed:(){Navigator.pop(c); addToCart(m,"Half");},child:Text("HALF")),
        ElevatedButton(onPressed:(){Navigator.pop(c); addToCart(m,"Full");},child:Text("FULL - Rs ${m["price"]}"),style:ElevatedButton.styleFrom(backgroundColor:Colors.deepOrange,foregroundColor:Colors.white))
      ]);
  });
 }

 @override Widget build(BuildContext context){
  List<String> cats=["All","Chicken","Mutton","Fish","Veg","Rice","Roti","Biryani","Egg","Drinks","Extra"];
  var filtered=selectedCat=="All"?menu:menu.where((e)=>e["cat"]==selectedCat).toList();
  return Scaffold(
    appBar:AppBar(title:Text("${tbl["name"]} Order - Rs ${total.toStringAsFixed(0)}"),backgroundColor:Colors.deepOrange,foregroundColor:Colors.white),
    body:Column(children:[
      Container(padding:EdgeInsets.all(8),color:Colors.orange.shade50,child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
        Row(children:[Text("PAX:",style:TextStyle(fontSize:12)),IconButton(icon:Icon(Icons.remove,size:18),onPressed:()=>setState(()=>pax=pax>1?pax-1:1)),Text("$pax",style:TextStyle(fontWeight:FontWeight.bold)),IconButton(icon:Icon(Icons.add,size:18),onPressed:()=>setState(()=>pax++))]),
        Row(children:[Text("HOLD",style:TextStyle(fontSize:12)),Switch(value:isHold,onChanged:(v)=>setState(()=>isHold=v),activeColor:Colors.orange)]),
        Text("Rs ${total.toStringAsFixed(0)}",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))
      ])),
      Container(height:40,child:ListView(scrollDirection:Axis.horizontal,padding:EdgeInsets.symmetric(horizontal:8),children:cats.map((ch)=>Padding(padding:EdgeInsets.symmetric(horizontal:3),child:ChoiceChip(label:Text(ch,style:TextStyle(fontSize:11)),selected:selectedCat==ch,onSelected:(v)=>setState(()=>selectedCat=ch)))).toList())),
      Expanded(flex:3,child:GridView.builder(padding:EdgeInsets.all(8),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:2.2,crossAxisSpacing:6,mainAxisSpacing:6),itemCount:filtered.length,
        itemBuilder:(c,i){
          var m=filtered[i];
          return InkWell(onTap:()=>showPortionDialog(m),child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(8),border:Border.all(color:Colors.grey.shade300)),
            child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
              Text(m["name"],textAlign:TextAlign.center,style:TextStyle(fontSize:10,fontWeight:FontWeight.bold)),SizedBox(height:2),
              Text("F ${m["price"]} | H ${(m["price"]*0.6).toInt()}",style:TextStyle(fontSize:8,color:Colors.deepOrange))
            ])));
        })),
      Divider(height:1),
      Expanded(flex:2,child:cart.isEmpty?Center(child:Text("No Items - Menu pe tap karo\nPehle Half fir Full ayega",textAlign:TextAlign.center,style:TextStyle(color:Colors.grey))):ListView.builder(itemCount:cart.length,itemBuilder:(c,i){
        var it=cart[i]; int ex=it["extraButter"]==true?20:0; int pr=(it["price"] as int)*(it["qty"] as int)+ex; String portion=it["portion"]??"Full";
        return ListTile(dense:true,title:Text("${it["name"]} [$portion]",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold)),
          subtitle:Row(children:[Checkbox(value:it["extraButter"],onChanged:(v){setState(()=>it["extraButter"]=v??false);},materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,visualDensity:VisualDensity.compact),Text("Butter +20",style:TextStyle(fontSize:9))]),
          trailing:Row(mainAxisSize:MainAxisSize.min,children:[
            IconButton(icon:Icon(Icons.remove,size:16),padding:EdgeInsets.zero,constraints:BoxConstraints(),onPressed:(){setState((){if(it["qty"]>1)it["qty"]--; else cart.removeAt(i);});}),
            Padding(padding:EdgeInsets.symmetric(horizontal:6),child:Text("${it["qty"]}",style:TextStyle(fontSize:12))),
            IconButton(icon:Icon(Icons.add,size:16),padding:EdgeInsets.zero,constraints:BoxConstraints(),onPressed:(){setState(()=>it["qty"]++);}),
            SizedBox(width:8),Text("Rs $pr",style:TextStyle(fontSize:11,fontWeight:FontWeight.bold)),
            IconButton(icon:Icon(Icons.delete,size:16,color:Colors.red),padding:EdgeInsets.zero,constraints:BoxConstraints(),onPressed:()=>setState(()=>cart.removeAt(i)))
          ]));
      })),
      Container(padding:EdgeInsets.all(10),color:Colors.white,child:Row(children:[Expanded(child:ElevatedButton(onPressed:cart.isEmpty?null:(){
        var order={"id":tbl["id"],"name":tbl["name"],"status":cart.isEmpty?"Empty":"Occupied","amount":total,"pax":pax,"items":cart,"time":"${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2,'0')}", "isHold":isHold};
        widget.onSave(order); Navigator.pop(context);
      },child:Text(isHold?"HOLD TABLE - Rs ${total.toStringAsFixed(0)}":"SAVE KOT - Rs ${total.toStringAsFixed(0)}",style:TextStyle(fontSize:13,fontWeight:FontWeight.bold)),style:ElevatedButton.styleFrom(backgroundColor:isHold?Colors.orange:Colors.green,foregroundColor:Colors.white,minimumSize:Size(double.infinity,48))))])),
    ]));
 }
}
