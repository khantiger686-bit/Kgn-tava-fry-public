import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(KGNApp());

class KGNApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN TAWA FRY',
      theme: ThemeData(primarySwatch: Colors.deepOrange, useMaterial3: true),
      home: MainScreen(),
    );
  }
}

class MenuItem {
  String name; String category; double price; String variant;
  MenuItem({required this.name, required this.category, required this.price, this.variant = ''});
  Map toJson() => {'name': name, 'category': category, 'price': price, 'variant': variant};
  factory MenuItem.fromJson(Map j) => MenuItem(name: j['name'], category: j['category'], price: j['price'].toDouble(), variant: j['variant']??'');
}
class CartItem { MenuItem item; int qty; CartItem(this.item, this.qty); }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  List<MenuItem> allItems = [];
  List<CartItem> cart = [];
  List<Map> closedOrders = [];
  List<Map> onHoldOrders = [];
  double todaySale = 0;

  @override
  void initState() { super.initState(); _loadData(); }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<MenuItem> defaults = [];
    var cats = {
      'CHICKEN ITEM': ['Chicken Tawa Fry', 'Chicken Masala', 'Chicken Handi', 'Chicken Tikka', 'Chicken Lollypop', 'Chicken 65', 'Chicken Crispy'],
      'MUTTON': ['Mutton Tawa Fry', 'Mutton Masala', 'Mutton Handi', 'Mutton Chap', 'Mutton Korma'],
      'PRAWNS': ['Prawns Fry', 'Prawns Masala', 'Prawns Handi'],
      'EGG': ['Egg Masala', 'Egg Fry', 'Egg Bhurji', 'Egg Curry'],
      'RICE': ['Chicken Biryani Full', 'Chicken Biryani Half', 'Mutton Biryani Full', 'Mutton Biryani Half', 'Jeera Rice', 'Veg Pulao'],
      'ROTI': ['Chapati', 'Roti', 'Naan', 'Paratha', 'Roomali Roti']
    };
    cats.forEach((cat, names) {
      for (var n in names) {
        defaults.add(MenuItem(name: n, category: cat, price: n.contains('Full')? 280 : n.contains('Half')? 150 : 200));
      }
    });
    while(defaults.length < 177) {
      defaults.add(MenuItem(name: 'Special Item ${defaults.length+1}', category: 'CHICKEN ITEM', price: 200));
    }
    String? saved = prefs.getString('menu');
    if(saved!= null) {
      allItems = (jsonDecode(saved) as List).map((e)=>MenuItem.fromJson(e)).toList();
    } else {
      allItems = defaults;
    }
    setState(() { todaySale = prefs.getDouble('sale')?? 0; });
  }

  void _saveMenu() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('menu', jsonEncode(allItems.map((e)=>e.toJson()).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeTab(todaySale: todaySale, closedCount: closedOrders.length, onHoldCount: onHoldOrders.length, onAddOrder: ()=>setState(()=>_index=2)),
        ItemsTab(items: allItems, onAddItem: (m){ setState(()=>allItems.add(m)); _saveMenu(); }),
        OrderTab(allItems: allItems, cart: cart, onBill: (total){ setState((){ todaySale+=total; closedOrders.add({'total':total}); }); cart.clear(); _index=0; }, onHold: (items){ setState(()=>onHoldOrders.add({'items':items})); cart.clear(); _index=0; }),
        ReportsTab(sale: todaySale, orders: closedOrders.length),
        MoreTab()
      ][_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index, type: BottomNavigationBarType.fixed, selectedItemColor: Colors.deepOrange,
        onTap: (i)=>setState(()=>_index=i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Items'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final double todaySale; final int closedCount; final int onHoldCount; final VoidCallback onAddOrder;
  HomeTab({required this.todaySale, required this.closedCount, required this.onHoldCount, required this.onAddOrder});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: EdgeInsets.all(16), children: [
      Text('KGN TAWA FRY', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Row(children: [
        Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Today sales'), Text('₹${todaySale.toStringAsFixed(0)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))]))),
        SizedBox(width: 12),
        Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Today orders'), Text('$closedCount', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))]))),
      ]),
      SizedBox(height: 20),
      Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      SizedBox(height: 12),
      Row(children: [
        Expanded(child: Container(margin: EdgeInsets.all(6), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)), child: Column(children: [Icon(Icons.receipt, color: Colors.deepOrange), Text('Closed Orders'), Text('$closedCount', style: TextStyle(fontWeight: FontWeight.bold))]))),
        Expanded(child: Container(margin: EdgeInsets.all(6), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)), child: Column(children: [Icon(Icons.pause_circle, color: Colors.deepOrange), Text('On Hold'), Text('$onHoldCount', style: TextStyle(fontWeight: FontWeight.bold))]))),
        Expanded(child: InkWell(onTap: onAddOrder, child: Container(margin: EdgeInsets.all(6), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)), child: Column(children: [Icon(Icons.add_box, color: Colors.deepOrange), Text('Add Items')])))),
      ]),
    ]));
  }
}

class ItemsTab extends StatefulWidget {
  final List<MenuItem> items; final Function(MenuItem) onAddItem;
  ItemsTab({required this.items, required this.onAddItem});
  @override
  _ItemsTabState createState() => _ItemsTabState();
}
class _ItemsTabState extends State<ItemsTab> {
  String selectedCat = 'ALL'; String search = '';
  List<String> get categories => ['ALL',...widget.items.map((e)=>e.category).toSet()];
  @override
  Widget build(BuildContext context) {
    var filtered = widget.items.where((e){ bool catOk = selectedCat=='ALL' || e.category==selectedCat; bool searchOk = e.name.toLowerCase().contains(search.toLowerCase()); return catOk && searchOk; }).toList();
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(12), child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search items...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), onChanged: (v)=>setState(()=>search=v))),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: categories.map((c)=> Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(c, style: TextStyle(fontSize: 11)), selected: selectedCat==c, onSelected: (_)=>setState(()=>selectedCat=c)))).toList())),
      Expanded(child: GridView.builder(padding: EdgeInsets.all(10), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.75, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: filtered.length, itemBuilder: (ctx,i){
        var it = filtered[i];
        return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)), child: Column(children: [
          Expanded(child: Container(decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.vertical(top: Radius.circular(10))), child: Center(child: Icon(Icons.fastfood, size: 40, color: Colors.deepOrange)))),
          Padding(padding: EdgeInsets.all(4), child: Text(it.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          Text('₹${it.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 11, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
        ]));
      })),
      Padding(padding: EdgeInsets.all(10), child: ElevatedButton.icon(onPressed: (){ showDialog(context: context, builder: (_)=>AddItemDialog(onAdd: widget.onAddItem)); }, icon: Icon(Icons.add), label: Text('Add Menu Item'), style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 45))))
    ]));
  }
}

class AddItemDialog extends StatefulWidget {
  final Function(MenuItem) onAdd; AddItemDialog({required this.onAdd});
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}
class _AddItemDialogState extends State<AddItemDialog> {
  final _name = TextEditingController(); final _price = TextEditingController(); String cat = 'CHICKEN ITEM';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text('Add Menu Item'), content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: _name, decoration: InputDecoration(labelText: 'Item Name')),
      TextField(controller: _price, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
      DropdownButton<String>(value: cat, isExpanded: true, items: ['CHICKEN ITEM','MUTTON','PRAWNS','EGG','RICE','ROTI'].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v)=>setState(()=>cat=v!))
    ]), actions: [
      TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
      ElevatedButton(onPressed: (){ widget.onAdd(MenuItem(name: _name.text, category: cat, price: double.tryParse(_price.text)??0)); Navigator.pop(context); }, child: Text('Add'))
    ]);
  }
}

class OrderTab extends StatefulWidget {
  final List<MenuItem> allItems; final List<CartItem> cart; final Function(double) onBill; final Function(List<CartItem>) onHold;
  OrderTab({
