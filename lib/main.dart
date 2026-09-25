import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNMasterApp()));

class KGNMasterApp extends StatefulWidget {
  const KGNMasterApp({super.key});
  @override State<KGNMasterApp> createState() => _KGNMasterAppState();
}

class _KGNMasterAppState extends State<KGNMasterApp> {
  int navIndex = 0;
  String selectedCat = "All";
  String orderMode = "Dine-In";
  String selectedTable = "T-1";
  String paymentType = "Cash";
  String searchQ = "";

  List<String> cats = ["All","Chicken Item","Mutton Item","Fish Item","Anda Item","Veg Item","Roti Item"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> payTypes = ["Cash","UPI","PhonePe","Google Pay","Card","Others"];

  List<Map> menu = [
    {"name": "Murgh Do Pyaza", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Murgh Moghlai", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken Handi", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Chicken Pisawar", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Murgh Shahi", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Malai Tikka", "half": 180, "full": 350, "cat": "Chicken Item"},
    {"name": "Tikka Masala", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Chicken Kadhai", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken Garlic", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken India", "half": 250, "full": 450, "cat": "Chicken Item"},
    {"name": "Butter Chicken", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "White Chicken", "half": 180, "full": 350, "cat": "Chicken Item"},
    {"name": "Green Chicken", "half": 180, "full": 350, "cat": "Chicken Item"},
    {"name": "Chicken Fry", "half": 120, "full": 220, "cat": "Chicken Item"},
    {"name": "Chicken Masala", "half": 120, "full": 220, "cat": "Chicken Item"},
    {"name": "Chicken Biryani", "half": 80, "full": 120, "cat": "Chicken Item"},
    {"name": "Tandoori Masala", "half": 250, "full": 480, "cat": "Chicken Item"},
    {"name": "Amdavadi Masala", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Tikka Rice", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Moghlai Mutton", "half": 150, "full": 280, "cat": "Mutton Item"},
    {"name": "DalBati Gos", "half": 150, "full": 280, "cat": "Mutton Item"},
    {"name": "White Mutton", "half": 160, "full": 300, "cat": "Mutton Item"},
    {"name": "Green Mutton", "half": 150, "full": 280, "cat": "Mutton Item"},
    {"name": "Mutton Kurma", "half": 160, "full": 300, "cat": "Mutton Item"},
    {"name": "Mutton Fry", "half": 120, "full": 220, "cat": "Mutton Item"},
    {"name": "Mutton Masala", "half": 120, "full": 220, "cat": "Mutton Item"},
    {"name": "Kaleji Masala", "half": 120, "full": 220, "cat": "Mutton Item"},
    {"name": "Bhaji Gos", "half": 130, "full": 240, "cat": "Mutton Item"},
    {"name": "Paya Fry", "half": 120, "full": 220, "cat": "Mutton Item"},
    {"name": "Champ Fry", "half": 120, "full": 220, "cat": "Mutton Item"},
    {"name": "Bheja Fry", "half": 130, "full": 240, "cat": "Mutton Item"},
    {"name": "Boti Masala", "half": 120, "full": 220, "cat": "Mutton Item"},
    {"name": "Kheema Fry", "half": 80, "full": 160, "cat": "Mutton Item"},
    {"name": "Kheema Pulav", "half": 100, "full": 180, "cat": "Mutton Item"},
    {"name": "Machhi Fry", "half": 80, "full": 160, "cat": "Fish Item"},
    {"name": "Machhi Kadhi", "half": 100, "full": 200, "cat": "Fish Item"},
    {"name": "Jhinga Fry", "half": 130, "full": 240, "cat": "Fish Item"},
    {"name": "Jhinga Rice", "half": 170, "full": 320, "cat": "Fish Item"},
    {"name": "Anda Kadhi", "half": 80, "full": 160, "cat": "Anda Item"},
    {"name": "Anda Kheema", "half": 80, "full": 160, "cat": "Anda Item"},
    {"name": "Anda Bhurji", "half": 50, "full": 100, "cat": "Anda Item"},
    {"name": "Anda Pulav", "half": 60, "full": 120, "cat": "Anda Item"},
    {"name": "Dal Tadka", "half": 70, "full": 140, "cat": "Veg Item"},
    {"name": "Dal Gotala", "half": 80, "full": 160, "cat": "Veg Item"},
    {"name": "Butter Dal Fry", "half": 70, "full": 140, "cat": "Veg Item"},
    {"name": "Dal Fry", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Sabji Fry", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Sev Tameta", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Masala Rice", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Biryani Rice", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Jeera Rice", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Kadhi Khichdi", "half": 30, "full": 60, "cat": "Veg Item"},
    {"name": "Dal Pulav", "half": 50, "full": 100, "cat": "Veg Item"},
    {"name": "Plain Rice", "half": 30, "full": 60, "cat": "Veg Item"},
    {"name": "Special Roti", "half": 15, "full": 15, "cat": "Roti Item"},
    {"name": "Special Paratha", "half": 20, "full": 20, "cat": "Roti Item"},
    {"name": "Butter Roti", "half": 15, "full": 15, "cat": "Roti Item"},
    {"name": "Chapati Roti", "half": 7, "full": 7, "cat": "Roti Item"},
    {"name": "Papad Fry", "half": 10, "full": 10, "cat": "Roti Item"},
  ];

  Map<String, List<Map>> tableOrders = {"T-1": [], "T-2": [], "T-3": [], "T-4": [], "T-5": [], "T-6": []};
  List<Map> kotList = [];
  List<Map> closedBills = [];
  double todaysSale = 0;

  List<Map> get currentOrder => tableOrders[selectedTable]!;
  int get totalItems => currentOrder.fold(0, (s, e) => s + (e['qty'] as int));
  int get subTotal => currentOrder.fold(0, (s, e) => s + ((e['price'] as int) * (e['qty'] as int)));
  List<Map> get filtered {
    return menu.where((m) {
      bool catOk = selectedCat == "All" || m['cat'] == selectedCat;
      bool searchOk = m['name'].toString().toLowerCase().contains(searchQ.toLowerCase());
      return catOk && searchOk;
    }).toList();
  }

  void addToCart(Map item, bool isFull){
    setState(() {
      String name = "${item['name']} ${isFull? '(F)' : '(H)'}";
      int price = isFull? item['full'] : item['half'];
      int idx = currentOrder.indexWhere((e) => e['name'] == name);
      if(idx >= 0) { currentOrder[idx]['qty']++; }
      else { currentOrder.add({"name": name, "price": price, "qty": 1, "cat": item['cat']}); }
    });
  }

  Widget quickBtn(IconData ic, String label, String count){
    return Column(children: [
      CircleAvatar(radius: 28, backgroundColor: Colors.blue.shade100, child: Icon(ic, color: Colors.blue)),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11)),
      Text(count, style: TextStyle(fontSize: 10, color: Colors.grey))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      body: navIndex==0? buildHome() : navIndex==1? buildItems() : navIndex==2? buildOrderPage() : navIndex==3? buildReports() : buildMore(),
      bottomNavigationBar: BottomNavigationBar(currentIndex: navIndex, type: BottomNavigationBarType.fixed, selectedItemColor: Colors.blue, onTap: (i)=>setState(()=>navIndex=i), items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Items"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40, color: Colors.blue), label: "Order"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
      ]),
    );
  }

  Widget buildHome(){
    int holdCount = tableOrders.values.where((e) => e.isNotEmpty).length;
    return SafeArea(child: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Icon(Icons.keyboard_arrow_down), Spacer(), CircleAvatar(backgroundColor: Colors.blue.shade100, child: Text("K"))]),
      SizedBox(height: 16),
      Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        quickBtn(Icons.check_circle, "Closed Orders", "${closedBills.length}"),
        quickBtn(Icons.access_time, "On Hold Orders", "$holdCount"),
        quickBtn(Icons.add_circle, "Add Items", "${menu.length}"),
      ]),
      SizedBox(height: 16),
      Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Row(children: [Icon(Icons.store, size: 16), SizedBox(width: 6), Text("Business Overview", style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text("${DateTime.now().day}/${DateTime.now().month}", style: TextStyle(fontSize: 12))]),
        SizedBox(height: 12),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Today's sales", style: TextStyle(color: Colors.grey)),
            Text("Rs $todaysSale", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)),
          ])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Today's orders", style: TextStyle(color: Colors.grey)),
            Text("${closedBills.length}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ])),
        ]),
        SizedBox(height: 8),
        InkWell(onTap: ()=>setState(()=>navIndex=3), child: Row(children: [Text("Top selling items & more insights!", style: TextStyle(color: Colors.blue, fontSize: 12)), Spacer(), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.blue)]))
      ])),
      SizedBox(height: 16),
      Text("Table Status - 6 Tables", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      GridView.builder(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.5, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: tables.length, itemBuilder: (c,i){
        String t = tables[i];
        bool occupied = tableOrders[t]!.isNotEmpty;
        int tableTotal = tableOrders[t]!.fold(0, (s,e)=> s + (e['price'] as int)*(e['qty'] as int));
        return Container(decoration: BoxDecoration(color: occupied? Colors.green : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: occupied? Colors.white : Colors.black)), Text(occupied? "Rs $tableTotal" : "Empty", style: TextStyle(fontSize: 10, color: occupied? Colors.white : Colors.grey)), Text(occupied? "${tableOrders[t]!.length} items" : "Tap to order", style: TextStyle(fontSize: 9, color: occupied? Colors.white70 : Colors.grey))]));
      }),
      if(kotList.isNotEmpty) Container(margin: EdgeInsets.only(top: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Live KOT - Kitchen", style: TextStyle(fontWeight: FontWeight.bold)),...kotList.take(3).map((k) => Text("${k['table']} - ${k['items'].length} items - ${k['time']}"))])),
    ])));
  }

  Widget buildItems(){
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(10), child: TextField(onChanged: (v)=>setState(()=>searchQ=v), decoration: InputDecoration(hintText: "Search items", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
      SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i) => Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(cats[i]), selected: selectedCat==cats[i], onSelected: (v)=>setState(()=>selectedCat=cats[i]))))),
      Expanded(child: ListView.builder(itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i];
        return Card(child: ListTile(leading: CircleAvatar(child: Text("${m['full']}")), title: Text(m['name']), subtitle: Text("${m['cat']} | H: Rs${m['half']} F: Rs${m['full']}"), trailing: Icon(Icons.edit)));
      }))
    ]));
  }

  Widget buildOrderPage(){
    return SafeArea(child: Column(children: [
      Container(height: 60, color: Colors.white, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: tables.length, itemBuilder: (c,i){
        String t = tables[i];
        bool sel = t==selectedTable;
        bool occ = tableOrders[t]!.isNotEmpty;
        int tableTotal = tableOrders[t]!.fold(0, (s,e)=> s + (e['price'] as int)*(e['qty'] as int));
        return GestureDetector(onTap: ()=>setState(()=>selectedTable=t), child: Container(width: 70, margin: EdgeInsets.all(6), decoration: BoxDecoration(color: sel? Colors.blue : occ? Colors.green : Colors.grey.shade200, borderRadius: BorderRadius.circular(8)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: sel||occ? Colors.white : Colors.black)), Text(occ? "Rs $tableTotal" : "Empty", style: TextStyle(fontSize: 10, color: sel||occ? Colors.white : Colors.black))])));
      })),
      Padding(padding: EdgeInsets.all(8), child: TextField(onChanged: (v)=>setState(()=>searchQ=v), decoration: InputDecoration(hintText: "Search", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
      SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i) => Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(cats[i]), selected: selectedCat==cats[i], selectedColor: Colors.blue.shade100, onSelected: (v)=>setState(()=>selectedCat=cats[i]))))),
      Expanded(child: GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.72, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i];
        String nameF = "${m['name']} (F)";
        String nameH = "${m['name']} (H)";
        int qtyF = currentOrder.where((e) => e['name']==nameF).fold(0, (s,e)=> s+ (e['qty'] as int));
        int qtyH = currentOrder.where((e) => e['name']==nameH).fold(0, (s,e)=> s+ (e['qty'] as int));
        return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Stack(children: [Container(height: 70, decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.vertical(top: Radius.circular(12)))), Positioned(top: 4, left: 4, child: Container(padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)), child: Text("F ${m['full']}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))))]),
          Padding(padding: EdgeInsets.all(4), child: Text(m['name'], maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
          Spacer(),
          Row(children: [
            Expanded(child: InkWell(onTap: ()=>addToCart(m,false), child: Container(margin: EdgeInsets.all(2), padding: EdgeInsets.all(4), decoration: BoxDecoration(color: qtyH>0? Colors.orange : Colors.white, border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(6)), child: Column(children: [Text("H ${m['half']}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: qtyH>0? Colors.white : Colors.orange)), if(qtyH>0) Text("x$qtyH", style: TextStyle(fontSize: 10, color: Colors.white))])))),
            Expanded(child: InkWell(onTap: ()=>addToCart(m,true), child: Container(margin: EdgeInsets.all(2), padding: EdgeInsets.all(4), decoration: BoxDecoration(color: qtyF>0? Colors.green : Colors.white, border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(6)), child: Column(children: [Text("F ${m['full']}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: qtyF>0? Colors.white : Colors.green)), if(qtyF>0) Text("x$qtyF", style: TextStyle(fontSize: 10, color: Colors.white))])))),
          ])
        ]));
      })),
      if(totalItems>0) Container(color: Colors.white, padding: EdgeInsets.all(12), child: Column(children: [
        Row(children: [Text("$totalItems Items", style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.arrow_forward_ios, size: 12), Spacer(), Text("Rs $subTotal", style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.receipt_long)]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: (){
            setState((){ kotList.add({"table": selectedTable, "items": List.from(currentOrder), "time": "${DateTime.now().hour}:${DateTime.now().minute}", "mode": orderMode}); });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$selectedTable Hold + KOT Sent")));
          }, child: Text("Save & Hold (KOT)"))),
          SizedBox(width: 8),
          Expanded(child: ElevatedButton(onPressed: ()=>showBillDialog(), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: Text("Save & Bill", style: TextStyle(color: Colors.white)))),
        ])
      ]))
    ]));
  }

  Widget buildReports(){
    int cashTotal = closedBills.where((b) => b['pay']== 'Cash').fold(0, (s,e)=> s + (e['total'] as int));
    int onlineTotal = closedBills.where((b) => b['pay']!= 'Cash').fold(0, (s,e)=> s + (e['total'] as int));
    return SafeArea(child: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [
      Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Text("Today's Business Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Sales"), Text("Rs $todaysSale", style: TextStyle(fontWeight: FontWeight.bold))]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Bills"), Text("${closedBills.length}")]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Cash"), Text("Rs $cashTotal")]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("UPI / Online"), Text("Rs $onlineTotal")]),
      ])),
      SizedBox(height: 16),
      Text("Top Selling Items", style: TextStyle(fontWeight: FontWeight.bold)),
     ...menu.take(5).map((e) => Card(child: ListTile(title: Text(e['name']), trailing: Text("Rs ${e['full']}"))))
    ])));
  }

  Widget buildMore(){
    return SafeArea(child: ListView(children: [
      ListTile(title: Text("KGN TAWA FRY"), subtitle: Text("Smart billing by KGN"), leading: CircleAvatar(child: Text("K"))),
      Divider(),
      ListTile(leading: Icon(Icons.print), title: Text("Printer & Hardware Support"), subtitle: Text("Bluetooth, WiFi, USB Thermal")),
      ListTile(leading: Icon(Icons.inventory), title: Text("Inventory & Menu Management"), subtitle: Text("Stock tracking")),
      ListTile(leading: Icon(Icons.people), title: Text("Waiter App - Multi User"), subtitle: Text("Owner, Cashier, Waiter login")),
      ListTile(leading: Icon(Icons.table_bar), title: Text("Table Management")
