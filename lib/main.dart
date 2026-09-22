import 'package:flutter/material.dart';

void main() => runApp(const KGNApp());

class Item { String name; double price; String cat; String emoji; Item(this.name, this.price, this.cat, this.emoji); }
class Cart { Item item; int qty; Cart(this.item, this.qty); }
class KOTOrder { String id; String table; List<Cart> items; String type; String status; DateTime time; KOTOrder(this.id, this.table, this.items, this.type, this.status, this.time); }

class KGNApp extends StatelessWidget {
  const KGNApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'KGN TAWA FRY', theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)), home: const Home());
  }
}

class Home extends StatefulWidget { const Home({super.key}); @override State<Home> createState() => _HomeState(); }

class _HomeState extends State<Home> {
  int idx = 0;
  List<Item> menu = [
    Item("Chicken Biryani Half", 80, "CHICKEN", "🍚"),
    Item("Chicken Masala Half", 120, "CHICKEN", "🍛"),
    Item("Butter Chicken Half", 170, "CHICKEN", "🍗"),
    Item("Kheema Masala Half", 130, "MUTTON", "🥘"),
    Item("Bheja Masala Half", 130, "MUTTON", "🍲"),
    Item("Fish Fry Full", 160, "FISH", "🐟"),
    Item("Zinga Rice Half", 170, "PRAWNS", "🍤"),
    Item("Chapati Roti", 7, "ROTI", "🫓"),
    Item("Plain Rice", 30, "RICE", "🍚"),
    Item("Dal Fry Full", 100, "DAL", "🍲"),
  ];
  List<String> tables = List.generate(12, (i) => "T-${i+1}");
  Map<String, String> tableStatus = {};
  List<KOTOrder> orders = [];
  List<Cart> cart = [];
  String orderType = "Dine-in";
  String selectedTable = "T-1";
  double todaySale = 49;
  int todayOrders = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: getBody(),
      bottomNavigationBar: NavigationBar(selectedIndex: idx, onDestinationSelected: (i) => setState(() => idx = i), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.table_restaurant_outlined), selectedIcon: Icon(Icons.table_restaurant), label: "Tables"),
        NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: "Orders"),
        NavigationDestination(icon: Icon(Icons.restaurant_menu), selectedIcon: Icon(Icons.restaurant_menu), label: "Menu"),
        NavigationDestination(icon: Icon(Icons.more_horiz), label: "More"),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () => setState(() => idx = 1), backgroundColor: Colors.blue, child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  Widget getBody() {
    if (idx == 0) return homePage();
    if (idx == 1) return tablePage();
    if (idx == 2) return orderPage();
    if (idx == 3) return menuPage();
    return morePage();
  }

  Widget homePage() {
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("KGN TAWA FRY ▼", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 20),
      const Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        qItem(Icons.check_circle, "Closed", "${orders.where((o) => o.status == 'closed').length}"),
        qItem(Icons.access_time, "On Hold", "${orders.where((o) => o.status == 'hold').length}"),
        qItem(Icons.restaurant_menu, "Items", "${menu.length}"),
      ]),
      const SizedBox(height: 20),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Today's sales", style: TextStyle(color: Colors.grey, fontSize: 12)), Text("₹ $todaySale", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20))])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Today's orders", style: TextStyle(color: Colors.grey, fontSize: 12)), Text("$todayOrders", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))])),
        ]),
        const Divider(height: 20),
        const Row(children: [Text("Top selling items & more insights!", style: TextStyle(color: Colors.blue, fontSize: 12)), Spacer(), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.blue)]),
      ])),
      const SizedBox(height: 20),
      Row(children: [
        featCard("KOT View", Icons.soup_kitchen, Colors.orange),
        const SizedBox(width: 10),
        featCard("Waiter App", Icons.person, Colors.green),
        const SizedBox(width: 10),
        featCard("Inventory", Icons.inventory, Colors.purple),
      ]),
    ])));
  }

  Widget qItem(IconData ic, String t, String c) => Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: Icon(ic, color: Colors.white, size: 20)), const SizedBox(height: 5), Text(t, style: const TextStyle(fontSize: 11)), Text(c, style: const TextStyle(fontSize: 10, color: Colors.grey))]);
  Widget featCard(String t, IconData ic, Color col) => Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(ic, color: col), const SizedBox(height: 8), Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))])));

  Widget tablePage() {
    return SafeArea(child: Column(children: [
      const Padding(padding: EdgeInsets.all(16), child: Row(children: [Text("Table Management", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Spacer(), Icon(Icons.circle, color: Colors.green, size: 10), Text(" Empty "), Icon(Icons.circle, color: Colors.orange, size: 10), Text(" Occupied")])),
      Expanded(child: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.1, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: tables.length, itemBuilder: (_, i) {
        String t = tables[i];
        String st = tableStatus[t]?? "empty";
        Color c = st == "empty"? Colors.green : Colors.orange;
        return InkWell(onTap: () { selectedTable = t; showBilling(); }, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: c, width: 2)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.table_restaurant, color: c), const SizedBox(height: 5), Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: c)), Text(st.toUpperCase(), style: TextStyle(fontSize: 9, color: c))])));
      })),
      Padding(padding: const EdgeInsets.all(12), child: SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => setState(() => tables.add("T-${tables.length+1}")), icon: const Icon(Icons.add), label: const Text("Add Table")))),
    ]));
  }

  Widget orderPage() {
    return SafeArea(child: DefaultTabController(length: 3, child: Column(children: [
      AppBar(title: const Text("Orders & KOT"), backgroundColor: Colors.white, bottom: const TabBar(tabs: [Tab(text: "All"), Tab(text: "KOT"), Tab(text: "Closed")])),
      Expanded(child: TabBarView(children: [
        listOrders(orders),
        listOrders(orders.where((o) => o.status == "kot").toList()),
        listOrders(orders.where((o) => o.status == "closed").toList()),
      ])),
    ])));
  }

  Widget listOrders(List<KOTOrder> list) {
    if (list.isEmpty) {
      return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.receipt_long, size: 50, color: Colors.grey), SizedBox(height: 10), Text("No Orders")]));
    }
    return ListView.builder(padding: const EdgeInsets.all(10), itemCount: list.length, itemBuilder: (_, i) {
      var o = list[i];
      double tot = o.items.fold(0, (s, e) => s + e.item.price * e.qty);
      return Card(child: ListTile(title: Text("${o.table} - ${o.type}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), subtitle: Text("${o.items.map((e) => "${e.item.name} x${e.qty}").join(", ")}\n₹$tot", style: const TextStyle(fontSize: 11)), trailing: Chip(label: Text(o.status, style: const TextStyle(fontSize: 9))), onTap: () => showBill(o)));
    });
  }

  Widget menuPage() {
    return SafeArea(child: Column(children: [
      AppBar(title: const Text("Menu Items"), backgroundColor: Colors.white),
      Expanded(child: ListView.builder(itemCount: menu.length, itemBuilder: (_, i) {
        var m = menu[i];
        return Card(margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), child: ListTile(leading: Container(width: 45, height: 45, decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(m.emoji, style: const TextStyle(fontSize: 22)))), title: Text(m.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), subtitle: Text("${m.cat} • ₹${m.price}", style: const TextStyle(fontSize: 11))));
      })),
    ]));
  }

  Widget morePage() {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
      const ListTile(leading: CircleAvatar(child: Text("K")), title: Text("KGN TAWA FRY"), subtitle: Text("+91 7016742863")),
      const SizedBox(height: 10),
      const Text("Business", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
      ListTile(leading: const Icon(Icons.inventory), title: const Text("Inventory & Stock"), subtitle: Text("Items: ${menu.length}"), trailing: const Icon(Icons.arrow_forward_ios, size: 12)),
      ListTile(leading: const Icon(Icons.point_of_sale), title: const Text("Cash & Expense"), subtitle: Text("Today: ₹$todaySale"), trailing: const Icon(Icons.arrow_forward_ios, size: 12)),
      ListTile(leading: const Icon(Icons.print), title: const Text("Printer - Bluetooth/WiFi/USB"), subtitle: const Text("All thermal printers supported"), trailing: Switch(value: true, onChanged: (v) {})),
      ListTile(leading: const Icon(Icons.kitchen), title: const Text("KOT Printers - Veg/Non-Veg/Tandoor"), trailing: const Icon(Icons.arrow_forward_ios, size: 12)),
      const Divider(),
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)), child: const Row(children: [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 8), Text("Full Version - No Trial", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
    ]));
  }

  void showBilling() {
    cart = [];
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))), builder: (ctx) {
      return StatefulBuilder(builder: (ctx, setM) {
        double total = cart.fold(0, (s, e) => s + e.item.price * e.qty);
        return SizedBox(height: MediaQuery.of(context).size.height * 0.9, child: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: Row(children: [Text("Add Order - $selectedTable", style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close))])),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [
            ChoiceChip(label: const Text("Dine-in"), selected: orderType == "Dine-in", onSelected: (v) => setM(() => orderType = "Dine-in")),
            const SizedBox(width: 6),
            ChoiceChip(label: const Text("Takeaway"), selected: orderType == "Takeaway", onSelected: (v) => setM(() => orderType = "Takeaway")),
            const SizedBox(width: 6),
            ChoiceChip(label: const Text("Delivery"), selected: orderType == "Delivery", onSelected: (v) => setM(() => orderType = "Delivery")),
          ])),
          Expanded(child: GridView.builder(padding: const EdgeInsets.all(10), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.72, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: menu.length, itemBuilder: (_, i) {
            var m = menu[i];
            int q = 0;
            var f = cart.where((c) => c.item.name == m.name);
            if (f.isNotEmpty) q = f.first.qty;
            return Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)), child: Column(children: [
              Expanded(child: Container(decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.vertical(top: Radius.circular(10))), child: Center(child: Text(m.emoji, style: const TextStyle(fontSize: 32))))),
              Padding(padding: const EdgeInsets.all(5), child: Column(children: [
                Text(m.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text("₹${m.price}", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                const SizedBox(height: 3),
                q == 0? InkWell(onTap: () { setM(() => cart.add(Cart(m, 1))); setState(() {}); }, child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3), decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(5)), child: const Text("+ Add", style: TextStyle(color: Colors.blue, fontSize: 10)))) :
                Container(decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  InkWell(onTap: () { setM(() { var it = cart.firstWhere((c) => c.item.name == m.name); it.qty--; if (it.qty <= 0) cart.remove(it); }); setState(() {}); }, child: const Icon(Icons.remove, size: 14, color: Colors.white)),
                  Text("$q", style: const TextStyle(color: Colors.white, fontSize: 11)),
                  InkWell(onTap: () { setM(() => cart.firstWhere((c) => c.item.name == m.name).qty++); setState(() {}); }, child: const Icon(Icons.add, size: 14, color: Colors.white)),
                ])),
              ]),
            ]));
          })),
          if (cart.isNotEmpty) Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)]), child: Column(children: [
            Row(children: [Text("${cart.length} Items ₹$total", style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), TextButton(onPressed: () { setM(() => cart.clear()); setState(() {}); }, child: const Text("Clear"))]),
            const SizedBox(height: 6),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () { var o = KOTOrder(DateTime.now().millisecondsSinceEpoch.toString(), selectedTable, List.from(cart), orderType, "hold", DateTime.now()); setState(() { orders.add(o); tableStatus[selectedTable] = "occupied"; }); Navigator.pop(ctx); cart.clear(); }, child: const Text("Hold"))),
              const SizedBox(width: 8),
              Expanded(child: OutlinedButton(onPressed: () { var o = KOTOrder(DateTime.now().millisecondsSinceEpoch.toString(), selectedTable, List.from(cart), orderType, "kot", DateTime.now()); setState(() { orders.add(o); tableStatus[selectedTable] = "occupied"; }); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT Sent - ${o.items.length} items to Kitchen"))); }, style: OutlinedButton.styleFrom(backgroundColor: Colors.orange.shade50), child: const Text("KOT"))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: () { var o = KOTOrder(DateTime.now().millisecondsSinceEpoch.toString(), selectedTable, List.from(cart), orderType, "closed", DateTime.now()); setState(() { orders.add(o); todaySale += total; todayOrders++; tableStatus[selectedTable] = "empty"; }); Navigator.pop(ctx); showBill(o); cart.clear(); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text("Bill", style: TextStyle(color: Colors.white)))),
            ]),
          ])),
        ]));
      });
    });
  }

  void showBill(KOTOrder o) {
    double tot = o.items.fold(0, (s, e) => s + e.item.price * e.qty);
    showDialog(context: context, builder: (_) => AlertDialog(title: Column(children: [const Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold)), const Text("+91 7016742863", style: TextStyle(fontSize: 10, color: Colors.grey)), const Divider(), Text("${o.type} - ${o.table}", style: const TextStyle(fontSize: 12))]), content: Column(mainAxisSize: MainAxisSize.min, children: [...o.items.map((e) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text("${e.item.name} x${e.qty}", style: const TextStyle(fontSize: 12))), Text("₹${e.item.price * e.qty}", style: const TextStyle(fontSize: 12))])), const Divider(), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)), Text("₹$tot", style: const TextStyle(fontWeight: FontWeight.bold))]), const SizedBox(height: 8), const Text("No GST - Thank You!", style: TextStyle(fontSize: 10, color: Colors.grey))]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")), ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Printed to Thermal Printer 🖨️"))); }, child: const Text("Print"))]));
  }
          }
