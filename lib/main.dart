import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGNProApp()));

class KGNProApp extends StatefulWidget {
  const KGNProApp({super.key});
  @override State<KGNProApp> createState() => _KGNProAppState();
}

class _KGNProAppState extends State<KGNProApp> {
  int nav = 0;
  String orderType = "Dine-in";
  String selTable = "T-1";
  List<String> tables = List.generate(12, (i) => "T-${i+1}");
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> kotList = [];
  double todayExpense = 0;

  List<Map<String, dynamic>> menu = [
    {"name": "Anda Kadhi", "price": 80, "full": 160, "cat": "ANDA", "emoji": "🥚", "kitchen": "MAIN"},
    {"name": "Anda Kheema", "price": 80, "full": 160, "cat": "ANDA", "emoji": "🥚", "kitchen": "MAIN"},
    {"name": "Anda Bhurji", "price": 50, "full": 100, "cat": "ANDA", "emoji": "🥚", "kitchen": "MAIN"},
    {"name": "Dal Tadka", "price": 70, "full": 140, "cat": "VEG", "emoji": "🍲", "kitchen": "VEG"},
    {"name": "Dal Gotala", "price": 80, "full": 160, "cat": "VEG", "emoji": "🍲", "kitchen": "VEG"},
    {"name": "Sabji Fry", "price": 50, "full": 100, "cat": "VEG", "emoji": "🥗", "kitchen": "VEG"},
    {"name": "Masala Rice", "price": 50, "full": 100, "cat": "RICE", "emoji": "🍚", "kitchen": "TANDOOR"},
    {"name": "Biryani Rice", "price": 50, "full": 100, "cat": "RICE", "emoji": "🍚", "kitchen": "TANDOOR"},
    {"name": "Jeera Rice", "price": 50, "full": 100, "cat": "RICE", "emoji": "🍚", "kitchen": "TANDOOR"},
    {"name": "Kadhi Khichdi", "price": 30, "full": 60, "cat": "RICE", "emoji": "🍛", "kitchen": "MAIN"},
    {"name": "Special Roti", "price": 15, "full": 15, "cat": "ROTI", "emoji": "🫓", "kitchen": "TANDOOR"},
    {"name": "Special Paratha", "price": 20, "full": 20, "cat": "ROTI", "emoji": "🫓", "kitchen": "TANDOOR"},
    {"name": "Chapati Roti", "price": 7, "full": 7, "cat": "ROTI", "emoji": "🫓", "kitchen": "TANDOOR"},
    {"name": "Chicken Handi", "price": 170, "full": 320, "cat": "CHICKEN", "emoji": "🍗", "kitchen": "NON-VEG"},
    {"name": "Butter Chicken", "price": 180, "full": 350, "cat": "CHICKEN", "emoji": "🍗", "kitchen": "NON-VEG"},
    {"name": "Chicken Biryani", "price": 250, "full": 480, "cat": "CHICKEN", "emoji": "🍗", "kitchen": "NON-VEG"},
    {"name": "Chicken Fry", "price": 120, "full": 220, "cat": "CHICKEN", "emoji": "🍗", "kitchen": "NON-VEG"},
    {"name": "Mutton Masala", "price": 120, "full": 220, "cat": "MUTTON", "emoji": "🍖", "kitchen": "NON-VEG"},
    {"name": "Kheema Fry", "price": 80, "full": 160, "cat": "MUTTON", "emoji": "🥘", "kitchen": "NON-VEG"},
    {"name": "Machhi Fry", "price": 80, "full": 160, "cat": "FISH", "emoji": "🐟", "kitchen": "NON-VEG"},
    {"name": "Jinga Fry", "price": 130, "full": 240, "cat": "PRAWNS", "emoji": "🍤", "kitchen": "NON-VEG"},
    {"name": "Paneer Tikka Starter", "price": 120, "full": 220, "cat": "STARTER", "emoji": "🍢", "kitchen": "VEG"},
    {"name": "Chicken Lollypop", "price": 150, "full": 280, "cat": "STARTER", "emoji": "🍢", "kitchen": "NON-VEG"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: getBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: nav,
        onDestinationSelected: (i) => setState(() => nav = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: "Home"),
          NavigationDestination(icon: Icon(Icons.table_bar), label: "Tables"),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: "KOT"),
          NavigationDestination(icon: Icon(Icons.menu_book), label: "Menu"),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: "Reports"),
        ],
      ),
      floatingActionButton: nav == 1? FloatingActionButton.extended(onPressed: addTableDialog, icon: const Icon(Icons.add), label: const Text("Add Table")) : nav == 3? FloatingActionButton.extended(backgroundColor: Colors.green, onPressed: addNewItemDialog, icon: const Icon(Icons.add, color: Colors.white), label: const Text("Add Item", style: TextStyle(color: Colors.white))) : null,
    );
  }

  Widget getBody() {
    if (nav == 0) return homePro();
    if (nav == 1) return tablePro();
    if (nav == 2) return kotPro();
    if (nav == 3) return menuPro();
    return reportsPro();
  }

  // HOME - DASHBOARD
  Widget homePro() {
    double todaySale = 0; for (var o in orders) todaySale += o['total'];
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const CircleAvatar(backgroundColor: Colors.orange, child: Text("K", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Table by KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text("${menu.length} Items • ${tables.length} Tables • No GST", style: const TextStyle(fontSize: 11, color: Colors.grey))])]),
      const SizedBox(height: 16),
      const Text("Smart restaurant billing, KOT management & order tracking—fast and easy.", style: TextStyle(fontSize: 12, color: Colors.grey)),
      const SizedBox(height: 16),
      GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.8, children: [
        dashCard("Today's Sales", "Rs $todaySale", Icons.currency_rupee, Colors.green, "${orders.length} bills"),
        dashCard("Today's Orders", "${orders.length}", Icons.receipt_long, Colors.blue, "$orderType active"),
        dashCard("Occupied Tables", "${orders.length}/${tables.length}", Icons.table_restaurant, Colors.orange, "Live status"),
        dashCard("KOT Pending", "${kotList.length}", Icons.soup_kitchen, Colors.red, "Kitchen queue"),
      ]),
      const SizedBox(height: 16),
      const Text("🚀 Key Features", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 8),
      featureTile(Icons.bolt, "Fast & Simple Billing", "Create bills in seconds, discounts, qty manage"),
      featureTile(Icons.soup_kitchen, "Smart KOT Management", "Send to kitchen screen/printer, veg/non-veg sections"),
      featureTile(Icons.swap_horiz, "Accurate Order Management", "Dine-in, Takeaway, Delivery, modify/merge/shift"),
      featureTile(Icons.table_bar, "Table Management", "Unlimited tables, occupied/reserved/empty tracking"),
      featureTile(Icons.phone_android, "Mobile & Multi-Device", "Phone/tablet, owner/cashier/waiter login"),
      const SizedBox(height: 16),
      Row(children: [Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.all(16)), onPressed: () => setState(() => nav = 1), icon: const Icon(Icons.add, color: Colors.white), label: const Text("New Order", style: TextStyle(color: Colors.white)))), const SizedBox(width: 12), Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(16)), onPressed: () => setState(() => nav = 2), icon: const Icon(Icons.print, color: Colors.white), label: const Text("KOT Print", style: TextStyle(color: Colors.white))))]),
    ])));
  }

  Widget dashCard(String title, String value, IconData icon, Color color, String sub) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, size: 18, color: color), const SizedBox(width: 6), Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey))]), const SizedBox(height: 4), Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)), Text(sub, style: const TextStyle(fontSize: 9, color: Colors.grey))]));
  Widget featureTile(IconData ic, String t, String d) => Card(margin: const EdgeInsets.only(bottom: 6), child: ListTile(dense: true, leading: CircleAvatar(backgroundColor: Colors.blue.shade50, child: Icon(ic, size: 16, color: Colors.blue)), title: Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), subtitle: Text(d, style: const TextStyle(fontSize: 9, color: Colors.grey))));

  // TABLE MANAGEMENT
  Widget tablePro() => SafeArea(child: Column(children: [
    Padding(padding: const EdgeInsets.all(16), child: Row(children: [const Text("Table Management", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const Spacer(), DropdownButton<String>(value: orderType, items: ["Dine-in", "Takeaway", "Delivery"].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(), onChanged: (v) => setState(() => orderType = v!)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)), child: Text("${tables.length} Tables", style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)))])),
    Expanded(child: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1), itemCount: tables.length, itemBuilder: (c, i) { bool isBusy = orders.any((o) => o['table'] == tables[i]); return InkWell(onTap: () { selTable = tables[i]; cart = []; openBillingSheet(); }, onLongPress: () => tableOptions(i), child: Container(decoration: BoxDecoration(color: isBusy? Colors.red.shade50 : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isBusy? Colors.red : Colors.green, width: 2)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.table_restaurant, color: isBusy? Colors.red : Colors.green), Text(tables[i], style: TextStyle(fontWeight: FontWeight.bold, color: isBusy? Colors.red : Colors.green)), Text(isBusy? "OCCUPIED" : "EMPTY", style: TextStyle(fontSize: 9, color: isBusy? Colors.red : Colors.green)), Text(orderType, style: const TextStyle(fontSize: 7, color: Colors.grey))]))); })),
  ]));

  // KOT SCREEN
  Widget kotPro() {
    if (kotList.isEmpty) return const SafeArea(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.soup_kitchen, size: 50, color: Colors.grey), SizedBox(height: 10), Text("No KOT Pending"), Text("KOT = Kitchen Order Ticket", style: TextStyle(fontSize: 11, color: Colors.grey)) ])));
    return SafeArea(child: Column(children: [Padding(padding: const EdgeInsets.all(16), child: Row(children: [Text("KOT Management - ${kotList.length} Pending", style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () => setState(() => kotList.clear()), icon: const Icon(Icons.clear_all, color: Colors.white, size: 16), label: const Text("Clear All", style: TextStyle(color: Colors.white, fontSize: 11)))] )), Expanded(child: ListView.builder(itemCount: kotList.length, itemBuilder: (c, i) { var k = kotList[i]; return Card(color: Colors.orange.shade50, margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), child: ListTile(title: Text("KOT #${i+1} - ${k['table']} | ${k['type']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [(k['items'] as List).map<Widget>((it) => Text("• ${it['name']} x${it['qty']} - ${it['kitchen']}", style: const TextStyle(fontSize: 11))).toList().first, Text("Time: ${k['time']} | Printer: ${k['kitchen']}", style: const TextStyle(fontSize: 9, color: Colors.grey))]), trailing: IconButton(icon: const Icon(Icons.print, color: Colors.green), onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT ${k['table']} Printed to ${k['kitchen']} Printer"), backgroundColor: Colors.green)); }))); }))]));
  }

  // MENU MANAGEMENT - ADD/EDIT ANYTIME
  Widget menuPro() => SafeArea(child: Column(children: [
    Padding(padding: const EdgeInsets.all(12), child: Row(children: [Text("Menu - ${menu.length} Items - Add/Edit Anytime", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: const Text("No GST", style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)))])),
    Expanded(child: ListView.builder(itemCount: menu.length, itemBuilder: (c, i) { var m = menu[i]; return Card(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), child: ListTile(dense: true, leading: Text(m['emoji'], style: const TextStyle(fontSize: 20)), title: Text(m['name'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), subtitle: Text("${m['cat']} | H:${m['price']} F:${m['full']} | Kitchen:${m['kitchen']}", style: const TextStyle(fontSize: 8)), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.edit, size: 16, color: Colors.orange), onPressed: () => editPriceDialog(i)), IconButton(icon: const Icon(Icons.delete, size: 16, color: Colors.red), onPressed: () => deleteItem(i))]), onLongPress: () => editPriceDialog(i))); })),
  ]));

  // REPORTS
  Widget reportsPro() {
    double totalSale = 0; for (var o in orders) totalSale += o['total'];
    Map<String, double> catSale = {}; for (var o in orders) { for (var it in o['items']) { String cat = menu.firstWhere((m) => m['name'] == it['name'], orElse: () => {"cat": "OTHER"})['cat']; catSale[cat] = (catSale[cat]?? 0) + (it['price']*it['qty']); } }
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Reports & Insights", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Daily Sales"), Text("Rs $totalSale", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green))]), const Divider(), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total Bills"), Text("${orders.length}", style: const TextStyle(fontWeight: FontWeight.bold))]), const Divider(), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Expense"), Text("Rs $todayExpense", style: const TextStyle(color: Colors.red))]), const Divider(), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Net Profit"), Text("Rs ${totalSale - todayExpense}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))])])),
      const SizedBox(height: 16),
      const Text("Item-wise & Category Sales", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      const SizedBox(height: 8),
     ...catSale.entries.map((e) => Card(child: ListTile(dense: true, title: Text(e.key, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), trailing: Text("Rs ${e.value}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))))),
      const SizedBox(height: 16),
      const Text("Payment Mode Breakup - No GST", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      const SizedBox(height: 8),
      Card(child: ListTile(dense: true, title: const Text("CASH", style: TextStyle(fontSize: 11)), trailing: Text("Rs $totalSale", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)))),
      Card(child: ListTile(dense: true, title: const Text("UPI / CARD", style: TextStyle(fontSize: 11)), trailing: const Text("Rs 0", style: TextStyle(fontSize: 11)))),
      const SizedBox(height: 16),
      ElevatedButton.icon(onPressed: () { setState(() { todayExpense += 100; }); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Expense Rs 100 Added"))); }, icon: const Icon(Icons.add), label: const Text("Add Expense")),
    ])));
  }

  // DIALOGS
  void addTableDialog() {
    TextEditingController t = TextEditingController(text: "T-${tables.length+1}");
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text("Add Table - Unlimited"), content: TextField(controller: t, decoration: const InputDecoration(labelText: "Table Name", border: OutlineInputBorder())), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")), ElevatedButton(onPressed: () { setState(() => tables.add(t.text)); Navigator.pop(ctx); }, child: const Text("Add"))]));
  }

  void tableOptions(int i) {
    showModalBottomSheet(context: context, builder: (ctx) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(title: Text(tables[i]), subtitle: const Text("Modify / Merge / Shift")),
      ListTile(leading: const Icon(Icons.swap_horiz), title: const Text("Shift Order"), onTap: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${tables[i]} Shift feature"))); }),
      ListTile(leading: const Icon(Icons.merge), title: const Text("Merge Tables"), onTap: () { Navigator.pop(ctx); }),
      ListTile(leading: const Icon(Icons.delete, color: Colors.red), title: const Text("Delete Table", style: TextStyle(color: Colors.red)), onTap: () { setState(() => tables.removeAt(i)); Navigator.pop(ctx); }),
    ])));
  }

  void editPriceDialog(int index) {
    int half = menu[index]['price']; int full = menu[index]['full'];
    TextEditingController h = TextEditingController(text: half.toString()); TextEditingController f = TextEditingController(text: full.toString());
    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, setD) => AlertDialog(title: Text(menu[index]['name'], style: const TextStyle(fontSize: 14)), content: Column(mainAxisSize: MainAxisSize.min, children: [Row(children: [const Text("Half: "), IconButton(onPressed: () { if (half > 0) { setD(() => half--); h.text = half.toString(); } }, icon: const Icon(Icons.remove)), Expanded(child: TextField(controller: h, keyboardType: TextInputType.number, textAlign: TextAlign.center, onChanged: (v) => half = int.tryParse(v)?? half, decoration: const InputDecoration(border: OutlineInputBorder()))), IconButton(onPressed: () { setD(() => half++); h.text = half.toString(); }, icon: const Icon(Icons.add))]), const SizedBox(height: 8), Row(children: [const Text("Full: "), IconButton(onPressed: () { if (full > 0) { setD(() => full--); f.text = full.toString(); } }, icon: const Icon(Icons.remove)), Expanded(child: TextField(controller: f, keyboardType: TextInputType.number, textAlign: TextAlign.center, onChanged: (v) => full = int.tryParse(v)?? full, decoration: const InputDecoration(border: OutlineInputBorder()))), IconButton(onPressed: () { setD(() => full++); f.text = full.toString(); }, icon: const Icon(Icons.add))])]), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () { setState(() { menu[index]['price'] = half; menu[index]['full'] = full; }); Navigator.pop(ctx); }, child: const Text("SAVE", style: TextStyle(color: Colors.white))) ])));
  }

  void addNewItemDialog() {
    TextEditingController n = TextEditingController(); TextEditingController h = TextEditingControlle
