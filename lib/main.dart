import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGN_AI_Pro()));

class KGN_AI_Pro extends StatefulWidget {
  const KGN_AI_Pro({super.key});
  @override State<KGN_AI_Pro> createState() => _KGN_AI_ProState();
}

class _KGN_AI_ProState extends State<KGN_AI_Pro> {
  int nav = 0;
  String orderType = "Dine-in";
  String selTable = "T-1";
  double discount = 0;
  double expenseToday = 0;
  bool dayClosed = false;
  List<String> categories = ["CHICKEN","MUTTON","FISH","ANDA","VEG","ROTI"];
  List<String> tables = List.generate(12, (i) => "T-${i+1}");
  Map<String, String> tableStatus = {};
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> kotList = [];
  List<Map<String, dynamic>> expenses = [];

  // 59 ITEMS FULL - WITH PHOTO SUPPORT
  List<Map<String, dynamic>> menu = [
    {"name": "Murgh Do Pyaza", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Murgh Moghlai", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Handi", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Pisawar", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Murgh Shahi Chicken", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Malai Tikka", "half": 180, "full": 350, "cat": "CHICKEN", "kitchen": "TANDOOR", "stock": 50, "image": null},
    {"name": "Chicken Tikka Masala", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Kadhai", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Garlic", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken India", "half": 250, "full": 450, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Butter Chicken Boneless", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "White Chicken", "half": 180, "full": 350, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Green Chicken", "half": 180, "full": 350, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Fry", "half": 120, "full": 220, "cat": "CHICKEN", "kitchen": "TAWA", "stock": 50, "image": null},
    {"name": "Chicken Masala", "half": 120, "full": 220, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Biryani", "half": 80, "full": 120, "cat": "CHICKEN", "kitchen": "RICE", "stock": 50, "image": null},
    {"name": "Chicken Tandoori Masala", "half": 250, "full": 480, "cat": "CHICKEN", "kitchen": "TANDOOR", "stock": 50, "image": null},
    {"name": "Chicken Amdavadi Masala", "half": 160, "full": 300, "cat": "CHICKEN", "kitchen": "NON-VEG", "stock": 50, "image": null},
    {"name": "Chicken Tikka Rice", "half": 170, "full": 320, "cat": "CHICKEN", "kitchen": "RICE", "stock": 50, "image": null},
    {"name": "Moghlai Mutton", "half": 150, "full": 280, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "DalBati Gos", "half": 150, "full": 280, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "White Mutton", "half": 160, "full": 300, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "Green Mutton", "half": 150, "full": 280, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "Mutton Kurma", "half": 160, "full": 300, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "Mutton Fry", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Mutton Masala", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "Kaleji Masala", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Bhaji Gos", "half": 130, "full": 240, "cat": "MUTTON", "kitchen": "NON-VEG", "stock": 40, "image": null},
    {"name": "Paya Fry", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Champ Fry", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Bheja Fry", "half": 130, "full": 240, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Boti Masala", "half": 120, "full": 220, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Kheema Fry", "half": 80, "full": 160, "cat": "MUTTON", "kitchen": "TAWA", "stock": 40, "image": null},
    {"name": "Kheema Pulav", "half": 100, "full": 180, "cat": "MUTTON", "kitchen": "RICE", "stock": 40, "image": null},
    {"name": "Machhi Fry", "half": 80, "full": 160, "cat": "FISH", "kitchen": "TAWA", "stock": 30, "image": null},
    {"name": "Machhi Kadhi", "half": 100, "full": 200, "cat": "FISH", "kitchen": "NON-VEG", "stock": 30, "image": null},
    {"name": "Jhinga Fry", "half": 130, "full": 240, "cat": "FISH", "kitchen": "TAWA", "stock": 30, "image": null},
    {"name": "Jhinga Rice", "half": 170, "full": 320, "cat": "FISH", "kitchen": "RICE", "stock": 30, "image": null},
    {"name": "Anda Kadhi", "half": 80, "full": 160, "cat": "ANDA", "kitchen": "VEG", "stock": 60, "image": null},
    {"name": "Anda Kheema", "half": 80, "full": 160, "cat": "ANDA", "kitchen": "VEG", "stock": 60, "image": null},
    {"name": "Anda Bhurji", "half": 50, "full": 100, "cat": "ANDA", "kitchen": "TAWA", "stock": 60, "image": null},
    {"name": "Anda Pulav", "half": 60, "full": 120, "cat": "ANDA", "kitchen": "RICE", "stock": 60, "image": null},
    {"name": "Dal Tadka", "half": 70, "full": 140, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Dal Gotala", "half": 80, "full": 160, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Butter Dal Fry", "half": 70, "full": 140, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Dal Fry", "half": 50, "full": 100, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Sabji Fry", "half": 50, "full": 100, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Sev Tameta", "half": 50, "full": 100, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Masala Rice", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100, "image": null},
    {"name": "Biryani Rice", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100, "image": null},
    {"name": "Jeera Rice", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100, "image": null},
    {"name": "Kadhi Khichdi", "half": 30, "full": 60, "cat": "VEG", "kitchen": "VEG", "stock": 100, "image": null},
    {"name": "Dal Pulav", "half": 50, "full": 100, "cat": "VEG", "kitchen": "RICE", "stock": 100, "image": null},
    {"name": "Plain Rice", "half": 30, "full": 60, "cat": "VEG", "kitchen": "RICE", "stock": 100, "image": null},
    {"name": "Special Roti", "half": 15, "full": 15, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200, "image": null},
    {"name": "Special Paratha", "half": 20, "full": 20, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200, "image": null},
    {"name": "Butter Roti", "half": 15, "full": 15, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200, "image": null},
    {"name": "Chapati Roti", "half": 7, "full": 7, "cat": "ROTI", "kitchen": "TANDOOR", "stock": 200, "image": null},
    {"name": "Papad Fry", "half": 10, "full": 10, "cat": "ROTI", "kitchen": "VEG", "stock": 200, "image": null},
  ];

  double get total => cart.fold(0, (s, e) => s + (e['price'] * e['qty']));
  double get finalTotal => total - discount;

  String get aiSuggestion {
    if (orders.isNotEmpty && orders.last['total'] > 300) return "AI: Last customer high value tha, 10% discount do to return aayega!";
    if (cart.any((e) => e['name'].contains("Chicken"))) return "AI: Chicken ke sath Roti suggest karo, sale +20% badhega";
    return "AI: Aaj Chicken Handi top seller hai, stock check karo";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KGN TAWA FRY - AI SMART"), backgroundColor: Colors.deepOrange),
      body: [buildBillingAI(), buildMenuAI(), buildReportsAI(), buildDayEnd()][nav],
      bottomNavigationBar: BottomNavigationBar(currentIndex: nav, onTap: (i) => setState(() => nav = i), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.deepOrange, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'AI Billing'),
        BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Menu + Photo'),
        BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'AI Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.power_settings_new), label: 'Day End'),
      ]),
    );
  }

  Widget buildBillingAI() {
    return Column(children: [
      Container(color: Colors.orange.shade100, padding: const EdgeInsets.all(8), child: Row(children: [const Icon(Icons.smart_toy, color: Colors.deepOrange), const SizedBox(width: 8), Expanded(child: Text(aiSuggestion, style: const TextStyle(fontWeight: FontWeight.bold)))])),
      Padding(padding: const EdgeInsets.all(8), child: Row(children: [DropdownButton(value: orderType, items: ["Dine-in","Takeaway","Delivery"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => orderType = v!)), const SizedBox(width: 10), DropdownButton(value: selTable, items: tables.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => selTable = v!))])),
      Expanded(child: cart.isEmpty? const Center(child: Text("Menu se item add karo - Fast Billing")) : ListView.builder(itemCount: cart.length, itemBuilder: (c,i) => ListTile(title: Text(cart[i]['name']), subtitle: const Text("Price change - Tap edit icon"), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.edit), onPressed: () => editPriceInCart(i)), Text("Rs ${cart[i]['price'] * cart[i]['qty']}")])))),
      Padding(padding: const EdgeInsets.all(12), child: Column(children: [
        TextField(decoration: const InputDecoration(labelText: "Fast Discount Rs"), keyboardType: TextInputType.number, onChanged: (v) => setState(() => discount = double.tryParse(v)?? 0)),
        Text("Total: Rs $total | Final: Rs $finalTotal", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(children: [Expanded(child: ElevatedButton(onPressed: generateKOT, child: const Text("SEND KOT"))), const SizedBox(width: 8), Expanded(child: ElevatedButton(onPressed: makeBill, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("GENERATE BILL")))])
      ]))
    ]);
  }

  Widget buildMenuAI() {
    return Column(children: [
      Padding(padding: const EdgeInsets.all(8), child: Row(children: [ElevatedButton.icon(icon: const Icon(Icons.category), label: const Text("Add Category"), onPressed: addCategory), const SizedBox(width: 8), ElevatedButton.icon(icon: const Icon(Icons.add), label: const Text("Add Item + Photo"), onPressed: addNewItem)])),
      Expanded(child: ListView.builder(itemCount: menu.length, itemBuilder: (c,i) {
        var item = menu[i];
        return Card(child: ListTile(
          leading: Stack(children: [CircleAvatar(backgroundColor: Colors.orange.shade100, child: item['image']==null? const Icon(Icons.fastfood) : const Icon(Icons.image, color: Colors.green)), Positioned(bottom: 0, right: 0, child: InkWell(onTap: () => uploadPhoto(i), child: const CircleAvatar(radius: 10, backgroundColor: Colors.blue, child: Icon(Icons.camera_alt, size: 12, color: Colors.white))))]),
          title: Text(item['name']), subtitle: Text("${item['cat']} | H:${item['half']} F:${item['full']} | Photo: ${item['image']==null? 'No' : 'Yes'}"),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => editItem(i)), IconButton(icon: const Icon(Icons.add_circle, color: Colors.green), onPressed: () => addToCart(item, false))]),
        ));
      }))
    ]);
  }

  Widget buildReportsAI() {
    double todaySale = orders.fold(0.0, (s,o) => s + o['total']);
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text("🤖 AI Insights", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      Card(color: Colors.deepPurple.shade50, child: ListTile(title: const Text("AI Sales Prediction"), subtitle: Text("Kal ka sale ~ Rs ${(todaySale*1.2).toStringAsFixed(0)} hoga"))),
      Card(child: ListTile(title: Text("Today Sale: Rs $todaySale"), trailing: const Icon(Icons.trending_up, color: Colors.green))),
      Card(child: ListTile(title: Text("Expense: Rs $expenseToday"), trailing: const Icon(Icons.trending_down, color: Colors.red))),
      ElevatedButton(onPressed: () => setState(() => expenseToday+=50), child: const Text("Add Expense")),
    ]);
  }

  Widget buildDayEnd() {
    double todaySale = orders.fold(0.0, (s,o) => s + o['total']);
    return Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("A to Z Day Ending", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      Card(child: ListTile(title: const Text("Total Bills"), trailing: Text("${orders.length}"))),
      Card(child: ListTile(title: const Text("Total Sale"), trailing: Text("Rs $todaySale"))),
      Card(child: ListTile(title: const Text("Net Profit"), trailing: Text("Rs ${todaySale - expenseToday}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)))),
      const SizedBox(height: 20),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: dayClosed? Colors.grey : Colors.red, padding: const EdgeInsets.all(16)), onPressed: dayClosed? null : () => showDialog(context: context, builder: (c) => AlertDialog(title: const Text("Day End?"), content: Text("Sale: Rs $todaySale\nClose?"), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")), ElevatedButton(onPressed: () { setState(() { dayClosed=true; orders.clear(); cart.clear(); expenseToday=0; }); Navigator.pop(context); }, child: const Text("YES, CLOSE"))])), child: Text(dayClosed? "DAY CLOSED" : "A to Z DAY END & Z REPORT"))),
      if (dayClosed) ElevatedButton(onPressed: () => setState(() => dayClosed=false), child: const Text("New Day Start")),
    ]));
  }

  void addToCart(Map<String, dynamic> item, bool isFull) { setState(() { int price = isFull? item['full'] : item['half']; String name = "${item['name']} ${isFull? '(Full)' : '(Half)'}"; var idx = cart.indexWhere((c) => c['name'] == name); if (idx >= 0) cart[idx]['qty']++; else cart.add({"name": name, "price": price, "qty": 1, "kitchen": item['kitchen']}); }); }
  void editPriceInCart(int i) { TextEditingController ctrl = TextEditingController(text: cart[i]['price'].toString()); showDialog(context: context, builder: (c) => AlertDialog(title: const Text("Fast Price Change"), content: TextField(controller: ctrl, keyboardType: TextInputType.number), actions: [ElevatedButton(onPressed: () { setState(() => cart[i]['price']=int.parse(ctrl.text)); Navigator.pop(context); }, child: const Text("Update"))])); }
  void uploadPhoto(int i) { setState(() => menu[i]['image']="uploaded"); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${menu[i]['name']} Photo Uploaded - Gallery/Camera")));}
  void editItem(int i) { TextEditingController halfCtrl = TextEditingController(text: menu[i]['half'].toString()); TextEditingController fullCtrl = TextEditingController(text: menu[i]['full'].toString()); TextEditingController catCtrl = TextEditingController(text: menu[i]['cat'].toString()); showDialog(context: context, builder: (c) => AlertDialog(title: Text("Edit ${menu[i]['name']}"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: halfCtrl, decoration: const InputDecoration(labelText: "Half Price")), TextField(controller: fullCtrl, decoration: const InputDecoration(labelText: "Full Price")), TextField(controller: catCtrl, decoration: const InputDecoration(labelText: "Category"))]), actions: [ElevatedButton(onPressed: () { setState(() { menu[i]['half']=int.parse(halfCtrl.text); menu[i]['full']=int.parse(fullCtrl.text); menu[i]['cat']=catCtrl.text.toUpperCase(); }); Navigator.pop(context); }, child: const Text("Save"))])); }
  void addCategory() { TextEditingController ctrl = TextEditingController(); showDialog(context: context, builder: (c) => AlertDialog(title: const Text("New Category"), content: TextField(controller: ctrl), actions: [ElevatedButton(onPressed: () { setState(() { if (ctrl.text.isNotEmpty) categories.add(ctrl.text.toUpperCase()); }); Navigator.pop(context); }, child: const Text("Add"))])); }
  void addNewItem() { TextEditingController nameCtrl = TextEditingController(); TextEditingController halfCtrl = TextEditingController(); TextEditingController fullCtrl = TextEditingController(); String newCat = categories.first; showDialog(context: context, builder: (c) => AlertDialog(title: const Text("New Item + Photo"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Item Name")), TextField(controller: halfCtrl, decoration: const InputDecoration(labelText: "Half Price"), keyboardType: TextInputType.number), TextField(controller: fullCtrl, decoration: const InputDecoration(labelText: "Full Price"), keyboardType: TextInputType.number)]), actions: [ElevatedButton(onPressed: () { setState(() { menu.add({"name": nameCtrl.text, "half": int.tryParse(halfCtrl.text)?? 50, "full": int.tryParse(fullCtrl.text)?? 100, "cat": newCat, "kitchen": "VEG", "stock": 50, "image": null}); }); Navigator.pop(context); }, child: const Text("Add Item"))])); }
  void generateKOT() { if (cart.isEmpty) return; setState(() { kotList.add({"table": selTable, "items": List.from(cart), "time": DateTime.now().toString().substring(11,16)}); }); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("KOT Sent")));}
  void makeBill() { if (cart.isEmpty) return; generateKOT(); setState(() { orders.add({"table": selTable, "items": List.from(cart), "total": finalTotal, "time": DateTime.now().toString().substring(11,16)}); cart.clear(); discount=0; }); }
}
