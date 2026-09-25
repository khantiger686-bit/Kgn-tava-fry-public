import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: KGNApp()));

class KGNApp extends StatefulWidget {
  const KGNApp({super.key});
  @override State<KGNApp> createState() => _KGNAppState();
}

class _KGNAppState extends State<KGNApp> {
  List<Map> cart = [];

  List<Map> menu = [
    {"name": "Murgh Do Pyaza", "price": 320},
    {"name": "Murgh Moghlai", "price": 300},
    {"name": "Chicken Handi", "price": 320},
    {"name": "Chicken Pisawar", "price": 320},
    {"name": "Murgh Shahi Chicken", "price": 320},
    {"name": "Chicken Malai Tikka", "price": 350},
    {"name": "Chicken Tikka Masala", "price": 320},
    {"name": "Chicken Kadhai", "price": 300},
    {"name": "Chicken Garlic", "price": 300},
    {"name": "Chicken India", "price": 450},
    {"name": "Butter Chicken Boneless", "price": 320},
    {"name": "White Chicken", "price": 350},
    {"name": "Green Chicken", "price": 350},
    {"name": "Chicken Fry", "price": 220},
    {"name": "Chicken Masala", "price": 220},
    {"name": "Chicken Biryani", "price": 120},
    {"name": "Chicken Tandoori Masala", "price": 480},
    {"name": "Chicken Amdavadi Masala", "price": 300},
    {"name": "Chicken Tikka Rice", "price": 320},
    {"name": "Moghlai Mutton", "price": 280},
    {"name": "DalBati Gos", "price": 280},
    {"name": "White Mutton", "price": 300},
    {"name": "Green Mutton", "price": 280},
    {"name": "Mutton Kurma", "price": 300},
    {"name": "Mutton Fry", "price": 220},
    {"name": "Mutton Masala", "price": 220},
    {"name": "Kaleji Masala", "price": 220},
    {"name": "Bhaji Gos", "price": 240},
    {"name": "Paya Fry", "price": 220},
    {"name": "Champ Fry", "price": 220},
    {"name": "Bheja Fry", "price": 240},
    {"name": "Boti Masala", "price": 220},
    {"name": "Kheema Fry", "price": 160},
    {"name": "Kheema Pulav", "price": 180},
    {"name": "Machhi Fry", "price": 160},
    {"name": "Machhi Kadhi", "price": 200},
    {"name": "Jhinga Fry", "price": 240},
    {"name": "Jhinga Rice", "price": 320},
    {"name": "Anda Kadhi", "price": 160},
    {"name": "Anda Kheema", "price": 160},
    {"name": "Anda Bhurji", "price": 100},
    {"name": "Anda Pulav", "price": 120},
    {"name": "Dal Tadka", "price": 140},
    {"name": "Dal Gotala", "price": 160},
    {"name": "Butter Dal Fry", "price": 140},
    {"name": "Dal Fry", "price": 100},
    {"name": "Sabji Fry", "price": 100},
    {"name": "Sev Tameta", "price": 100},
    {"name": "Masala Rice", "price": 100},
    {"name": "Biryani Rice", "price": 100},
    {"name": "Jeera Rice", "price": 100},
    {"name": "Kadhi Khichdi", "price": 60},
    {"name": "Dal Pulav", "price": 100},
    {"name": "Plain Rice", "price": 60},
    {"name": "Special Roti", "price": 15},
    {"name": "Special Paratha", "price": 20},
    {"name": "Butter Roti", "price": 15},
    {"name": "Chapati Roti", "price": 7},
    {"name": "Papad Fry", "price": 10},
  ];

  int get total => cart.fold(0, (s, e) => s + e['price'] as int);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("KGN TAWA FRY - 59 ITEMS (${menu.length})"), backgroundColor: Colors.deepOrange),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: menu.length,
            itemBuilder: (c,i) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Text("${i+1}")),
                title: Text(menu[i]['name']),
                trailing: ElevatedButton(
                  onPressed: (){setState(()=>cart.add(menu[i]));},
                  child: Text("Rs ${menu[i]['price']}"),
                ),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.black, padding: const EdgeInsets.all(16),
          child: Row(children: [
            Text("Cart: ${cart.length} | Total: Rs $total", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            ElevatedButton(onPressed: (){setState(()=>cart.clear()); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bill Done Rs $total")));}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("BILL")),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: ()=>setState(()=>cart.clear()), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("CLEAR")),
          ]),
        )
      ]),
    );
  }
}
