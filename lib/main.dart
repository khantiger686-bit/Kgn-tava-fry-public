import 'package:flutter/material.dart';

void main() => runApp(KGNApp());

class KGNApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN Tawa Fry',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Roboto'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> menu = [
    {"name": "Chicken Tawa Fry", "price": 250, "veg": false},
    {"name": "Chicken Tandoori", "price": 300, "veg": false},
    {"name": "Egg Tawa Fry", "price": 150, "veg": false},
    {"name": "Chicken Biryani", "price": 200, "veg": false},
    {"name": "Veg Pulao", "price": 120, "veg": true},
  ];

  List<Map> cart = [];

  int get total => cart.fold(0, (sum, item) => sum + item['price'] as int);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.orange[50],
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Welcome to KGN Tawa Fry", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Vadodara's Famous Taste", style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menu.length,
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(menu[i]['veg']? Icons.eco : Icons.restaurant, color: menu[i]['veg']? Colors.green : Colors.red),
                    title: Text(menu[i]['name'], style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("Rs. ${menu[i]['price']}"),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
                      onPressed: () { setState(() => cart.add(menu[i])); },
                      child: Text("ADD", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: cart.isEmpty? null : Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], padding: EdgeInsets.all(16)),
          onPressed: () {
            showDialog(context: context, builder: (_) => AlertDialog(
              title: Text("Order Placed!"),
              content: Text("Total Rs. $total\n\nThank you for ordering from KGN Tawa Fry!"),
              actions: [TextButton(onPressed: (){ setState(() => cart.clear()); Navigator.pop(context); }, child: Text("OK"))],
            ));
          },
          child: Text("PLACE ORDER - Rs. $total (${cart.length} items)", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
