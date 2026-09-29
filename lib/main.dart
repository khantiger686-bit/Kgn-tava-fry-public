import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false, home:TableListScreen()));
class TableListScreen extends StatefulWidget{ @override State<TableListScreen> createState()=>_TableListScreenState();}
class _TableListScreenState extends State<TableListScreen>{
  List<Map<String,dynamic>> tables = List.generate(6, (i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0,"pax":2,"items":[]});
  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFF8F9FF),
      appBar:AppBar(title:Text("TABLE by KGN Tava Fry"), backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white),
      body:GridView.builder(padding:EdgeInsets.all(12), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, crossAxisSpacing:12, mainAxisSpacing:12, childAspectRatio:1.2), itemCount:6, itemBuilder:(c,i){
          var t=tables[i];
          Color col = t["status"]=="Empty"?Colors.green.shade100:Colors.red.shade100;
          return InkWell(onTap:(){Navigator.push(context, MaterialPageRoute(builder:(_)=>OrderScreen(table:t, onSave:(u){setState(()=>tables[i]=u);}))).then((_)=>setState((){}));}, child:Container(decoration:BoxDecoration(color:col, borderRadius:BorderRadius.circular(16)), padding:EdgeInsets.all(12), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text(t["name"], style:TextStyle(fontSize:22, fontWeight:FontWeight.bold)), Icon(Icons.table_restaurant)]),
            Text(t["status"], style:TextStyle(fontWeight:FontWeight.bold)),
            Spacer(),
            if(t["amount"]>0) Text("Rs ${t["amount"]}", style:TextStyle(fontWeight:FontWeight.bold, fontSize:18)),
            Text("${t["pax"]} PAX | ${t["items"].length} Items", style:TextStyle(fontSize:11))
          ])));
      }),
      bottomNavigationBar:BottomNavigationBar(selectedItemColor:Color(0xFFA33900), type:BottomNavigationBarType.fixed, items:[
        BottomNavigationBarItem(icon:Icon(Icons.table_restaurant), label:"Tables"),
        BottomNavigationBarItem(icon:Icon(Icons.add_circle), label:"New"),
        BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu), label:"KOT"),
        BottomNavigationBarItem(icon:Icon(Icons.receipt_long), label:"Orders"),
        BottomNavigationBarItem(icon:Icon(Icons.bar_chart), label:"Summary"),
      ]),
    );
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
        if(total>0) Container(padding:EdgeInsets.all(12), color:Colors.white, child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children:[Text("Total = Rs $total", style:TextStyle(fontWeight:FontWeight.bold, fontSize:16, color:Color(0xFFA33900))), ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFA33900), foregroundColor:Colors.white), onPressed:(){widget.table["items"]=menu.where((m)=>m["qty"]>0).toList(); widget.table["amount"]=total; widget.table["status"]=total>0?"Occupied":"Empty"; widget.onSave(widget.table); Navigator.pop(context);}, child:Text("Save KOT"))]))
      ]),
    );
  }
}
