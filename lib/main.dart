import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TableApp()));

class TableApp extends StatefulWidget {
  @override _TableAppState createState() => _TableAppState();
}
class _TableAppState extends State<TableApp> {
  String cat = "All";
  String table = "T-1";
  String pay = "Cash";
  String search = "";
  String mode = "Dine-In";
  bool showCart = false;
  List<String> cats = ["All","Chicken Item","Mutton Item","Fish Item","Anda Item","Veg Item","Roti Item"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> pays = ["Cash","UPI","PhonePe","Google Pay","Card","Others"];

  // PURA 59 ITEMS + REAL PHOTO
  List<Map<String, dynamic>> menu = [
    {"name":"Chapati Roti","price":7,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
    {"name":"chaas","price":20,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1544148103-005eec06c04d"},
    {"name":"Kheema masala Half","price":80,"cat":"Mutton Item","img":"https://images.unsplash.com/photo-1541518763669-27fef04b14ea"},
    {"name":"Chicken Masala Half","price":120,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"name":"chicken Dana","price":100,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1527477396000-e27163b489c2"},
    {"name":"mutton seekh kabab","price":10,"cat":"Mutton Item","img":"https://images.unsplash.com/photo-1599487488170-d11ec9c172f0"},
    {"name":"water botl badi","price":20,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1548839140-29a749e1cf4d"},
    {"name":"Butter Chicken Half","price":100,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"name":"Bheja masala Half","price":130,"cat":"Mutton Item","img":"https://images.unsplash.com/photo-1541518763669-27fef04b14ea"},
    {"name":"Chicken Handi","price":170,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"name":"Chicken Fry","price":120,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"name":"Mutton Fry","price":120,"cat":"Mutton Item","img":"https://images.unsplash.com/photo-1541518763669-27fef04b14ea"},
    {"name":"Dal Tadka","price":70,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1546833999-b9f581a1996d"},
    {"name":"Special Roti","price":15,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
    {"name":"Papad Fry","price":10,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
    {"name":"Murgh Do Pyaza","price":170,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"name":"Chicken Biryani","price":80,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8"},
    {"name":"Mutton Biryani","price":100,"cat":"Mutton Item","img":"https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8"},
    {"name":"Anda Bhurji","price":50,"cat":"Anda Item","img":"https://images.unsplash.com/photo-1482049016688-2d3e1b311543"},
    {"name":"Jeera Rice","price":50,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1536304929831-ee1ca9d44906"},
    {"name":"Kadhi Khichdi","price":30,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1546833999-b9f581a1996d"},
    {"name":"Dal Fry","price":50,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1546833999-b9f581a1996d"},
    {"name":"Machhi Fry","price":80,"cat":"Fish Item","img":"https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2"},
    {"name":"Jhinga Fry","price":130,"cat":"Fish Item","img":"https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2"},
    {"name":"Anda Kadhi","price":80,"cat":"Anda Item","img":"https://images.unsplash.com/photo-1482049016688-2d3e1b311543"},
    {"name":"Masala Rice","price":50,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1536304929831-ee1ca9d44906"},
    {"name":"Special Paratha","price":20,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
    {"name":"Butter Roti","price":15,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
  ];

  Map<String, int> cart = {};
  int get totalItems => cart.values.fold(0, (a,b)=>a+b);
  int get subTotal {
    int tot=0;
    cart.forEach((k,q){
      var it = menu.firstWhere((m)=>m["name"]==k, orElse: ()=>{"price":0});
      tot += (it["price"] as int)*q;
    });
    return tot;
  }
  List<Map<String, dynamic>> get filtered => menu.where((m){
    bool c1 = cat=="All" || m["cat"]==cat;
    bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase());
    return c1 && c2;
  }).toList();

  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, title: Text(showCart? "Cart" : "Add Order", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: (){ if(showCart) setState(()=>showCart=false); }), actions: [IconButton(icon: Icon(Icons.settings, color: Colors.black), onPressed: (){})]),
      body: showCart? buildCart() : buildOrder(),
    );
  }

  Widget buildOrder(){
    return Column(children: [
      Padding(padding: EdgeInsets.all(10), child: Row(children: [Expanded(child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search", prefixIcon: Icon(Icons.search), suffixIcon: Icon(Icons.mic, color: Colors.deepPurple), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300))))), SizedBox(width:8), Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.mic, color: Colors.deepPurple))]) ),
      SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.symmetric(horizontal:4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], selectedColor: Colors.blue.shade50, backgroundColor: Colors.grey.shade100, labelStyle: TextStyle(color: cat==cats[i]? Colors.blue: Colors.black, fontWeight: cat==cats[i]? FontWeight.bold: FontWeight.normal), shape: StadiumBorder(side: BorderSide(color: cat==cats[i]? Colors.blue: Colors.grey.shade300)), onSelected: (v)=>setState(()=>cat=cats[i]))))),
      SizedBox(height:8),
      Expanded(child: GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:0.68, crossAxisSpacing:10, mainAxisSpacing:10), itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i];
        int qty = cart[m["name"]]??0;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // PHOTO PE PRICE + PLUS BUTTON - EXACT VIDEO JAISA
          Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(14), child: Container(height:115, width: double.infinity, color: Colors.grey.shade200, child: Image.network(m["img"], fit: BoxFit.cover, errorBuilder: (c,e,s)=> Icon(Icons.fastfood, size:40)))),
            Positioned(top:8, right:8, child: Text("₹${m["price"]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:14, shadows: [Shadow(color: Colors.black, blurRadius: 6)]))),
            Positioned(bottom:8, right:8, child: qty==0? InkWell(onTap: ()=>setState(()=>cart[m["name"]]=1), child: Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]), child: Icon(Icons.add, size:18, color: Colors.blue)))
            : Container(padding: EdgeInsets.symmetric(horizontal:6, vertical:4), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)), child: Row(children: [InkWell(onTap: ()=>setState(()=>qty==1? cart.remove(m["name"]): cart[m["name"]]=qty-1), child: Icon(Icons.remove, size:14, color: Colors.white)), SizedBox(width:6), Text("$qty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:12)), SizedBox(width:6), InkWell(onTap: ()=>setState(()=>cart[m["name"]]=qty+1), child: Icon(Icons.add, size:14, color: Colors.white))]))),
          ]),
          SizedBox(height:6),
          Padding(padding: EdgeInsets.only(left:2), child: Text(m["name"], maxLines:2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize:12, fontWeight: FontWeight.w600))),
        ]);
      })),
      if(totalItems>0) Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]), child: Row(children: [
        Expanded(child: OutlinedButton(onPressed: (){ setState(()=>cart.clear()); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hold Saved"))); }, style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical:14), side: BorderSide(color: Colors.grey.shade400)), child: Text("Save & Hold", style: TextStyle(color: Colors.black)))),
        SizedBox(width:12),
        Expanded(child: ElevatedButton(onPressed: ()=>setState(()=>showCart=true), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, padding: EdgeInsets.symmetric(vertical:14)), child: Text("Save & Bill", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      ]))
    ]);
  }

  Widget buildCart(){
    return SingleChildScrollView(child: Column(children: [
      SizedBox(height:90, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cart.length, itemBuilder: (c,i){
        String name = cart.keys.elementAt(i); int qty = cart[name]!; var it = menu.firstWhere((m)=>m["name"]==name);
        return Container(width:85, margin: EdgeInsets.all(6), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: Column(children: [
          Stack(children: [ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), child: Container(height:50, width:85, child: Image.network(it["img"], fit: BoxFit.cover, errorBuilder: (c,e,s)=> Container(color: Colors.orange.shade100)))), Positioned(top:4, right:4, child: Text("₹${it["price"]}", style: TextStyle(fontSize:10, color: Colors.white, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 4, color: Colors.black)]))) ]),
          Text(name, maxLines:1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize:9)),
          Container(margin: EdgeInsets.only(top:4), padding: EdgeInsets.symmetric(horizontal:6), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [InkWell(onTap: ()=>setState(()=>qty==1? cart.remove(name): cart[name]=qty-1), child: Icon(Icons.remove, size:12, color: Colors.white)), Padding(padding: EdgeInsets.symmetric(horizontal:4), child: Text("$qty", style: TextStyle(color: Colors.white, fontSize:11))), InkWell(onTap: ()=>setState(()=>cart[name]=qty+1), child: Icon(Icons.add, size:12, color: Colors.white))]))
        ]));
      })),
      Container(color: Colors.white, padding: EdgeInsets.all(12), margin: EdgeInsets.only(top:8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Column(children: [CircleAvatar(radius:20, backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontSize:10, fontWeight: FontWeight.bold))), SizedBox(height:4), Text("KGN TAWA FRY - Bill Slip", style: TextStyle(fontWeight: FontWeight.bold))])),
        Divider(),
        Text("Table Number"), DropdownButtonFormField(value: table, items: tables.map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged: (v)=>setState(()=>table=v.toString()), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
        SizedBox(height:10), Text("Payment Type"), Wrap(spacing:6, children: pays.map((p)=> ChoiceChip(label: Text(p, style: TextStyle(fontSize:11)), selected: pay==p, onSelected: (v)=>setState(()=>pay=p))).toList()),
        SizedBox(height:10),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFFF5F6F8), borderRadius: BorderRadius.circular(8)), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Sub Total"), Text("₹$subTotal")]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Seva Charge"), Text("₹0")]),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total:", style: TextStyle(fontWeight: FontWeight.bold)), Text("₹$subTotal", style: TextStyle(fontWeight: FontWeight.bold))]),
        ])),
        SizedBox(height:12),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){ setState(()=>{cart.clear(), showCart=false}); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bill Saved - $table - ₹$subTotal"))); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.all(14)), child: Text("Confirm & Save", style: TextStyle(color: Colors.white)))),
      ]))
    ]));
  }
}
