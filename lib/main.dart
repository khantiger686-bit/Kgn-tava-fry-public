import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNFinalApp()));

class KGNFinalApp extends StatefulWidget {
  @override _KGNFinalAppState createState() => _KGNFinalAppState();
}

class _KGNFinalAppState extends State<KGNFinalApp> {
  int nav = 2;
  String cat = "All";
  String table = "T-1";
  String pay = "Cash";
  String search = "";
  String mode = "Dine-In";
  bool showCart = false;

  List<String> cats = ["All","Chicken Item","Mutton Item","Fish Item","Anda Item","Veg Item","Roti Item"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> pays = ["Cash","UPI","PhonePe","Google Pay","Card","Others"];

  // 59 ITEMS FULL MENU
  List<Map> menu = [
    {"name":"Murgh Do Pyaza","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Murgh Moghlai","price":160,"full":300,"cat":"Chicken Item"},
    {"name":"Chicken Handi","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Chicken Pisawar","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Murgh Shahi","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Malai Tikka","price":180,"full":350,"cat":"Chicken Item"},
    {"name":"Tikka Masala","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Chicken Kadhai","price":160,"full":300,"cat":"Chicken Item"},
    {"name":"Chicken Garlic","price":160,"full":300,"cat":"Chicken Item"},
    {"name":"Chicken India","price":250,"full":450,"cat":"Chicken Item"},
    {"name":"Butter Chicken Boneless","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"White Chicken","price":180,"full":350,"cat":"Chicken Item"},
    {"name":"Green Chicken","price":180,"full":350,"cat":"Chicken Item"},
    {"name":"Chicken Fry","price":120,"full":220,"cat":"Chicken Item"},
    {"name":"Chicken Masala","price":120,"full":220,"cat":"Chicken Item"},
    {"name":"Chicken Biryani","price":80,"full":120,"cat":"Chicken Item"},
    {"name":"Tandoori Masala","price":250,"full":480,"cat":"Chicken Item"},
    {"name":"Amdavadi","price":160,"full":300,"cat":"Chicken Item"},
    {"name":"Tikka Rice","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Moghlai Mutton","price":150,"full":280,"cat":"Mutton Item"},
    {"name":"DalBati Gos","price":150,"full":280,"cat":"Mutton Item"},
    {"name":"White Mutton","price":160,"full":300,"cat":"Mutton Item"},
    {"name":"Green Mutton","price":150,"full":280,"cat":"Mutton Item"},
    {"name":"Mutton Kurma","price":160,"full":300,"cat":"Mutton Item"},
    {"name":"Mutton Fry","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Mutton Masala","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Kaleji Masala","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Bhaji Gos","price":130,"full":240,"cat":"Mutton Item"},
    {"name":"Paya Fry","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Champ Fry","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Bheja Fry","price":130,"full":240,"cat":"Mutton Item"},
    {"name":"Boti Masala","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Kheema Fry","price":80,"full":160,"cat":"Mutton Item"},
    {"name":"Kheema Pulav","price":100,"full":180,"cat":"Mutton Item"},
    {"name":"Machhi Fry","price":80,"full":160,"cat":"Fish Item"},
    {"name":"Machhi Kadhi","price":100,"full":200,"cat":"Fish Item"},
    {"name":"Jhinga Fry","price":130,"full":240,"cat":"Fish Item"},
    {"name":"Jhinga Rice","price":170,"full":320,"cat":"Fish Item"},
    {"name":"Anda Kadhi","price":80,"full":160,"cat":"Anda Item"},
    {"name":"Anda Kheema","price":80,"full":160,"cat":"Anda Item"},
    {"name":"Anda Bhurji","price":50,"full":100,"cat":"Anda Item"},
    {"name":"Anda Pulav","price":60,"full":120,"cat":"Anda Item"},
    {"name":"Dal Tadka","price":70,"full":140,"cat":"Veg Item"},
    {"name":"Dal Gotala","price":80,"full":160,"cat":"Veg Item"},
    {"name":"Butter Dal Fry","price":70,"full":140,"cat":"Veg Item"},
    {"name":"Dal Fry","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Sabji Fry","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Sev Tameta","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Masala Rice","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Biryani Rice","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Jeera Rice","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Kadhi Khichdi","price":30,"full":60,"cat":"Veg Item"},
    {"name":"Dal Pulav","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Plain Rice","price":30,"full":60,"cat":"Veg Item"},
    {"name":"Special Roti","price":15,"full":15,"cat":"Roti Item"},
    {"name":"Special Paratha","price":20,"full":20,"cat":"Roti Item"},
    {"name":"Butter Roti","price":15,"full":15,"cat":"Roti Item"},
    {"name":"Chapati Roti","price":7,"full":7,"cat":"Roti Item"},
    {"name":"Papad Fry","price":10,"full":10,"cat":"Roti Item"},
  ];

  Map<String, String> itemPhotos = {};
  Map<String, int> cart = {};
  Map<String, List<Map>> tableOrders = {"T-1":[],"T-2":[],"T-3":[],"T-4":[],"T-5":[],"T-6":[]};
  List<Map> kotList = [];
  double todaysSale = 0;
  int closedBills = 0;

  int get totalItems => cart.values.fold(0, (a,b)=>a+b);
  int get subTotal => cart.entries.fold(0, (s,e){ var it = menu.firstWhere((m)=>m["name"]==e.key, orElse: ()=>{"price":0}); return s + (it["price"] as int)*e.value; });
  List<Map> get filtered => menu.where((m){ bool c1 = cat=="All" || m["cat"]==cat; bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase()); return c1 && c2; }).toList();

  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      body: nav==0? buildHome() : nav==1? buildItemsPage() : nav==2? (showCart? buildCartPage() : buildOrderPage()) : nav==3? buildReport() : buildMore(),
      bottomNavigationBar: BottomNavigationBar(currentIndex: nav, type: BottomNavigationBarType.fixed, selectedItemColor: Colors.blue, onTap: (i){ setState(()=>nav=i); if(i==2) showCart=false; }, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Items"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 38, color: Colors.blue), label: "Order"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
      ]),
    );
  }

  Widget buildHome(){
    int hold = tableOrders.values.where((e)=>e.isNotEmpty).length;
    return SafeArea(child: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [CircleAvatar(backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontSize:10, fontWeight: FontWeight.bold))), SizedBox(width:8), Text("KGN TAWA FRY", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
      SizedBox(height:12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_dashBox(Icons.check_circle, "Closed", "$closedBills"), _dashBox(Icons.access_time, "Hold", "$hold"), _dashBox(Icons.restaurant, "Items", "59")]),
      SizedBox(height:16),
      Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Row(children: [Icon(Icons.show_chart, size:18), SizedBox(width:6), Text("Today's Sale", style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text("${DateTime.now().day}/${DateTime.now().month}")]),
        SizedBox(height:12),
        Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Today's Sales", style: TextStyle(color: Colors.grey, fontSize:12)), Text("₹ $todaysSale", style: TextStyle(fontSize:22, fontWeight: FontWeight.bold, color: Colors.green))])), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Orders", style: TextStyle(color: Colors.grey, fontSize:12)), Text("$closedBills Orders", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold))]))]),
      ])),
      SizedBox(height:16), Text("Table Status - 6 Tables", style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height:8),
      GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:1.6, crossAxisSpacing:8, mainAxisSpacing:8), itemCount: tables.length, itemBuilder: (c,i){ String t = tables[i]; bool occ = tableOrders[t]!.isNotEmpty; return Container(decoration: BoxDecoration(color: occ? Colors.green: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: occ? Colors.white: Colors.black)), Text(occ? "Occupied": "Empty", style: TextStyle(fontSize:11, color: occ? Colors.white70: Colors.grey))])) ); }),
    ])));
  }
  Widget _dashBox(IconData ic, String t, String v){ return Column(children: [CircleAvatar(radius:28, backgroundColor: Colors.blue.shade100, child: Icon(ic, color: Colors.blue)), SizedBox(height:4), Text(t, style: TextStyle(fontSize:11)), Text(v, style: TextStyle(fontSize:12, fontWeight: FontWeight.bold))]); }

  Widget buildItemsPage(){
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(10), child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search 59 items...", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
      SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.all(4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], onSelected: (v)=>setState(()=>cat=cats[i]))))),
      Expanded(child: ListView.builder(itemCount: filtered.length, itemBuilder: (c,i){ var m = filtered[i]; bool hasPhoto = itemPhotos.containsKey(m["name"]); return Card(child: ListTile(leading: CircleAvatar(backgroundColor: hasPhoto? Colors.green.shade100: Colors.orange.shade100, child: Icon(hasPhoto? Icons.photo: Icons.fastfood, color: hasPhoto? Colors.green: Colors.orange)), title: Text(m["name"]), subtitle: Text("${m["cat"]} | ₹${m["price"]} / Full ₹${m["full"]}"), trailing: IconButton(icon: Icon(Icons.camera_alt), onPressed: (){ showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text("Photo Upload"), content: Text("${m["name"]} ki asli photo add kare?"), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel")), ElevatedButton(onPressed: (){ setState(()=> itemPhotos[m["name"]] = "added"); Navigator.pop(context); }, child: Text("Add Photo"))])); }))); })),
    ]));
  }

  Widget buildOrderPage(){
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(10), child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
      SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.symmetric(horizontal:4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], selectedColor: Colors.blue.shade100, onSelected: (v)=>setState(()=>cat=cats[i]))))),
      Expanded(child: GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:0.72, crossAxisSpacing:8, mainAxisSpacing:8), itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i]; int qty = cart[m["name"]]??0; bool hasPhoto = itemPhotos.containsKey(m["name"]);
        return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Stack(children: [Container(height:85, decoration: BoxDecoration(color: hasPhoto? Colors.green.shade100: Colors.orange.shade100, borderRadius: BorderRadius.vertical(top: Radius.circular(12))), child: Center(child: Icon(hasPhoto? Icons.check_circle: Icons.fastfood, color: hasPhoto? Colors.green: Colors.orange))), Positioned(top:6, left:6, child: Container(padding: EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: Text("₹${m["price"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize:12))))]),
          Padding(padding: EdgeInsets.all(4), child: Text(m["name"], maxLines:2, textAlign: TextAlign.center, style: TextStyle(fontSize:11, fontWeight: FontWeight.bold))),
          Spacer(),
          qty==0? ElevatedButton(onPressed: ()=>setState(()=>cart[m["name"]]=1), style: ElevatedButton.styleFrom(minimumSize: Size(60,26), backgroundColor: Colors.white, side: BorderSide(color: Colors.blue)), child: Icon(Icons.add, size:16, color: Colors.blue))
          : Container(margin: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [InkWell(onTap: ()=>setState(()=>qty==1? cart.remove(m["name"]): cart[m["name"]]=qty-1), child: Padding(padding: EdgeInsets.all(6), child: Icon(Icons.remove, size:14, color: Colors.white))), Text("$qty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), InkWell(onTap: ()=>setState(()=>cart[m["name"]]=qty+1), child: Padding(padding: EdgeInsets.all(6), child: Icon(Icons.add, size:14, color: Colors.white)))])),
          SizedBox(height:4),
        ]));
      })),
      if(totalItems>0) Container(color: Colors.white, padding: EdgeInsets.all(12), child: Column(children: [
        InkWell(onTap: ()=>setState(()=>showCart=true), child: Row(children: [Text("View Cart >", style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text("$totalItems Items ₹$subTotal", style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(width:8), Icon(Icons.receipt_long)])),
        SizedBox(height:8),
        Row(children: [Expanded(child: OutlinedButton(onPressed: (){ setState(()=>{tableOrders[table]!.addAll(cart.entries.map((e)=>{"name":e.key,"qty":e.value})), kotList.add({"table":table,"items":List.from(cart.entries)}), cart.clear()}); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$table Hold + KOT Sent"))); }, child: Text("Save & Hold"))), SizedBox(width:8), Expanded(child: ElevatedButton(onPressed: ()=>setState(()=>showCart=true), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: Text("Save & Bill", style: TextStyle(color: Colors.white))))])
      ]))
    ]));
  }

  Widget buildCartPage(){
    return SafeArea(child: Column(children: [
      AppBar(backgroundColor: Colors.white, elevation:0, leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: ()=>setState(()=>showCart=false)), title: Text("Cart", style: TextStyle(color: Colors.black))),
      Expanded(child: SingleChildScrollView(child: Column(children: [
        SizedBox(height:90, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cart.length, itemBuilder: (c,i){ String name = cart.keys.elementAt(i); int qty = cart[name]!; return Container(width:85, margin: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [Container(height:45, decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.vertical(top: Radius.circular(12)))), Text(name, maxLines:1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize:9)), Container(margin: EdgeInsets.only(top:4), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [InkWell(onTap: ()=>setState(()=>qty==1? cart.remove(name): cart[name]=qty-1), child: Icon(Icons.remove, size:14, color: Colors.white)), Padding(padding: EdgeInsets.symmetric(horizontal:4), child: Text("$qty", style: TextStyle(color: Colors.white, fontSize:11))), InkWell(onTap: ()=>setState(()=>cart[name]=qty+1), child: Icon(Icons.add, size:14, color: Colors.white))]))])); })),
        Container(color: Colors.white, padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // KGN LOGO ON BILL
          Center(child: Column(children: [CircleAvatar(radius:22, backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:12))), SizedBox(height:4), Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)), Text("Smart Restaurant Billing", style: TextStyle(fontSize:10, color: Colors.grey))])),
          Divider(),
          Row(children: [Text("Customer Details"), Spacer(), TextButton(onPressed: (){}, child: Text("ADD"))]),
          Row(children: [ChoiceChip(label: Text("Dine-In"), selected: mode=="Dine-In", onSelected: (v)=>setState(()=>mode="Dine-In")), SizedBox(width:6), ChoiceChip(label: Text("Takeaway"), selected: mode=="Takeaway", onSelected: (v)=>setState(()=>mode="Takeaway")), SizedBox(width:6), ChoiceChip(label: Text("Delivery"), selected: mode=="Delivery", onSelected: (v)=>setState(()=>mode="Delivery"))]),
          SizedBox(height:10), Text("Table Number"), DropdownButtonFormField(value: table, items: tables.map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged: (v)=>setState(()=>table=v.toString()), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
          SizedBox(height:10), Text("Payment Type"), Wrap(spacing:6, children: pays.map((p)=> ChoiceChip(label: Text(p, style: TextStyle(fontSize:11)), selected: pay==p, onSelected: (v)=>setState(()=>pay=p))).toList()),
          SizedBox(height:10),
          Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFFF5F6F8), borderRadius: BorderRadius.circular(8)), child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Sub Total"), Text("₹$subTotal")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Discount"), TextButton(onPressed: (){}, child: Text("ADD"))]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Effective Discount"), Text("₹0")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Taxes"), Text("₹0")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Service Charge"), TextButton(onPressed: (){}, child: Text("ADD"))]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Amount:", style: TextStyle(fontWeight: FontWeight.bold)), Text("₹$subTotal", style: TextStyle(fontWeight: FontWeight.bold))]),
          ])),
          SizedBox(height:12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){
            setState(()=>{todaysSale+=subTotal, closedBills++, tableOrders[table]!.clear(), cart.clear(), kotList.removeWhere((k)=>k['table']==table), showCart=false, nav=0});
            // PRINT BILL WITH LOGO
            showDialog(context: context, builder: (ctx)=> AlertDialog(title: Column(children: [CircleAvatar(backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontSize:10))), Text("KGN TAWA FRY - BILL", style: TextStyle(fontSize:14))]), content: Column(mainAxisSize: MainAxisSize.min, children: [Text("Table: $table | $pay"), Divider(), Text("Total Paid: ₹$subTotal", style: TextStyle(fontWeight: FontWeight.bold, fontSize:18)), SizedBox(height:8), Text("Thank you! Visit Again", style: TextStyle(fontSize:12))]), actions: [ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("Print + Close"))]));
          }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.all(14)), child: Text("Confirm & Save - Print Bill", style: TextStyle(color: Colors.white, fontSize:16)))),
        ]))
      ])))
    ]));
  }

  Widget buildReport(){ return SafeArea(child: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Reports", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)), SizedBox(height:12), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Today's Sale"), Text("₹$todaysSale", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Bills"), Text("$closedBills")])]))]))); }
  Widget buildMore(){ return SafeArea(child: ListView(padding: EdgeInsets.all(12), children: [ListTile(leading: CircleAvatar(backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontSize:10))), title: Text("KGN TAWA FRY"), subtitle: Text("V1.0 FINAL - 59 Items + Photo + Dashboard")), Divider(), ListTile(leading: Icon(Icons.print), title: Text("Bill Print with Logo"), subtitle: Text("Thermal Printer - Bluetooth/WiFi/USB")), ListTile(leading: Icon(Icons.camera_alt), title: Text("Photo Upload Done"), subtitle: Text("${itemPhotos.length}/${menu.length} photos")), ListTile(leading: Icon(Icons.table_bar), title: Text("Table Management"), subtitle: Text("6 Tables"))])); }
}
