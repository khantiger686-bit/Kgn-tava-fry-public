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
        Container(padding:EdgeInsets.all(12), color:Colors.white, child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
          Text("Smart restaurant billing, KOT & order tracking", style:TextStyle(fontWeight:FontWeight.bold)),
          SizedBox(height:4),
          Row(children:[
            _chip("Dine-in",true), _chip("Takeaway",false), _chip("Delivery",false),
          ])
        ])),
        Expanded(child:GridView.builder(padding:EdgeInsets.all(12), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, crossAxisSpacing:12, mainAxisSpacing:12, childAspectRatio:1.2), itemCount:6, itemBuilder:(c,i){
          var t=tables[i];
          Color col = t["status"]=="Empty"?Colors.green.shade100: t["status"]=="Occupied"?Colors.red.shade100: Colors.orange.shade100;
          return InkWell(onTap:(){Navigator.push(context, MaterialPageRoute(builder:(_)=>OrderScreen(table:t, onSave:(updated){setState(()=>tables[i]=updated);}))).then((_)=>setState((){}));}, child:Container(decoration:BoxDecoration(color:col, borderRadius:BorderRadius.circular(16), border:Border.all(color:Colors.white)), padding:EdgeInsets.all(12), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
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
        BottomNavigationBarItem(icon:Icon(Icons.add_circle), label:"New Order"),
        BottomNavigationBarItem(icon:Icon(Icons.skillet), label:"Live KOT"),
        BottomNavigationBarItem(icon:Icon(Icons.receipt), label:"Orders"),
        BottomNavigationBarItem(icon:Icon(Icons.analytics), label:"Summary"),
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

  // 59 ITEMS - HALF FIRST THEN FULL (As per your photo)
  late List<Map<String,dynamic>> menu;

  @override void initState(){
    super.initState();
    menu = [
      {"id":1,"name":"Murga Do Pyaza","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":2,"name":"Murga Moghlai","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":3,"name":"Chicken Handi","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":4,"name":"Chicken Pisawar","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":5,"name":"Murg Shahi","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":6,"name":"Chicken Malai Tikka","priceH":180,"priceF":350,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":7,"name":"Chicken Tikka Masala","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":8,"name":"Chicken Kadhai","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":9,"name":"Chicken Garlic","priceH":160,"priceF":300,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":10,"name":"Chicken India","priceH":250,"priceF":450,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":11,"name":"Butter Chicken Boneless","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":12,"name":"White Chicken","priceH":180,"priceF":350,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":13,"name":"Green Chicken","priceH":180,"priceF":350,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":14,"name":"Chicken Fry","priceH":120,"priceF":220,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":15,"name":"Chicken Masala","priceH":120,"priceF":220,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":16,"name":"Chicken Biryani","priceH":80,"priceF":120,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":17,"name":"Chicken Tandoori Masala","priceH":250,"priceF":480,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":18,"name":"Chicken Amdavadi","priceH":160,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":19,"name":"Chicken Tikka Rice","priceH":170,"priceF":320,"cat":"Chicken Fry","qty":0,"isHalf":true,"type":"n"},
      {"id":20,"name":"Moghlai Mutton","priceH":150,"priceF":280,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":21,"name":"Dal Bati Gos","priceH":150,"priceF":280,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":22,"name":"White Mutton","priceH":160,"priceF":300,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":23,"name":"Green Mutton","priceH":150,"priceF":280,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":24,"name":"Mutton Kurma","priceH":160,"priceF":300,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":25,"name":"Mutton Fry","priceH":120,"priceF":220,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":26,"name":"Mutton Masala","priceH":120,"priceF":220,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":27,"name":"Kaleji Masala","priceH":120,"priceF":220,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":28,"name":"Bhaji Gos","priceH":130,"priceF":240,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":29,"name":"Paya Fry","priceH":120,"priceF":220,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":30,"name":"Chaap Fry","priceH":120,"priceF":220,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":31,"name":"Bheja Fry","priceH":130,"priceF":240,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":32,"name":"Boti Masala","priceH":120,"priceF":220,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":33,"name":"Keema Fry","priceH":80,"priceF":160,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":34,"name":"Keema Pulav","priceH":100,"priceF":180,"cat":"Mutton Item","qty":0,"isHalf":true,"type":"n"},
      {"id":35,"name":"Machhi Fry","priceH":80,"priceF":160,"cat":"Zinga-Machhi","qty":0,"isHalf":true,"type":"n"},
      {"id":36,"name":"Machhi Kadi","priceH":100,"priceF":200,"cat":"Zinga-Machhi","qty":0,"isHalf":true,"type":"n"},
      {"id":37,"name":"Jinga Fry","priceH":130,"priceF":240,"cat":"Zinga-Machhi","qty":0,"isHalf":true,"type":"n"},
      {"id":38,"name":"Jinga Rice","priceH":170,"priceF":320,"cat":"Zinga-Machhi","qty":0,"isHalf":true,"type":"n"},
      {"id":39,"name":"Anda Kadi","priceH":80,"priceF":160,"cat":"Anda Item","qty":0,"isHalf":true,"type":"n"},
      {"id":40,"name":"Anda Keema","priceH":80,"priceF":160,"cat":"Anda Item","qty":0,"isHalf":true,"type":"n"},
      {"id":41,"name":"Anda Bhurji","priceH":50,"priceF":100,"cat":"Anda Item","qty":0,"isHalf":true,"type":"n"},
      {"id":42,"name":"Anda Pulav","priceH":60,"priceF":120,"cat":"Anda Item","qty":0,"isHalf":true,"type":"n"},
      {"id":43,"name":"Dal Tadka","priceH":70,"priceF":140,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":44,"name":"Dal Gotala","priceH":80,"priceF":160,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":45,"name":"Butter Dal Fry","priceH":70,"priceF":140,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":46,"name":"Dal Fry","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":47,"name":"Sabji Fry","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":48,"name":"Sev Tameta","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":49,"name":"Masala Rice","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":50,"name":"Biryani Rice","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":51,"name":"Jeera Rice","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":52,"name":"Kadi Khichdi","priceH":30,"priceF":60,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":53,"name":"Dal Pulav","priceH":50,"priceF":100,"cat":"Veg Item","qty":0,"isHalf":true,"type":"v"},
      {"id":54,"name":"Plain Rice","priceH":30,"priceF":60,"cat":"Roti-Rice","qty":0,"isHalf":false,"type":"v"},
      {"id":55,"name":"Special Roti","priceH":15,"priceF":15,"cat":"Roti-Rice","qty":0,"isHalf":false,"type":"v"},
      {"id":56,"name":"Special Paratha","priceH":20,"priceF":20,"cat":"Roti-Rice","qty":0,"isHalf":false,"type":"v"},
      {"id":57,"name":"Butter Roti","priceH":15,"priceF":15,"cat":"Roti-Rice","qty":0,"isHalf":false,"type":"v"},
      {"id":58,"name":"Chapati Roti","priceH":7,"priceF":7,"cat":"Roti-Rice","qty":0,"isHalf":false,"type":"v"},
      {"id":59,"name":"Papad Fry","priceH":10,"priceF":10,"cat":"Roti-Rice","qty":0,"isHalf":false,"type":"v"},
    ];
    // Load old items if any
    if(widget.table["items"]!=null && (widget.table["items"] as List).isNotEmpty){
      for(var old in widget.table["items"]){
        var idx=menu.indexWhere((m)=>m["id"]==old["id"]);
        if(idx!=-1){menu[idx]["qty"]=old["qty"]; menu[idx]["isHalf"]=old["isHalf"];}
      }
    }
  }

  List get filtered=>menu.where((m){bool c1=cat=="All"||m["cat"]==cat; bool c2=m["name"].toString().toLowerCase().contains(search.toLowerCase()); return c1&&c2;}).toList();
  int get total=>menu.fold(0,(a,b){int pr=b["isHalf"]?b["priceH"]:b["priceF"]; return a+pr*(b["qty"] as int);});
  int get totalQty=>menu.fold(0,(a,b)=>a+(b["qty"] as int));

  void saveOrder(){
    widget.table["items"]=menu.where((m)=>m["qty"]>0).toList();
    widget.table["amount"]=total;
    widget.table["status"]=total>0?"Occupied":"Empty";
    widget.onSave(widget.table);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("KOT Sent to Kitchen - ${widget.table["name"]} - Total ₹$total")));
    Navigator.pop(context);
  }

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text("Table ${widget.table["name"]} - New Order - Live"), backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white),
      body:Column(children:[
        Container(margin:EdgeInsets.all(8), padding:EdgeInsets.all(10), decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(12)), child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[
          Container(padding:EdgeInsets.symmetric(horizontal:12,vertical:6), decoration:BoxDecoration(color:Color(0xFFDCE9FF), borderRadius:BorderRadius.circular(10)), child:Row(children:[Icon(Icons.table_restaurant, color:Color(0xFFA33900)), SizedBox(width:6), Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text("Table ${widget.table["name"]}", style:TextStyle(fontWeight:FontWeight.bold)), Text("Dine-in Floor", style:TextStyle(fontSize:10, color:Color(0xFFA33900)))])])),
          Container(padding:EdgeInsets.all(3), decoration:BoxDecoration(color:Color(0xFFE5EEFF), borderRadius:BorderRadius.circular(8)), child:Row(children:[_chBtn("Dine-in",true),_chBtn("Takeaway",false),_chBtn("Delivery",false)]))
        ])),
        Padding(padding:EdgeInsets.symmetric(horizontal:8), child:TextField(onChanged:(v)=>setState(()=>search=v), decoration:InputDecoration(hintText:"Search dishes (Bheja, Chicken Tikka, Roti)...", prefixIcon:Icon(Icons.search), filled:true, fillColor:Colors.white, border:OutlineInputBorder(borderRadius:BorderRadius.circular(12), borderSide:BorderSide.none)))),
        SizedBox(height:8),
        SizedBox(height:36, child:ListView.builder(scrollDirection:Axis.horizontal, padding:EdgeInsets.symmetric(horizontal:8), itemCount:cats.length, itemBuilder:(c,i)=>Padding(padding:EdgeInsets.only(right:6), child:ChoiceChip(label:Text(cats[i]), selected:cat==cats[i], onSelected:(v)=>setState(()=>cat=cats[i]))))),
        Expanded(child:ListView.builder(padding:EdgeInsets.all(8), itemCount:filtered.length, itemBuilder:(c,i){
          var m=filtered[i];
          int price = m["isHalf"]?m["priceH"]:m["priceF"];
          return Container(margin:EdgeInsets.only(bottom:6), decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(12)), child:ListTile(
            leading:Icon(m["type"]=="v"?Icons.circle:Icons.play_arrow, color:m["type"]=="v"?Colors.green:Colors.red, size:16),
            title:Text(m["name"], style:TextStyle(fontWeight:FontWeight.bold, fontSize:13)),
            subtitle:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
              Row(children:[
                InkWell(onTap:()=>setState(()=>m["isHalf"]=true), child:Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:2), decoration:BoxDecoration(color:m["isHalf"]?Color(0xFFA33900):Colors.grey.shade200, borderRadius:BorderRadius.circular(6)), child:Text("HALF ₹${m["priceH"]}", style:TextStyle(fontSize:10, color:m["isHalf"]?Colors.white:Colors.black, fontWeight:FontWeight.bold)))),
                SizedBox(width:6),
                InkWell(onTap:()=>setState(()=>m["isHalf"]=false), child:Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:2), decoration:BoxDecoration(color:!m["isHalf"]?Color(0xFFA33900):Colors.grey.shade200, borderRadius:BorderRadius.circular(6)), child:Text("FULL ₹${m["priceF"]}", style:TextStyle(fontSize:10, color:!m["isHalf"]?Colors.white:Colors.black, fontWeight:FontWeight.bold)))),
              ]),
              if(m["qty"]>0) Text("× ${m["qty"]} = ₹${price*m["qty"]}", style:TextStyle(fontSize:11, color:Colors.grey))
            ]),
            trailing:m["qty"]>0?Container(padding:EdgeInsets.all(2), decoration:BoxDecoration(color:Color(0xFFE5EEFF), borderRadius:BorderRadius.circular(8)), child:Row(mainAxisSize:MainAxisSize.min, children:[InkWell(onTap:()=>setState(()=>m["qty"]>0?m["qty"]--:null), child:Container(width:32,height:32,decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(6)), child:Icon(Icons.remove,size:16))), Container(width:28, child:Center(child:Text("${m["qty"]}", style:TextStyle(fontWeight:FontWeight.bold)))), InkWell(onTap:()=>setState(()=>m["qty"]++), child:Container(width:32,height:32,decoration:BoxDecoration(color:Color(0xFFA33900), borderRadius:BorderRadius.circular(6)), child:Icon(Icons.add,size:16,color:Colors.white)))])):ElevatedButton(onPressed:()=>setState(()=>m["qty"]=1), style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFE5EEFF)), child:Text("Add", style:TextStyle(color:Color(0xFFA33900)))),
          ));
        })),
        if(total>0) Container(padding:EdgeInsets.all(12), decoration:BoxDecoration(color:Colors.white, boxShadow:[BoxShadow(color:Colors.black12, blurRadius:8)]), child:Column(children:[
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Row(children:[Container(width:8,height:8,decoration:BoxDecoration(color:Colors.green, shape:BoxShape.circle)), SizedBox(width:6), Text("$totalQty Qty • Total:", style:TextStyle(fontWeight:FontWeight.bold)), Text(" ₹$total", style:TextStyle(fontWeight:FontWeight.bold, color:Color(0xFFA33900), fontSize:16))]), Text("No GST", style:TextStyle(fontSize:10, color:Colors.grey))]),
          SizedBox(height:8),
          Row(children:[
            Expanded(child:OutlinedButton.icon(onPressed:(){}, icon:Icon(Icons.print,size:18), label:Text("Print KOT"), style:OutlinedButton.styleFrom(padding:EdgeInsets.symmetric(vertical:14), backgroundColor:Color(0xFF565E74), foregroundColor:Colors.white))),
            SizedBox(width:8),
            Expanded(flex:2, child:ElevatedButton.icon(onPressed:saveOrder, icon:Icon(Icons.bolt), label:Text("Save & Punch - KOT"), style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white, padding:EdgeInsets.symmetric(vertical:14)))),
          ])
        ]))
      ]),
    );
  }
  Widget _chBtn(String t,bool sel)=>Container(padding:EdgeInsets.symmetric(horizontal:10,vertical:6), decoration:BoxDecoration(color:sel?Colors.white:Colors.transparent, borderRadius:BorderRadius.circular(6)), child:Text(t, style:TextStyle(fontSize:11, fontWeight:sel?FontWeight.bold:FontWeight.normal, color:sel?Color(0xFFA33900):Colors.grey)));
}
