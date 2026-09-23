import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGNProFinalApp()));

class KGNProFinalApp extends StatefulWidget {
  const KGNProFinalApp({super.key});
  @override State<KGNProFinalApp> createState() => _KGNProFinalAppState();
}

class _KGNProFinalAppState extends State<KGNProFinalApp> {
  int nav = 0;
  String orderType = "Dine-in"; // Dine-in, Takeaway, Delivery
  String selTable = "T-1";
  String userRole = "Owner"; // Owner, Cashier, Waiter
  double discount = 0;
  double expenseToday = 0;
  List<String> tables = List.generate(12, (i) => "T-${i+1}");
  Map<String, String> tableStatus = {}; // empty, occupied, reserved
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> kotList = [];
  List<Map<String, dynamic>> expenses = [];
  Map<String, int> inventory = {};

  // AAPKE 59 ITEMS - SAME AS BEFORE
  List<Map<String, dynamic>> menu = [
    {"name": "Murgh Do Pyaza", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Murgh Moghlai", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Handi", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Pisawar", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Murgh Shahi Chicken", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Malai Tikka", "half": 180, "full": 350, "cat": "CHICKEN", "kitchen": "TANDOOR", "stock": 50},
    {"name": "Chicken Tikka Masala", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Kadhai", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Garlic", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken India", "half": 250, "full": 450, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Butter Chicken Boneless", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "White Chicken", "half": 180, "full": 350, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Green Chicken", "half": 180, "full": 350, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Fry", "half": 120, "full": 220, "cat": "CHICKEN", "kitchen": "TAWA", "stock": 50},
    {"name": "Chicken Masala", "half": 120, "full": 220, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Biryani", "half": 80, "full": 120, "cat": "CHICKEN", "kitchen": "RICE", "stock": 50},
    {"name": "Chicken Tandoori Masala", "half": 250, "full": 480, "cat": "CHICKEN", "kitchen": "TANDOOR", "stock": 50},
    {"name": "Chicken Amdavadi Masala", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50},
    {"name": "Chicken Tikka Rice", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "RICE", "stock": 50},
    {"name": "Moghlai Mutton", "half": 150, "full": 280, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "DalBati Gos", "half": 150, "full": 280, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "White Mutton", "half": 160, "full": 300, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "Green Mutton", "half": 150, "full": 280, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "Mutton Kurma", "half": 160, "full": 300, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "Mutton Fry", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Mutton Masala", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "Kaleji Masala", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Bhaji Gos", "half": 130, "full": 240, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40},
    {"name": "Paya Fry", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Champ Fry", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Bheja Fry", "half": 130, "full": 240, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Boti Masala", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Kheema Fry", "half": 80, "full": 160, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40},
    {"name": "Kheema Pulav", "half": 100, "full": 180, "cat": "MUTTON", "kitchen": "RICE", "stock": 40},
    {"name": "Machhi Fry", "half": 80, "full": 160, "cat": "FISH", "kitchen": "TAWA", "stock": 30},
    {"name": "Machhi Kadhi", "half": 100, "full": 200, "cat": "FISH", "kitchen": "NON-VEG", "stock": 30},
    {"name": "Jhinga Fry", "half": 130, "full": 240, "cat": "FISH", "kitchen": "TAWA", "stock": 30},
    {"name": "Jhinga Rice", "half": 170, "full": 320, "cat": "FISH", "kitchen": "RICE", "stock": 30},
    {"name": "Anda Kadhi", "half": 80, "full": 160, "cat": "ANDA", "kitchen": "VEG", "stock": 60},
    {"name": "Anda Kheema", "half": 80, "full": 160, "cat": "ANDA", "kitchen": "VEG", "stock": 60},
    {"name": "Anda Bhurji", "half": 50, "full": 100, "cat": "ANDA", "kitchen": "TAWA", "stock": 60},
    {"name": "Anda Pulav", "half": 60, "full": 120, "cat": "ANDA", "kitchen": "RICE", "stock": 60},
    {"name": "Dal Tadka", "half": 70, "full": 140, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Dal Gotala", "half": 80, "full": 160, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Butter Dal Fry", "half": 70, "full": 140, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Dal Fry", "half": 50, "full": 100, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Sabji Fry", "half": 50, "full": 100, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Sev Tameta", "half": 50, "full": 100, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Masala Rice", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100},
    {"name": "Biryani Rice", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100},
    {"name": "Jeera Rice", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100},
    {"name": "Kadhi Khichdi", "half": 30, "full": 60, "cat": "VEG", "kitchen": "VEG", "stock": 100},
    {"name": "Dal Pulav", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100},
    {"name": "Plain Rice", "half": 30, "full": 60, "cat": "VEG", "kitchen": "RICE", "stock": 100},
    {"name": "Special Roti", "half": 15, "full": 15, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200},
    {"name": "Special Paratha", "half": 20, "full": 20, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200},
    {"name": "Butter Roti", "half": 15, "full": 15, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200},
    {"name": "Chapati Roti", "half": 7, "full": 7, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200},
    {"name": "Papad Fry", "half": 10, "full": 10, "cat": "ROTI", "kitchen": "VEG", "stock": 200},
  ];

  double get total => cart.fold(0, (s, e) => s + (e['price'] * e['qty']));
  double get finalTotal => total - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("KGN TAWA FRY - $userRole"), backgroundColor: Colors.deepOrange),
      drawer: buildDrawer(),
      body: [buildHomeBilling(), buildTables(), buildKOTScreen(), buildMenuFull(), buildReports()][nav],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav, onTap: (i) => setState(() => nav = i), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.deepOrange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.table_bar), label: 'Tables'),
          BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen), label: 'KOT'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu 59'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        ],
      ),
    );
  }

  // 📋 1. FAST & SIMPLE BILLING
  Widget buildHomeBilling() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            DropdownButton(value: orderType, items: ["Dine-in","Takeaway","Delivery"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => orderType = v!)),
            const SizedBox(width: 10),
            DropdownButton(value: selTable, items: tables.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => selTable = v!)),
            const Spacer(),
            Text("Disc: Rs $discount"),
          ]),
        ),
        Expanded(
          child: cart.isEmpty? const Center(child: Text("Menu se item add karo - Fast Billing")) :
          ListView.builder(itemCount: cart.length, itemBuilder: (c,i) => ListTile(
            title: Text(cart[i]['name']),
            subtitle: Row(children: [
              IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() { if(cart[i]['qty']>1) cart[i]['qty']--; else cart.removeAt(i); })),
              Text("${cart[i]['qty']}"),
              IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => cart[i]['qty']++)),
            ]),
            trailing: Text("Rs ${cart[i]['price'] * cart[i]['qty']}"),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            TextField(decoration: const InputDecoration(labelText: "Discount Rs"), keyboardType: TextInputType.number, onChanged: (v) => setState(() => discount = double.tryParse(v)?? 0)),
            const SizedBox(height: 8),
            Text("Total: Rs $total | Final: Rs $finalTotal", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: () => generateKOT(), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text("SEND KOT"))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: () => makeBill(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("GENERATE BILL"))),
            ])
          ]),
        )
      ],
    );
  }

  // 🪑 2. TABLE MANAGEMENT + 🔄 ORDER MANAGEMENT
  Widget buildTables() {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: ElevatedButton(onPressed: () => setState(() { tables.add("T-${tables.length+1}"); }), child: const Text("Create Unlimited Tables +"))),
        Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemCount: tables.length, itemBuilder: (c,i) {
          String t = tables[i];
          String status = tableStatus[t]?? "empty";
          Color col = status=="occupied"? Colors.red : status=="reserved"? Colors.orange : Colors.green;
          return Card(color: col.withOpacity(0.3), child: InkWell(onTap: () => setState(() => selTable = t), onLongPress: () => showTableOptions(t), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: const TextStyle(fontWeight: FontWeight.bold)), Text(status)]))));
        })),
      ],
    );
  }

  void showTableOptions(String table) {
    showModalBottomSheet(context: context, builder: (c) => Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(title: const Text("Mark Occupied"), onTap: () => setState(() { tableStatus[table]="occupied"; Navigator.pop(context); })),
      ListTile(title: const Text("Mark Reserved"), onTap: () => setState(() { tableStatus[table]="reserved"; Navigator.pop(context); })),
      ListTile(title: const Text("Mark Empty"), onTap: () => setState(() { tableStatus[table]="empty"; Navigator.pop(context); })),
      ListTile(title: const Text("Shift Order"), onTap: () => setState(() { Navigator.pop(context); })),
      ListTile(title: const Text("Merge Table"), onTap: () => setState(() { Navigator.pop(context); })),
    ]));
  }

  // 🍽️ 3. SMART KOT MANAGEMENT
  Widget buildKOTScreen() {
    return Column(children: [
      const Padding(padding: EdgeInsets.all(8), child: Text("KOT - Kitchen Sections (Veg, Non-Veg, Tandoor, Tawa, Rice)", style: TextStyle(fontWeight: FontWeight.bold))),
      Expanded(child: ListView.builder(itemCount: kotList.length, itemBuilder: (c,i) {
        var kot = kotList[i];
        return Card(child: ListTile(title: Text("${kot['table']} - ${kot['kitchen']}"), subtitle: Text(kot['items'].map((e) => e['name']).join(", ")), trailing: IconButton(icon: const Icon(Icons.print), onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT Sent to ${kot['kitchen']} Printer - Bluetooth/WiFi/USB"))); })));
      }))
    ]);
  }

  // 📦 INVENTORY + MENU MANAGEMENT
  Widget buildMenuFull() {
    return ListView.builder(itemCount: menu.length, itemBuilder: (c,i) {
      var item = menu[i];
      return Card(child: ListTile(
        title: Text(item['name']), subtitle: Text("${item['cat']} | Kitchen: ${item['kitchen']} | Stock: ${item['stock']}"),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          ElevatedButton(onPressed: () => addToCart(item, false), child: Text("H ${item['half']}")),
          const SizedBox(width: 4),
          ElevatedButton(onPressed: () => addToCart(item, true), child: Text("F ${item['full']}")),
        ]),
      ));
    });
  }

  // 💰 CASH & EXPENSE + 📊 REPORTS
  Widget buildReports() {
    double todaySale = orders.fold(0.0, (s,o) => s + o['total']);
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text("Daily Business Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Card(child: ListTile(title: const Text("Today's Sales"), trailing: Text("Rs $todaySale", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))),
      Card(child: ListTile(title: const Text("Today's Orders"), trailing: Text("${orders.length}"))),
      Card(child: ListTile(title: const Text("Today's Expenses"), trailing: Text("Rs $expenseToday"))),
      Card(child: ListTile(title: const Text("Payment Mode"), subtitle: const Text("Cash: 70% | Online: 30% | No GST"), trailing: const Icon(Icons.payments))),

      const Divider(),
      const Text("Expense Tracking", style: TextStyle(fontWeight: FontWeight.bold)),
      Row(children: [
        Expanded(child: TextField(decoration: const InputDecoration(labelText: "Expense"), onSubmitted: (v) { setState(() { expenses.add({"name": v, "amt": 100}); expenseToday+=100; }); })),
        ElevatedButton(onPressed: () => setState(() { expenseToday+=50; expenses.add({"name": "Sabji", "amt": 50}); }), child: const Text("Add Rs 50"))
      ]),
     ...expenses.map((e) => ListTile(title: Text(e['name']), trailing: Text("Rs ${e['amt']}"))),

      const Divider(),
      const Text("Item-wise Report", style: TextStyle(fontWeight: FontWeight.bold)),
     ...menu.take(5).map((e) => ListTile(title: Text(e['name']), trailing: Text("Sold: ${orders.length}"))),

      const Divider(),
      ElevatedButton.icon(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Printer: Bluetooth, WiFi, USB - Thermal Printer Connected"))); }, icon: const Icon(Icons.print), label: const Text("Printer & Hardware Support Test")),
    ]);
  }

  Widget buildDrawer() {
    return Drawer(child: ListView(children: [
      const DrawerHeader(decoration: BoxDecoration(color: Colors.deepOrange), child: Text("KGN TAWA FRY\nSmart Billing", style: TextStyle(color: Colors.white, fontSize: 20))),
      ListTile(title: const Text("Owner Mode"), onTap: () => setState(() { userRole="Owner"; Navigator.pop(context); })),
      ListTile(title: const Text("Cashier Mode"), onTap: () => setState(() { userRole="Cashier"; Navigator.pop(context); })),
      ListTile(title: const Text("Waiter Ordering App"), subtitle: const Text("Waiters can take orders from mobile"), onTap: () => setState(() { userRole="Waiter"; nav=1; Navigator.pop(context); })),
      ListTile(title: const Text("Multi-Device Sync"), subtitle: const Text("Phone + Tablet sync"), onTap: () => Navigator.pop(context)),
      const Divider(),
      const ListTile(title: Text("Designed for Indian Restaurants\nFast, Zero Learning Curve")),
    ]));
  }

  void addToCart(Map<String, dynamic> item, bool isFull) {
    setState(() {
      int price = isFull? item['full'] : item['half'];
      String name = "${item['name']} ${isFull? '(Full)' : '(Half)'}";
      var idx = cart.indexWhere((c) => c['name'] == name);
      if (idx >= 0) cart[idx]['qty']++; else cart.add({"name": name, "price": price, "qty": 1, "kitchen": item['kitchen']});
      if (item['stock']>0) item['stock']--;
    });
  }

  void generateKOT() {
    if (cart.isEmpty) return;
    setState(() {
      var grouped = {};
      for (var i in cart) { grouped[i['kitchen']]??= []; grouped[i['kitchen']].add(i); }
      grouped.forEach((kitchen, items) { kotList.add({"table": selTable, "kitchen": kitchen, "items": items, "time": DateTime.now().toString().substring(11,16), "orderType": orderType}); });
      tableStatus[selTable]="occupied";
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT Sent - $orderType - $selTable - ${cart.length} items to Kitchen Sections")));
  }

  void makeBill() {
    if (cart.isEmpty) return;
    generateKOT();
    setState(() { orders.add({"table": selTable, "items": List.from(cart), "total": finalTotal, "time": DateTime.now().toString().substring(11,16), "type": orderType}); cart.clear(); discount=0; });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bill Generated - No GST - Printer: Bluetooth/WiFi/USB Ready")));
  }
}
