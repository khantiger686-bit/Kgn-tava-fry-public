import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGNMasterApp()));

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

  // DATA
  List<String> cats = ["All","Chicken Item","Mutton Item","Fish Item","Anda Item","Veg Item","Roti Item"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> payTypes = ["Cash","UPI","PhonePe","Google Pay","Card","Others"];

  // All 59 items with Half/Full
  List<Map> menu = [
    {"name": "Murgh Do Pyaza", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Murgh Moghlai", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken Handi", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Chicken Pisawar", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Murgh Shahi Chicken", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Chicken Malai Tikka", "half": 180, "full": 350, "cat": "Chicken Item"},
    {"name": "Chicken Tikka Masala", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "Chicken Kadhai", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken Garlic", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken India", "half": 250, "full": 450, "cat": "Chicken Item"},
    {"name": "Butter Chicken Boneless", "half": 170, "full": 320, "cat": "Chicken Item"},
    {"name": "White Chicken", "half": 180, "full": 350, "cat": "Chicken Item"},
    {"name": "Green Chicken", "half": 180, "full": 350, "cat": "Chicken Item"},
    {"name": "Chicken Fry", "half": 120, "full": 220, "cat": "Chicken Item"},
    {"name": "Chicken Masala", "half": 120, "full": 220, "cat": "Chicken Item"},
    {"name": "Chicken Biryani", "half": 80, "full": 120, "cat": "Chicken Item"},
    {"name": "Chicken Tandoori Masala", "half": 250, "full": 480, "cat": "Chicken Item"},
    {"name": "Chicken Amdavadi Masala", "half": 160, "full": 300, "cat": "Chicken Item"},
    {"name": "Chicken Tikka Rice", "half": 170, "full": 320, "cat": "Chicken Item"},
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
  int get totalItems => currentOrder.fold(0, (s, e) => s + e['qty'] as int);
  int get subTotal => currentOrder.fold(0, (s, e) => s + (e['price'] as int * e['qty'] as int));
  List<Map> get filtered => menu.where((m) => (selectedCat=="All" || m['cat']==selectedCat) && m['name'].toString().toLowerCase().contains(searchQ.toLowerCase())).toList();

  void addToCart(Map item, bool isFull){
    setState(() {
      String name = "${item['name']} ${isFull? '(F)' : '(H)'}";
      int price = isFull? item['full'] : item['half'];
      int idx = currentOrder.indexWhere((e) => e['name']==name);
      if(idx>=0) currentOrder[idx]['qty']++;
      else currentOrder.add({"name": name, "price": price, "qty": 1, "cat": item['cat']});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: navIndex==0? buildHome() : navIndex==1? buildItems() : navIndex==2? buildOrderPage() : navIndex==3? buildReports() : buildMore(),
      bottomNavigationBar: BottomNavigationBar(currentIndex: navIndex, type: BottomNavigationBarType.fixed, selectedItemColor: Colors.blue, onTap: (i)=>setState(()=>navIndex=i), items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Items"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40, color: Colors.blue), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
      ]),
    );
  }

  // HOME - Dashboard like video
  Widget buildHome(){
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), const Icon(Icons.keyboard_arrow_down), const Spacer(), CircleAvatar(backgroundColor: Colors.blue.shade100, child: const Text("K"))]),
      const SizedBox(height: 16),
      const Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        quickBtn(Icons.check_circle, "Closed Orders", "${closedBills.length}"),
        quickBtn(Icons.access_time, "On Hold Orders", "${tableOrders.values.where((e) => e.isNotEmpty).length}"),
        quickBtn(Icons.add_circle, "Add Items", "${menu.length}"),
      ]),
      const SizedBox(height: 16),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Row(children: [const Icon(Icons.store, size: 16), const SizedBox(width: 6), const Text("Business Overview", style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Text("${DateTime.now().day}/${DateTime.now().month}", style: const TextStyle(fontSize: 12))]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Today's sales", style: TextStyle(color
