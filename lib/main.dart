import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGNBillingApp()));

class KGNBillingApp extends StatefulWidget {
  const KGNBillingApp({super.key});
  @override State<KGNBillingApp> createState() => _KGNBillingAppState();
}

class _KGNBillingAppState extends State<KGNBillingApp> {
  int nav = 0;
  String selTable = "T-1";
  String selectedCat = "ALL";
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> orders = [];

  // TOTAL 59 ITEMS - Aapke Menu Card Se
  List<Map<String, dynamic>> menu = [
    // CHICKEN ITEM - 19 items
    {"name": "Murgh Do Pyaza", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Murgh Moghlai", "half": 160, "full": 300, "cat": "CHICKEN"},
    {"name": "Chicken Handi", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Chicken Pisawar", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Murgh Shahi Chicken", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Chicken Malai Tikka", "half": 180, "full": 350, "cat": "CHICKEN"},
    {"name": "Chicken Tikka Masala", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Chicken Kadhai", "half": 160, "full": 300, "cat": "CHICKEN"},
    {"name": "Chicken Garlic", "half": 160, "full": 300, "cat": "CHICKEN"},
    {"name": "Chicken India", "half": 250, "full": 450, "cat": "CHICKEN"},
    {"name": "Butter Chicken Boneless", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "White Chicken", "half": 180, "full": 350, "cat": "CHICKEN"},
    {"name": "Green Chicken", "half": 180, "full": 350, "cat": "CHICKEN"},
    {"name": "Chicken Fry", "half": 120, "full": 220, "cat": "CHICKEN"},
    {"name": "Chicken Masala", "half": 120, "full": 220, "cat": "CHICKEN"},
    {"name": "Chicken Biryani", "half": 80, "full": 120, "cat": "CHICKEN"},
    {"name": "Chicken Tandoori Masala", "half": 250, "full": 480, "cat": "CHICKEN"},
    {"name": "Chicken Amdavadi Masala", "half": 160, "full": 300, "cat": "CHICKEN"},
    {"name": "Chicken Tikka Rice", "half": 170, "full": 320, "cat": "CHICKEN"},

    // MUTTON ITEM - 15 items
    {"name": "Moghlai Mutton", "half": 150, "full": 280, "cat": "MUTTON"},
    {"name": "DalBati Gos", "half": 150, "full": 280, "cat": "MUTTON"},
    {"name": "White Mutton", "half": 160, "full": 300, "cat": "MUTTON"},
    {"name": "Green Mutton", "half": 150, "full": 280, "cat": "MUTTON"},
    {"name": "Mutton Kurma", "half": 160, "full": 300, "cat": "MUTTON"},
    {"name": "Mutton Fry", "half": 120, "full": 220, "cat": "MUTTON"},
    {"name": "Mutton Masala", "half": 120, "full": 220, "cat": "MUTTON"},
    {"name": "Kaleji Masala", "half": 120, "full": 220, "cat": "MUTTON"},
    {"name": "Bhaji Gos", "half": 130, "full": 240, "cat": "MUTTON"},
    {"name": "Paya Fry", "half": 120, "full": 220, "cat": "MUTTON"},
    {"name": "Champ Fry", "half": 120, "full": 220, "cat": "MUTTON"},
    {"name": "Bheja Fry", "half": 130, "full": 240, "cat": "MUTTON"},
    {"name": "Boti Masala", "half": 120, "full": 220, "cat": "MUTTON"},
    {"name": "Kheema Fry", "half": 80, "full": 160, "cat": "MUTTON"},
    {"name": "Kheema Pulav", "half": 100, "full": 180, "cat": "MUTTON"},

    // JHINGA - MACHHI - 4 items
    {"name": "Machhi Fry", "half": 80, "full": 160, "cat": "FISH"},
    {"name": "Machhi Kadhi", "half": 100, "full": 200, "cat": "FISH"},
    {"name": "Jhinga Fry", "half": 130, "full": 240, "cat": "FISH"},
    {"name": "Jhinga Rice", "half": 170, "full": 320, "cat": "FISH"},

    // ANDA ITEM - 4 items
    {"name": "Anda Kadhi", "half": 80, "full": 160, "cat": "ANDA"},
    {"name": "Anda Kheema", "half": 80, "full": 160, "cat": "ANDA"},
    {"name": "Anda Bhurji", "half": 50, "full": 100, "cat": "ANDA"},
    {"name": "Anda Pulav", "half": 60, "full": 120, "cat": "ANDA"},

    // VEG & ROTI - 17 items
    {"name": "Dal Tadka", "half": 70, "full": 140, "cat": "VEG"},
    {"name": "Dal Gotala", "half": 80, "full": 160, "cat": "VEG"},
    {"name": "Butter Dal Fry", "half": 70, "full": 140, "cat": "VEG"},
    {"name": "Dal Fry", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Sabji Fry", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Sev Tameta", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Masala Rice", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Biryani Rice", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Jeera Rice", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Kadhi Khichdi", "half": 30, "full": 60, "cat": "VEG"},
    {"name": "Dal Pulav", "half": 50, "full": 100, "cat": "VEG"},
    {"name": "Plain Rice", "half": 30, "full": 60, "cat": "VEG"},
    {"name": "Special Roti", "half": 15, "full": 15, "cat": "ROTI"},
    {"name": "Special Paratha", "half": 20, "full": 20, "cat": "ROTI"},
    {"name": "Butter Roti", "half": 15, "full": 15, "cat": "ROTI"},
    {"name": "Chapati Roti", "half": 7, "full": 7, "cat": "ROTI"},
    {"name": "Papad Fry", "half": 10, "full": 10, "cat": "ROTI"},
  ];

  List<Map<String, dynamic>> get filteredMenu {
    if (selectedCat == "ALL") return menu;
    return menu.where((e) => e['cat'] == selectedCat).toList();
  }

  double get total => cart.fold(0, (s, e) => s + (e['price'] * e['qty']));

  void addToCart(Map<String, dynamic> item, bool isFull) {
    setState(() {
      int price = isFull? item['full'] : item['half'];
      String name = "${item['name']} ${isFull? '(Full)' : '(Half)'}";
      var idx = cart.indexWhere((c) => c['name'] == name);
      if (idx >= 0) cart[idx]['qty']++; else cart.add({"name": name, "price": price, "qty": 1});
    });
  }

  void makeBill() {
    if (cart.isEmpty) return;
    setState(() {
      orders.add({"table": selTable, "items": List.from(cart), "total": total, "time": DateTime.now().toString().substring(11,16)});
      cart.clear(); nav = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("KGN TAWA FRY - ${menu.length} Items"), backgroundColor: Colors.deepOrange),
      body: [buildHome(), buildMenuPage(), buildBills()][nav],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav, onTap: (i) => setState(() => nav = i), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.deepOrange,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu (59)'), BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Bills')],
      ),
    );
  }

  Widget buildHome() {
    double todaySale = orders.fold(0.0, (s, o) => s + o['total']);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [infoCard("Today's Sale", "Rs $todaySale"), infoCard("Orders", "${orders.length}"), infoCard("Items", "${menu.length}")]),
        const SizedBox(height: 16),
        if (cart.isNotEmpty) Expanded(child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [Text("Bill - $selTable", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Expanded(child: ListView(children: cart.map((e) => ListTile(dense: true, title: Text(e['name']), trailing: Text("Rs ${e['price'] * e['qty']} x ${e['qty']}"))).toList())), Text("Total: Rs $total", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: makeBill, child: const Text("PRINT BILL")))])))),
        if (cart.isEmpty) const Expanded(child: Center(child: Text("Menu se item add karo"))),
      ]),
    );
  }

  Widget infoCard(String t, String v) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Text(t, style: const TextStyle(color: Colors.grey)), Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))])));

  Widget buildMenuPage() {
    return Column(
      children: [
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: ["ALL","CHICKEN","MUTTON","FISH","ANDA","VEG","ROTI"].map((c) => Padding(padding: const EdgeInsets.all(4), child: ChoiceChip(label: Text(c), selected: selectedCat == c, onSelected: (v) => setState(() => selectedCat = c)))).toList())),
        Expanded(child: ListView.builder(itemCount: filteredMenu.length, itemBuilder: (c,i) {
          var item = filteredMenu[i];
          return Card(child: ListTile(title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text("${item['cat']} - Half: Rs ${item['half']} | Full: Rs ${item['full']}"), trailing: Row(mainAxisSize: MainAxisSize.min, children: [ElevatedButton(onPressed: () => addToCart(item, false), child: Text("H ${item['half']}")), const SizedBox(width: 4), ElevatedButton(onPressed: () => addToCart(item, true), child: Text("F ${item['full']}"))])));
        })),
      ],
    );
  }

  Widget buildBills() {
    if (orders.isEmpty) return const Center(child: Text("Abhi tak koi bill nahi"));
    return ListView.builder(itemCount: orders.length, itemBuilder: (c,i) => Card(child: ListTile(title: Text("${orders[i]['table']} - Rs ${orders[i]['total']}"), subtitle: Text(orders[i]['time']), trailing: const Icon(Icons.print))));
  }
}
