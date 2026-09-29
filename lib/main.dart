import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false, home:MainApp()));

class MainApp extends StatefulWidget{ @override State<MainApp> createState()=>_MainAppState();}
class _MainAppState extends State<MainApp>{
  int idx=0;
  List<Map<String,dynamic>> tables = List.generate(6, (i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0,"pax":2,"items":[],"time":""});

  @override Widget build(BuildContext context){
    List<Widget> pages=[
      TableGrid(tables:tables, onTapTable:(i){Navigator.push(context, MaterialPageRoute(builder:(_)=>OrderScreen(table:tables[i], onSave:(u){setState(()=>tables[i]=u);}))).then((_)=>setState((){}));}),
      NewOrderQuick(tables:tables, onSelect:(i){setState(()=>idx=0); Navigator.push(context, MaterialPageRoute(builder:(_)=>OrderScreen(table:tables[i], onSave:(u){setState(()=>tables[i]=u);}))).then((_)=>setState((){}));}),
      KOTScreen(tables:tables),
      OrdersScreen(tables:tables, onClear:(i){setState((){tables[i]={"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0,"pax":2,"items":[],"time":""};});}),
      SummaryScreen(tables:tables),
    ];
    return Scaffold(
      backgroundColor:Color(0xFFF8F9FF),
      appBar:AppBar(title:Text(idx==0?"TABLE by KGN Tava Fry":idx==1?"New Order":idx==2?"Live KOT":idx==3?"All Orders":"Business Summary"), backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white),
      body:pages[idx],
      bottomNavigationBar:BottomNavigationBar(currentIndex:idx, onTap:(i)=>setState(()=>idx=i), selectedItemColor:Color(0xFFA33900), unselectedItemColor:Colors.grey, type:BottomNavigationBarType.fixed, items:[
        BottomNavigationBarItem(icon:Icon(Icons.table_restaurant), label:"Tables"),
        BottomNavigationBarItem(icon:Icon(Icons.add_circle), label:"New"),
        BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu), label:"KOT"),
        BottomNavigationBarItem(icon:Icon(Icons.receipt_long), label:"Orders"),
        BottomNavigationBarItem(icon:Icon(Icons.bar_chart), label:"Summary"),
      ]),
    );
  }
}

class TableGrid extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final Function(int) onTapTable;
  TableGrid({required this.tables, required this.onTapTable});
  @override Widget build(BuildContext context){
    return GridView.builder(padding:EdgeInsets.all(12), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, crossAxisSpacing:12, mainAxisSpacing:12, childAspectRatio:1.2), itemCount:6, itemBuilder:(c,i){
      var t=tables[i];
      Color col = t["status"]=="Empty"?Colors.green.shade100:Colors.red.shade100;
      return InkWell(onTap:()=>onTapTable(i), child:Container(decoration:BoxDecoration(color:col, borderRadius:BorderRadius.circular(16)), padding:EdgeInsets.all(12), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text(t["name"], style:TextStyle(fontSize:22, fontWeight:FontWeight.bold)), Icon(Icons.table_restaurant)]),
        Text(t["status"], style:TextStyle(fontWeight:FontWeight.bold, color:t["status"]=="Empty"?Colors.green:Colors.red)),
        Spacer(),
        if(t["amount"]>0) Text("Rs ${t["amount"]}", style:TextStyle(fontWeight:FontWeight.bold, fontSize:18, color:Color(0xFFA33900))),
        Text("${t["pax"]} PAX | ${t["items"].length} Items", style:TextStyle(fontSize:11)),
        if(t["time"]!="") Text(t["time"], style:TextStyle(fontSize:9, color:Colors.grey)),
      ])));
    });
  }
}

class NewOrderQuick extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final Function(int) onSelect;
  NewOrderQuick({required this.tables, required this.onSelect});
  @override Widget build(BuildContext context){
    return ListView.builder(padding:EdgeInsets.all(12), itemCount:6, itemBuilder:(c,i){
      var t=tables[i];
      return Card(child:ListTile(leading:CircleAvatar(backgroundColor:t["status"]=="Empty"?Colors.green:Colors.red, child:Text(t["name"], style:TextStyle(color:Colors.white))), title:Text("Table ${t["name"]} - ${t["status"]}"), subtitle:Text(t["status"]=="Empty"?"Tap to take new order":"${t["items"].length} items - Rs ${t["amount"]}"), trailing:ElevatedButton(onPressed:()=>onSelect(i), child:Text(t["status"]=="Empty"?"New Order":"Add More")),));
    });
  }
}

class KOTScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  KOTScreen({required this.tables});
  @override Widget build(BuildContext context){
    var live = tables.where((t)=>t["status"]=="Occupied").toList();
    if(live.isEmpty) return Center(child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[Icon(Icons.restaurant_menu, size:60, color:Colors.grey), SizedBox(height:10), Text("No Live KOT", style:TextStyle(color:Colors.grey))]));
    return ListView.builder(padding:EdgeInsets.all(12), itemCount:live.length, itemBuilder:(c,i){
      var t=live[i];
      return Card(color:Color(0xFFFFF3E0), child:Padding(padding:EdgeInsets.all(12), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text("${t["name"]} - KOT", style:TextStyle(fontWeight:FontWeight.bold, color:Color(0xFFA33900))), Text(t["time"], style:TextStyle(fontSize:11))]),
        Divider(),
       ...List.generate(t["items"].length, (j){var it=t["items"][j]; return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text("${it["qty"]} x ${it["name"]} (${it["half"]?"HALF":"FULL"})"), Text("Rs ${it["half"]?it["h"]:it["f"]}")]);}),
        Divider(),
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text("Total Rs ${t["amount"]}", style:TextStyle(fontWeight:FontWeight.bold)), Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:2), decoration:BoxDecoration(color:Colors.green, borderRadius:BorderRadius.circular(10)), child:Text("IN KITCHEN", style:TextStyle(color:Colors.white, fontSize:10)))]),
      ])));
    });
  }
}

class OrdersScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final Function(int) onClear;
  OrdersScreen({required this.tables, required this.onClear});
  @override Widget build(BuildContext context){
    var occ = tables.where((t)=>t["status"]=="Occupied").toList();
    if(occ.isEmpty) return Center(child:Text("No active orders"));
    return ListView.builder(padding:EdgeInsets.all(12), itemCount:occ.length, itemBuilder:(c,i){
      var t=occ[i];
      int realIdx = tables.indexWhere((e)=>e["name"]==t["name"]);
      return Card(child:ListTile(title:Text("${t["name"]} - Rs ${t["amount"]}"), subtitle:Text("${t["items"].length} items • ${t["time"]}"), trailing:Row(mainAxisSize:MainAxisSize.min, children:[IconButton(icon:Icon(Icons.print), onPressed:(){}), IconButton(icon:Icon(Icons.check_circle, color:Colors.green), onPressed:(){showDialog(context:context, builder:(_)=>AlertDialog(title:Text("Bill Paid?"), content:Text("Clear ${t["name"]} bill of Rs ${t["amount"]}?"), actions:[TextButton(onPressed:()=>Navigator.pop(context), child:Text("No")), ElevatedButton(onPressed:(){onClear(realIdx); Navigator.pop(context);}, child:Text("Yes, Paid"))]));})])));
    });
  }
}

class SummaryScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  SummaryScreen({required this.tables});
  @override Widget build(BuildContext context){
    int totalSale = tables.fold(0, (a,b)=>a+(b["amount"] as int));
    int occ = tables.where((t)=>t["status"]=="Occupied").length;
    return Padding(padding:EdgeInsets.all(16), child:Column(children:[
      Row(children:[
        Expanded(child:Container(padding:EdgeInsets.all(16), decoration:BoxDecoration(color:Color(0xFFA33900), borderRadius:BorderRadius.circular(12)), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text("Today Sale", style:TextStyle(color:Colors.white70)), SizedBox(height:4), Text("Rs $totalSale", style:TextStyle(color:Colors.white, fontSize:24, fontWeight:FontWeight.bold)), Text("No GST", style:TextStyle(color:Colors.white70, fontSize:11))]))),
        SizedBox(width:12),
        Expanded(child:Container(padding:EdgeInsets.all(16), decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(12)), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text("Tables", style:TextStyle(color:Colors.grey)), SizedBox(height:4), Text("$occ / 6 Occupied", style:TextStyle(fontSize:18, fontWeight:FontWeight.bold)), Text("${6-occ} Empty", style:TextStyle(color:Colors.green))]))),
      ]),
      SizedBox(height:16),
      Container(width:double.infinity, padding:EdgeInsets.all(16), decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(12)), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
        Text("Why Choose Table by KGN?", style:TextStyle(fontWeight:FontWeight.bold)),
        SizedBox(height:8),
        Text("• Fast Billing • Smart KOT • Table Management\n• Waiter App • Printer Support • No GST\n• Designed for Indian Restaurants", style:TextStyle(fontSize:13, color:Colors.grey.shade700)),
      ]))
    ]));
  }
}

class OrderScreen extends StatefulWidget{
  final Map<String,dynamic> table;
  final Function(Map<String,dynamic>) onSave;
  OrderScreen({required this.table, required this.onSave});
  @override State<OrderScreen> createState()=>_OrderScreenState();
}
class _OrderScreenState extends State<OrderScreen>{
  String cat="All"; String search="";
  List<String> cats=["All","Chicken","Mutton","Fish","Egg","Veg","Roti"];
  late List<Map<String,dynamic>> menu;
  @override void initState(){
    super.initState();
    menu=[
      {"id":1,"name":"Murga Do Pyaza","h":160,"f":300,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":2,"name":"Murga Moghlai","h":170,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":3,"name":"Chicken Handi","h":160,"f":300,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":4,"name":"Chicken Pisawar","h":170,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":5,"name":"Murg Shahi","h":170,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":6,"name":"Malai Tikka","h":180,"f":350,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":7,"name":"Tikka Masala","h":170,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":8,"name":"Kadhai Chicken","h":160,"f":300,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":9,"name":"Garlic Chicken","h":160,"f":300,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":10,"name":"Chicken India","h":250,"f":450,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":11,"name":"Butter Boneless","h":170,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":12,"name":"White Chicken","h":180,"f":350,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":13,"name":"Green Chicken","h":180,"f":350,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":14,"name":"Chicken Fry","h":120,"f":220,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":15,"name":"Chicken Masala","h":120,"f":220,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":16,"name":"Chicken Biryani","h":80,"f":120,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":17,"name":"Tandoori Masala","h":250,"f":480,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":18,"name":"Amdavadi","h":160,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":19,"name":"Tikka Rice","h":170,"f":320,"cat":"Chicken","qty":0,"half":true,"t":"n"},
      {"id":20,"name":"Moghlai Mutton","h":150,"f":280,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":21,"name":"Dal Bati Gos","h":150,"f":280,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":22,"name":"White Mutton","h":160,"f":300,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":23,"name":"Green Mutton","h":150,"f":280,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":24,"name":"Mutton Kurma","h":160,"f":300,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":25,"name":"Mutton Fry","h":120,"f":220,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":26,"name":"Mutton Masala","h":120,"f":220,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":27,"name":"Kaleji Masala","h":120,"f":220,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":28,"name":"Bhaji Gos","h":130,"f":240,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":29,"name":"Paya Fry","h":120,"f":220,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":30,"name":"Chaap Fry","h":120,"f":220,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":31,"name":"Bheja Fry","h":130,"f":240,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":32,"name":"Boti Masala","h":120,"f":220,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":33,"name":"Keema Fry","h":80,"f":160,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":34,"name":"Keema Pulav","h":100,"f":180,"cat":"Mutton","qty":0,"half":true,"t":"n"},
      {"id":35,"name":"Machhi Fry","h":80,"f":160,"cat":"Fish","qty":0,"half":true,"t":"n"},
      {"id":36,"name":"Machhi Kadi","h":100,"f":200,"cat":"Fish","qty":0,"half":true,"t":"n"},
      {"id":37,"name":"Jinga Fry","h":130,"f":240,"cat":"Fish","qty":0,"half":true,"t":"n"},
      {"id":38,"name":"Jinga Rice","h":170,"f":320,"cat":"Fish","qty":0,"half":true,"t":"n"},
      {"id":39,"name":"Anda Kadi","h":80,"f":160,"cat":"Egg","qty":0,"half":true,"t":"n"},
      {"id":40,"name":"Anda Keema","h":80,"f":160,"cat":"Egg","qty":0,"half":true,"t":"n"},
      {"id":41,"name":"Anda Bhurji","h":50,"f":100,"cat":"Egg","qty":0,"half":true,"t":"n"},
      {"id":42,"name":"Anda Pulav","h":60,"f":120,"cat":"Egg","qty":0,"half":true,"t":"n"},
      {"id":43,"name":"Dal Tadka","h":70,"f":140,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":44,"name":"Dal Gotala","h":80,"f":160,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":45,"name":"Butter Dal Fry","h":70,"f":140,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":46,"name":"Dal Fry","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":47,"name":"Sabji Fry","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":48,"name":"Sev Tameta","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":49,"name":"Masala Rice","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":50,"name":"Biryani Rice","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":51,"name":"Jeera Rice","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":52,"name":"Kadi Khichdi","h":30,"f":60,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":53,"name":"Dal Pulav","h":50,"f":100,"cat":"Veg","qty":0,"half":true,"t":"v"},
      {"id":54,"name":"Plain Rice","h":30,"f":60,"cat":"Roti","qty":0,"half":false,"t":"v"},
      {"id":55,"name":"Special Roti","h":15,"f":15,"cat":"Roti","qty":0,"half":false,"t":"v"},
      {"id":56,"name":"Special Paratha","h":20,"f":20,"cat":"Roti","qty":0,"half":false,"t":"v"},
      {"id":57,"name":"Butter Roti","h":15,"f":15,"cat":"Roti","qty":0,"half":false,"t":"v"},
      {"id":58,"name":"Chapati Roti","h":7,"f":7,"cat":"Roti","qty":0,"half":false,"t":"v"},
      {"id":59,"name":"Papad Fry","h":10,"f":10,"cat":"Roti","qty":0,"half":false,"t":"v"},
    ];
    if(widget.table["items"]!=null && (widget.table["items"] as List).isNotEmpty){
      for(var old in widget.table["items"]){
        var idx=menu.indexWhere((m)=>m["id"]==old["id"]);
        if(idx!=-1){menu[idx]["qty"]=old["qty"]; menu[idx]["half"]=old["half"];}
      }
    }
  }
  List get filtered=>menu.where((m){bool c1=cat=="All"||m["cat"]==cat; bool c2=m["name"].toString().toLowerCase().contains(search.toLowerCase()); return c1&&c2;}).toList();
  int get total=>menu.fold(0,(a,b){int pr=b["half"]?b["h"]:b["f"]; return a+pr*(b["qty"] as int);});
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text("Table ${widget.table["name"]} - 59 Items"), backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white),
      body:Column(children:[
        Padding(padding:EdgeInsets.all(8), child:TextField(onChanged:(v)=>setState(()=>search=v), decoration:InputDecoration(hintText:"Search 59 items...", prefixIcon:Icon(Icons.search), filled:true, fillColor:Colors.white, border:OutlineInputBorder(borderRadius:BorderRadius.circular(12), borderSide:BorderSide.none)))),
        SizedBox(height:36, child:ListView.builder(scrollDirection:Axis.horizontal, padding:EdgeInsets.symmetric(horizontal:8), itemCount:cats.length, itemBuilder:(c,i)=>Padding(padding:EdgeInsets.only(right:6), child:ChoiceChip(label:Text(cats[i]), selected:cat==cats[i], onSelected:(v)=>setState(()=>cat=cats[i]))))),
        Expanded(child:ListView.builder(padding:EdgeInsets.all(8), itemCount:filtered.length, itemBuilder:(c,i){
          var m=filtered[i];
          return Container(margin:EdgeInsets.only(bottom:6), decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(12)), child:ListTile(
            title:Text(m["name"], style:TextStyle(fontWeight:FontWeight.bold, fontSize:13)),
            subtitle:Row(children:[
              InkWell(onTap:()=>setState(()=>m["half"]=true), child:Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:2), decoration:BoxDecoration(color:m["half"]?Color(0xFFA33900):Colors.grey.shade200, borderRadius:BorderRadius.circular(6)), child:Text("HALF ${m["h"]}", style:TextStyle(fontSize:10, color:m["half"]?Colors.white:Colors.black, fontWeight:FontWeight.bold)))),
              SizedBox(width:6),
              InkWell(onTap:()=>setState(()=>m["half"]=false), child:Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:2), decoration:BoxDecoration(color:!m["half"]?Color(0xFFA33900):Colors.grey.shade200, borderRadius:BorderRadius.circular(6)), child:Text("FULL ${m["f"]}", style:TextStyle(fontSize:10, color:!m["half"]?Colors.white:Colors.black, fontWeight:FontWeight.bold)))),
            ]),
            trailing:m["qty"]>0?Row(mainAxisSize:MainAxisSize.min, children:[IconButton(icon:Icon(Icons.remove), onPressed:()=>setState(()=>m["qty"]--)), Text("${m["qty"]}"), IconButton(icon:Icon(Icons.add), onPressed:()=>setState(()=>m["qty"]++))]):ElevatedButton(onPressed:()=>setState(()=>m["qty"]=1), child:Text("Add")),
          ));
        })),
        if(total>0) Container(padding:EdgeInsets.all(12), color:Colors.white, child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text("Total = Rs $total", style:TextStyle(fontWeight:FontWeight.bold, fontSize:16, color:Color(0xFFA33900))), ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white), onPressed:(){widget.table["items"]=menu.where((m)=>m["qty"]>0).toList(); widget.table["amount"]=total; widget.table["status"]=total>0?"Occupied":"Empty"; widget.table["time"]="${DateTime.now().hour}:${DateTime.now().minute}"; widget.onSave(widget.table); Navigator.pop(context);}, child:Text("Save KOT"))]))
      ]),
    );
  }
}
