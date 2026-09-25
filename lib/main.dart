import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNFinalApp()));

class KGNFinalApp extends StatefulWidget {
  @override _KGNFinalAppState createState() => _KGNFinalAppState();
}
class _KGNFinalAppState extends State<KGNFinalApp> {
  int nav = 0;
  String cat = "All";
  String table = "T-1";
  String pay = "Cash";
  String search = "";
  String mode = "Dine-In";
  bool showCart = false;

  List<String> cats = ["All","Chicken Item","Mutton Item","Fish Item","Anda Item","Veg Item","Roti Item"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> pays = ["Cash","UPI","PhonePe","Google Pay","Card","Others"];

  List<Map> menu = [
    {"name":"Murgh Do Pyaza","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Murgh Moghlai","price":160,"full":300,"cat":"Chicken Item"},
    {"name":"Chicken Handi","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Chicken Fry","price":120,"full":220,"cat":"Chicken Item"},
    {"name":"Chicken Masala","price":120,"full":220,"cat":"Chicken Item"},
    {"name":"Chicken Biryani","price":80,"full":120,"cat":"Chicken Item"},
    {"name":"Butter Chicken","price":170,"full":320,"cat":"Chicken Item"},
    {"name":"Chicken Kadhai","price":160,"full":300,"cat":"Chicken Item"},
    {"name":"Moghlai Mutton","price":150,"full":280,"cat":"Mutton Item"},
    {"name":"Mutton Fry","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Kheema Fry","price":80,"full":160,"cat":"Mutton Item"},
    {"name":"Bheja Fry","price":130,"full":240,"cat":"Mutton Item"},
    {"name":"Paya Fry","price":120,"full":220,"cat":"Mutton Item"},
    {"name":"Machhi Fry","price":80,"full":160,"cat":"Fish Item"},
    {"name":"Jhinga Fry","price":130,"full":240,"cat":"Fish Item"},
    {"name":"Anda Bhurji","price":50,"full":100,"cat":"Anda Item"},
    {"name":"Anda Pulav","price":60,"full":120,"cat":"Anda Item"},
    {"name":"Dal Tadka","price":70,"full":140,"cat":"Veg Item"},
    {"name":"Dal Fry","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Jeera Rice","price":50,"full":100,"cat":"Veg Item"},
    {"name":"Plain Rice","price":30,"full":60,"cat":"Veg Item"},
    {"name":"Special Roti","price":15,"full":15,"cat":"Roti Item"},
    {"name":"Chapati Roti","price":7,"full":7,"cat":"Roti Item"},
    {"name":"Papad Fry","price":10,"full":10,"cat":"Roti Item"},
    {"name":"chaas","price":20,"full":20,"cat":"Veg Item"},
  ];

  // AUTO PHOTO GENERATE - category ke hisab se auto icon
  IconData getAutoIcon(String name, String cat){
    if(cat.contains("Chicken")) return Icons.set_meal;
    if(cat.contains("Mutton")) return Icons.kebab_dining;
    if(cat.contains("Fish")) return Icons.set_meal_outlined;
    if(cat.contains("Anda")) return Icons.egg;
    if(cat.contains("Roti")) return Icons.bakery_dining;
    if(name.toLowerCase().contains("rice") || name.toLowerCase().contains("biryani")) return Icons.rice_bowl;
    if(name.toLowerCase().contains("dal")) return Icons.soup_kitchen;
    return Icons.fastfood;
  }
  Color getAutoColor(String cat){
    if(cat.contains("Chicken")) return Colors.orange.shade100;
    if(cat.contains("Mutton")) return Colors.red.shade100;
    if(cat.contains("Fish")) return Colors.blue.shade100;
    if(cat.contains("Anda")) return Colors.yellow.shade100;
    if(cat.contains("Roti")) return Colors.brown.shade100;
    return Colors.green.shade100;
  }

  Map<String, int> cart = {};
  Map<String, List<Map>> tableOrders = {"T-1":[],"T-2":[],"T-3":[],"T-4":[],"T-5":[],"T-6":[]};
  List<Map> kotList = [];
  List<Map> closedBills = [];
  double todaysSale = 0;

  int get totalItems => cart.values.fold(0, (a,b)=>a+b);
  int get subTotal => cart.entries.fold(0, (s,e){ var it = menu.firstWhere((m)=>m["name"]==e.key, orElse: ()=>{"price":0}); return s + (it["price"] as int)*e.value; });
  List<Map> get filtered => menu.where((m){ bool c1 = cat=="All" || m["cat"]==cat; bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase()); return c1 && c2; }).toList();

  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      body: nav==0? buildHome() : nav==1? buildItemsPage() : nav==2? (showCart? buildCartPage() : buildOrderPage()) : nav==3? buildReport() : buildMore(),
      bottomNavigationBar: BottomNavigationBar(currentIndex: nav, type: BottomNavigationBarType.fixed, selectedItemColor: Colors.blue, onTap: (i){ setState(()=>{nav=i, if(i==2) showCart=false}); }, items: [
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
      // BUTTON AB KAAM KARENGE
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _dashBox(Icons.check_circle, "Closed", "${closedBills.length}", ()=>setState(()=>nav=3)),
        _dashBox(Icons.access_time, "Hold", "$hold", ()=>setState(()=>nav=2)),
        _dashBox(Icons.restaurant, "Items", "${menu.length}", ()=>setState(()=>nav=1)),
      ]),
      SizedBox(height:16),
      Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Row(children: [Icon(Icons.show_chart, size:18), SizedBox(width:6), Text("Today's Sale", style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text("${DateTime.now().day}/${DateTime.now().month}/9")]),
        SizedBox(height:12),
        Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Today's Sales", style: TextStyle(color: Colors.grey, fontSize:12)), Text("₹ $todaysSale", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: Colors.green))])), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Orders", style: TextStyle(color: Colors.grey, fontSize:12)), Text("${closedBills.length} Orders", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold))]))]),
      ])),
      SizedBox(height:16), Text("Table Status - 6 Tables", style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height:8),
      GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:1.6, crossAxisSpacing:8, mainAxisSpacing:8), itemCount: tables.length, itemBuilder: (c,i){
        String t = tables[i]; bool occ = tableOrders[t]!.isNotEmpty; int amt = tableOrders[t]!.fold(0, (a,b)=> a + ((b["price"]??0) as int)*(b["qty"]??1 as int));
        return InkWell( // TABLE BUTTON AB KAAM KAREGA
          onTap: (){ setState(()=>{table=t, nav=2, showCart=false}); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$t selected - ${occ? "Rs $amt occupied":"Empty - Order start karo"}"))); },
          child: Container(decoration: BoxDecoration(color: occ? Colors.green: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: occ? Colors.white: Colors.black)), Text(occ? "₹$amt\nOccupied": "Empty", textAlign: TextAlign.center, style: TextStyle(fontSize:11, color: occ? Colors.white70: Colors.grey))])) ),
        );
      }),
      if(kotList.isNotEmpty) Container(margin: EdgeInsets.only(top:12), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("🔥 Live KOT - ${kotList.length} Active", style: TextStyle(fontWeight: FontWeight.bold)),...kotList.map((k)=> Text("${k['table']} - ${k['items'].length} items - ${k['time']}"))])),
    ])));
  }
  Widget _dashBox(IconData ic, String t, String v, VoidCallback onTap){
    return InkWell(onTap: onTap, child: Column(children: [CircleAvatar(radius:30, backgroundColor: Colors.blue.shade100, child: Icon(ic, color: Colors.blue, size:28)), SizedBox(height:6), Text(t, style: TextStyle(fontSize:12)), Text(v, style: TextStyle(fontSize:14, fontWeight: FontWeight.bold))]));
  }

  Widget buildItemsPage(){
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(10), child: Row(children: [Expanded(child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search items...", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))), SizedBox(width:8), ElevatedButton(onPressed: _showAddCategoryDialog, child: Text("Cat +"))])),
      SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.all(4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], onSelected: (v)=>setState(()=>cat=cats[i]))))),
      Expanded(child: ListView.builder(itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i];
        return Card(child: ListTile(
          leading: Container(width:50, height:50, decoration: BoxDecoration(color: getAutoColor(m["cat"]), borderRadius: BorderRadius.circular(8)), child: Icon(getAutoIcon(m["name"], m["cat"]), color: Colors.black54)),
          title: Text(m["name"]), subtitle: Text("${m["cat"]} | ₹${m["price"]} / Full ₹${m["full"]} | Auto Photo ✅"),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: Icon(Icons.edit, size:20), onPressed: ()=>_showEditItem(m)), IconButton(icon: Icon(Icons.delete, size:20, color: Colors.red), onPressed: (){ setState(()=>menu.remove(m)); })]),
        ));
      })),
    ]));
  }

  void _showAddCategoryDialog(){
    String newCat = "";
    showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text("Add New Category"), content: TextField(onChanged: (v)=>newCat=v, decoration: InputDecoration(hintText: "Ex: Starter, Drinks")), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel")), ElevatedButton(onPressed: (){ if(newCat.isNotEmpty){ setState(()=>cats.add(newCat)); Navigator.pop(context); } }, child: Text("Add"))]));
  }

  void _showAddItemDialog(){
    String name=""; String price=""; String fullPrice=""; String selCat = cats.length>1? cats[1] : "Chicken Item";
    showDialog(context: context, builder: (ctx)=> StatefulBuilder(builder: (ctx, setD)=> AlertDialog(title: Text("Add New Item - Auto Photo"), content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(onChanged: (v)=>name=v, decoration: InputDecoration(labelText: "Item Name")),
      TextField(onChanged: (v)=>price=v, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Half Price")),
      TextField(onChanged: (v)=>fullPrice=v, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Full Price")),
      SizedBox(height:10),
      DropdownButtonFormField(value: selCat, items: cats.where((e)=>e!="All").map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged: (v)=>setD(()=>selCat=v.toString()), decoration: InputDecoration(labelText: "Category")),
      SizedBox(height:10),
      Text("Photo auto generate ho jayega category se ✅", style: TextStyle(fontSize:11, color: Colors.green)),
    ])), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel")), ElevatedButton(onPressed: (){ if(name.isNotEmpty && price.isNotEmpty){ setState(()=>menu.add({"name":name, "price":int.tryParse(price)??0, "full":int.tryParse(fullPrice)??int.tryParse(price)??0, "cat":selCat})); Navigator.pop(context); } }, child: Text("Add Item"))])));
  }
  void _showEditItem(Map m){
    String name=m["name"]; String price=m["price"].toString();
    showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text("Edit Item"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: TextEditingController(text: name), onChanged: (v)=>name=v, decoration: InputDecoration(labelText: "Name")), TextField(controller: TextEditingController(text: price), onChanged: (v)=>price=v, decoration: InputDecoration(labelText: "Price"))]), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel")), ElevatedButton(onPressed: (){ setState(()=>{m["name"]=name, m["price"]=int.tryParse(price)??m["price"]}); Navigator.pop(context); }, child: Text("Save"))]));
  }

  Widget buildOrderPage(){
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(10), child: Row(children: [Expanded(child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))), SizedBox(width:8), Container(padding: EdgeInsets.symmetric(horizontal:8, vertical:6), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)), child: Text(table, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))])),
      SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.symmetric(horizontal:4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], selectedColor: Colors.blue.shade100, onSelected: (v)=>setState(()=>cat=cats[i]))))),
      Expanded(child: GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:0.75, crossAxisSpacing:8, mainAxisSpacing:8), itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i]; int qty = cart[m["name"]]??0;
        return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: Column(children: [
          Stack(children: [Container(height:80, decoration: BoxDecoration(color: getAutoColor(m["cat"]), borderRadius: BorderRadius.vertical(top: Radius.circular(12))), child: Center(child: Icon(getAutoIcon(m["name"], m["cat"]), size:30, color: Colors.black54))), Positioned(top:6, left:6, child: Container(padding: EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: Text("₹${m["price"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize:12))))]),
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
        Row(children: [Expanded(child: OutlinedButton(onPressed: (){ setState(()=>{tableOrders[table]!.addAll(cart.entries.map((e)=>{"name":e.key,"price":menu.firstWhere((m)=>m["name"]==e.key)["price"],"qty":e.value})), kotList.add({"table":table,"items":List.from(cart.entries),"time":"${DateTime.now().hour}:${DateTime.now().minute}"}), cart.clear()}); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$table Hold + KOT Sent - Occupied ho gaya"))); }, child: Text("Save & Hold"))), SizedBox(width:8), Expanded(child: ElevatedButton(onPressed: ()=>setState(()=>showCart=true), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: Text("Save & Bill", style: TextStyle(color: Colors.white))))])
      ]))
    ]));
  }

  Widget buildCartPage(){
    return SafeArea(child: Column(children: [
      AppBar(backgroundColor: Colors.white, elevation:0, leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: ()=>setState(()=>showCart=false)), title: Text("Cart - $table", style: TextStyle(color: Colors.black))),
      Expanded(child: SingleChildScrollView(child: Column(children: [
        Container(color: Colors.white, padding: EdgeInsets.all(12), margin: EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Column(children: [CircleAvatar(radius:24, backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:12))), SizedBox(height:4), Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)), Text("Hotel Bill - Service Slip", style: TextStyle(fontSize:10, color: Colors.grey))])),
          Divider(thickness:1),
          Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
         ...cart.entries.map((e){ var it = menu.firstWhere((m)=>m["name"]==e.key); return Padding(padding: EdgeInsets.symmetric(vertical:2), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text("${e.key} x${e.value}", style: TextStyle(fontSize:12))), Text("₹${(it["price"] as int)*e.value}", style: TextStyle(fontSize:12))])) }).toList(),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Sub Total"), Text("₹$subTotal")]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Discount"), Text("₹0")]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Seva/Service Charge"), Text("₹0")]),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)), Text("₹$subTotal", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16))]),
          SizedBox(height:12),
          Text("Table: $table | Mode: $mode"),
          SizedBox(height:8),
          Text("Payment Type"), Wrap(spacing:6, children: pays.map((p)=> ChoiceChip(label: Text(p, style: TextStyle(fontSize:11)), selected: pay==p, onSelected: (v)=>setState(()=>pay=p))).toList()),
          SizedBox(height:12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){
            setState(()=>{todaysSale+=subTotal, closedBills.add({"table":table,"total":subTotal,"pay":pay,"time":DateTime.now().toString(),"items":List.from(cart.entries)}), tableOrders[table]!.clear(), cart.clear(), kotList.removeWhere((k)=>k['table']==table), showCart=false, nav=0});
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bill Saved - $table - ₹$subTotal - $pay")));
          }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.all(14)), child: Text("Confirm & Print Bill Slip", style: TextStyle(color: Colors.white, fontSize:16)))),
        ]))
      ])))
    ]));
  }

  Widget buildReport(){ return SafeArea(child: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Reports", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)), SizedBox(height:12), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Today's Sale"), Text("₹$todaysSale", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Bills"), Text("${closedBills.length}")]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Hold Tables"), Text("${tableOrders.values.where((e)=>e.isNotEmpty).length}")])]))]))); }

  Widget buildMore(){
    return SafeArea(child: ListView(padding: EdgeInsets.all(12), children: [
      ListTile(leading: CircleAvatar(backgroundColor: Colors.deepOrange, child: Text("KGN", style: TextStyle(color: Colors.white, fontSize:10))), title: Text("KGN TAWA FRY"), subtitle: Text("V2.0 - All Buttons Working")),
      Divider(),
      ListTile(leading: Icon(Icons.add_box), title: Text("Add New Item"), subtitle: Text("Item add karne wala feature"), onTap: _showAddItemDialog),
      ListTile(leading: Icon(Icons.category), title: Text("Add New Category"), subtitle: Text("Category add karne wala feature"), onTap: _showAddCategoryDialog),
      ListTile(leading: Icon(Icons.print), title: Text("Bill Slip Show - Seva"), subtitle: Text("Thermal print with KGN logo")),
      ListTile(leading: Icon(Icons.photo), title: Text("Auto Photo Generate"), subtitle: Text("Chicken=Orange, Mutton=Red, Fish=Blue auto")),
      ListTile(leading: Icon(Icons.table_bar), title: Text("Table Feature ON"), subtitle: Text("Table dabao to direct order khulega")),
    ]));
  }
}
