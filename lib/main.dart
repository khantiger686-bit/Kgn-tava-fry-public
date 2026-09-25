import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGNFinal()));

class KGNFinal extends StatefulWidget {
  const KGNFinal({super.key});
  @override State<KGNFinal> createState() => _KGNFinalState();
}

class _KGNFinalState extends State<KGNFinal> {
  String selectedTable = "T-1";
  String selectedCat = "ALL";
  List<String> categories = ["ALL","CHICKEN","MUTTON","FISH","ANDA","VEG","ROTI"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];

  // Har table ka alag cart
  Map<String, List<Map>> tableCarts = {
    "T-1": [], "T-2": [], "T-3": [], "T-4": [], "T-5": [], "T-6": [],
  };

  List<Map> menu = [
    {"name": "Murgh Do Pyaza", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Murgh Moghlai", "half": 160, "full": 300, "cat": "CHICKEN"},
    {"name": "Chicken Handi", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Chicken Pisawar", "half": 170, "full": 320, "cat": "CHICKEN"},
    {"name": "Murgh Shahi", "half": 170, "full": 320, "cat": "CHICKEN"},
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
    {"name": "Chicken Amdavadi", "half": 160, "full": 300, "cat": "CHICKEN"},
    {"name": "Chicken Tikka Rice", "half": 170, "full": 320, "cat": "CHICKEN"},
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
    {"name": "Machhi Fry", "half": 80, "full": 160, "cat": "FISH"},
    {"name": "Machhi Kadhi", "half": 100, "full": 200, "cat": "FISH"},
    {"name": "Jhinga Fry", "half": 130, "full": 240, "cat": "FISH"},
    {"name": "Jhinga Rice", "half": 170, "full": 320, "cat": "FISH"},
    {"name": "Anda Kadhi", "half": 80, "full": 160, "cat": "ANDA"},
    {"name": "Anda Kheema", "half": 80, "full": 160, "cat": "ANDA"},
    {"name": "Anda Bhurji", "half": 50, "full": 100, "cat": "ANDA"},
    {"name": "Anda Pulav", "half": 60, "full": 120, "cat": "ANDA"},
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

  List<Map> get currentCart => tableCarts[selectedTable]!;
  List<Map> get filteredMenu => selectedCat == "ALL"? menu : menu.where((m) => m['cat'] == selectedCat).toList();
  int get total => currentCart.fold(0, (s, e) => s + e['price'] as int);

  void addToCart(Map item, bool isFull) {
    setState(() {
      tableCarts[selectedTable]!.add({
        "name": "${item['name']} ${isFull? '(Full)' : '(Half)'}",
        "price": isFull? item['full'] : item['half']
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$selectedTable - Rs $total | Items: ${currentCart.length}"),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(icon: const Icon(Icons.category), onPressed: addCategoryDialog),
          IconButton(icon: const Icon(Icons.add), onPressed: addItemDialog),
        ],
      ),
      body: Column(children: [
        // 6 TABLES
        Container(
          height: 60, color: Colors.orange.shade100,
          child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: tables.length, itemBuilder: (c,i){
            String t = tables[i];
            bool hasOrder = tableCarts[t]!.isNotEmpty;
            bool isSelected = t == selectedTable;
            return GestureDetector(
              onTap: () => setState(()=>selectedTable = t),
              child: Container(
                width: 80, margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: isSelected? Colors.deepOrange : hasOrder? Colors.green : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected || hasOrder? Colors.white : Colors.black)), Text(hasOrder? "${tableCarts[t]!.length} items" : "Empty", style: TextStyle(fontSize: 10, color: isSelected || hasOrder? Colors.white : Colors.black))]),
              ),
            );
          }),
        ),
        // CATEGORY FILTER
        SizedBox(height: 45, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: categories.length, itemBuilder: (c,i) => Padding(padding: const EdgeInsets.all(4), child: ChoiceChip(label: Text(categories[i]), selected: selectedCat == categories[i], onSelected: (v) => setState(()=>selectedCat = categories[i]))))),

        // MENU WITH HALF/FULL
        Expanded(child: ListView.builder(itemCount: filteredMenu.length, itemBuilder: (c,i){
          var m = filteredMenu[i];
          return Card(child: ListTile(title: Text(m['name']), subtitle: Text("${m['cat']} | Half: Rs ${m['half']} | Full: Rs ${m['full']}"), trailing: Row(mainAxisSize: MainAxisSize.min, children: [ElevatedButton(onPressed: ()=>addToCart(m,false), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: Text("H ${m['half']}")), const SizedBox(width: 4), ElevatedButton(onPressed: ()=>addToCart(m,true), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text("F ${m['full']}"))])));
        })),

        // HOLD + BILL
        Container(color: Colors.black, padding: const EdgeInsets.all(10), child: Column(children: [
          Text("$selectedTable Cart: ${currentCart.length} items", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 6),
          Row(children: [
            Expanded(child: ElevatedButton.icon(icon: const Icon(Icons.pause), label: const Text("HOLD TABLE"), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$selectedTable Hold par hai, dusri table select karo"))); })),
            const SizedBox(width: 8),
            Expanded(child: ElevatedButton.icon(icon: const Icon(Icons.receipt), label: Text("BILL Rs $total"), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: (){ setState(()=>tableCarts[selectedTable]!.clear()); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$selectedTable Bill Done!"))); })),
          ])
        ]))
      ]),
    );
  }

  void addCategoryDialog(){
    TextEditingController ctrl = TextEditingController();
    showDialog(context: context, builder: (c)=>AlertDialog(title: const Text("Add Category"), content: TextField(controller: ctrl, decoration: const InputDecoration(hintText: "e.g. STARTER")), actions: [ElevatedButton(onPressed: (){ if(ctrl.text.isNotEmpty){setState(()=>categories.add(ctrl.text.toUpperCase()));} Navigator.pop(context); }, child: const Text("Add"))]));
  }

  void addItemDialog(){
    TextEditingController name = TextEditingController();
    TextEditingController half = TextEditingController();
    TextEditingController full = TextEditingController();
    String cat = categories[1];
    showDialog(context: context, builder: (c)=>AlertDialog(title: const Text("Add New Item"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: name, decoration: const InputDecoration(labelText: "Item Name")), TextField(controller: half, decoration: const InputDecoration(labelText: "Half Price"), keyboardType: TextInputType.number), TextField(controller: full, decoration: const InputDecoration(labelText: "Full Price"), keyboardType: TextInputType.number)]), actions: [ElevatedButton(onPressed: (){ setState(()=>menu.add({"name": name.text, "half": int.tryParse(half.text)??0, "full": int.tryParse(full.text)??0, "cat": cat})); Navigator.pop(context); }, child: const Text("Add Item"))]));
  }
}
