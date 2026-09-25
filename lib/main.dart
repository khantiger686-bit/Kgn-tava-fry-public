import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: TableApp()));

class TableApp extends StatefulWidget {
  const TableApp({super.key});
  @override State<TableApp> createState() => _TableAppState();
}

class _TableAppState extends State<TableApp> {
  String selectedCat = "All";
  String orderMode = "Dine-In";
  String selectedTable = "Select Table";
  String paymentType = "Cash";
  List<String> cats = ["All", "Chicken Item", "Mutton Item", "Fish Item", "Veg Item", "Roti Item"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> payTypes = ["Cash","UPI","PhonePe","Google Pay","Card","Others"];
  bool showCart = false;

  List<Map> menu = [
    {"name": "Chapati Roti", "price": 7, "cat": "Roti Item"},
    {"name": "chaas", "price": 20, "cat": "Veg Item"},
    {"name": "Kheema masala Half", "price": 80, "cat": "Mutton Item"},
    {"name": "Chicken Masala Half", "price": 120, "cat": "Chicken Item"},
    {"name": "chicken Dana", "price": 100, "cat": "Chicken Item"},
    {"name": "mutton seekh kabab", "price": 10, "cat": "Mutton Item"},
    {"name": "water botl badi", "price": 20, "cat": "Veg Item"},
    {"name": "Butter Chicken Boneless Half", "price": 100, "cat": "Chicken Item"},
    {"name": "Bheja masala Half", "price": 130, "cat": "Mutton Item"},
    {"name": "Chicken Handi", "price": 320, "cat": "Chicken Item"},
    {"name": "Chicken Fry", "price": 220, "cat": "Chicken Item"},
    {"name": "Mutton Fry", "price": 220, "cat": "Mutton Item"},
    {"name": "Dal Tadka", "price": 140, "cat": "Veg Item"},
    {"name": "Special Roti", "price": 15, "cat": "Roti Item"},
    {"name": "Papad Fry", "price": 10, "cat": "Roti Item"},
  ];

  Map<String, int> cart = {};

  int get totalItems => cart.values.fold(0, (s,e) => s+e);
  int get subTotal {
    int tot = 0;
    cart.forEach((name, qty){
      var item = menu.firstWhere((m) => m['name']==name);
      tot += (item['price'] as int) * qty;
    });
    return tot;
  }

  List<Map> get filtered => selectedCat=="All"? menu : menu.where((m) => m['cat']==selectedCat).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        title: Text(showCart? "Cart" : "Add Order", style: const TextStyle(color: Colors.black)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: (){ if(showCart) setState(()=>showCart=false); }),
      ),
      body: showCart? buildCartPage() : buildAddOrderPage(),
    );
  }

  Widget buildAddOrderPage(){
    return Column(children: [
      Padding(padding: const EdgeInsets.all(10), child: TextField(decoration: InputDecoration(hintText: "Search", prefixIcon: const Icon(Icons.search), suffixIcon: const Icon(Icons.mic), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
      SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(cats[i]), selected: selectedCat==cats[i], selectedColor: Colors.blue.shade100, onSelected: (v)=>setState(()=>selectedCat=cats[i]))))),
      Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.75, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: filtered.length, itemBuilder: (c,i){
        var m = filtered[i];
        int qty = cart[m['name']]?? 0;
        return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Stack(children: [
            Container(height: 90, decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), image: const DecorationImage(image: NetworkImage("https://via.placeholder.com/150"), fit: BoxFit.cover))),
            Positioned(top: 6, left: 6, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: Text("₹${m['price']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))),
          ]),
          Padding(padding: const EdgeInsets.all(4), child: Text(m['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          const Spacer(),
          qty==0? ElevatedButton(onPressed: ()=>setState(()=>cart[m['name']]=1), style: ElevatedButton.styleFrom(minimumSize: const Size(60, 28), backgroundColor: Colors.white, side: const BorderSide(color: Colors.blue)), child: const Icon(Icons.add, size: 16, color: Colors.blue))
          : Container(decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(onTap: ()=>setState(()=> qty==1? cart.remove(m['name']) : cart[m['name']]=qty-1), child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.remove, size: 14, color: Colors.white))),
            Text("$qty", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            InkWell(onTap: ()=>setState(()=>cart[m['name']]=qty+1), child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.add, size: 14, color: Colors.white))),
          ])),
          const SizedBox(height: 4),
        ]));
      })),
      if(totalItems>0) Container(color: Colors.white, padding: const EdgeInsets.all(12), child: Column(children: [
        InkWell(onTap: ()=>setState(()=>showCart=true), child: Row(children: [Text("View Cart", style: const TextStyle(fontWeight: FontWeight.bold)), const Icon(Icons.arrow_forward_ios, size: 12), const Spacer(), Text("$totalItems Items ₹$subTotal", style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 8), Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.receipt_long)) ])),
        const SizedBox(height: 10),
        Row(children: [Expanded(child: OutlinedButton(onPressed: (){ setState(()=>cart.clear()); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order Saved on Hold"))); }, child: const Text("Save & Hold"))), const SizedBox(width: 10), Expanded(child: ElevatedButton(onPressed: ()=>setState(()=>showCart=true), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text("Save & Bill", style: TextStyle(color: Colors.white))))])
      ]))
    ]);
  }

  Widget buildCartPage(){
    return SingleChildScrollView(child: Column(children: [
      SizedBox(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cart.length, itemBuilder: (c,i){
        String name = cart.keys.elementAt(i);
        var item = menu.firstWhere((m) => m['name']==name);
        int qty = cart[name]!;
        return Container(width: 90, margin: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Stack(children: [Container(height: 50, decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: const BorderRadius.vertical(top: Radius.circular(12)))), Positioned(top: 4, left: 4, child: Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)), child: Text("₹${item['price']}", style: const TextStyle(fontSize: 10))))]),
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10)),
          Container(margin: const EdgeInsets.only(top: 4), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(onTap: ()=>setState(()=> qty==1? cart.remove(name) : cart[name]=qty-1), child: const Icon(Icons.remove, size: 14, color: Colors.white)),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Text("$qty", style: const TextStyle(color: Colors.white, fontSize: 12))),
            InkWell(onTap: ()=>setState(()=>cart[name]=qty+1), child: const Icon(Icons.add, size: 14, color: Colors.white)),
          ]))
        ]));
      })),
      Container(color: Colors.white, padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(top: 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Text("Customer Details"), const Spacer(), TextButton(onPressed: (){}, child: const Text("ADD"))]),
        const SizedBox(height: 8),
        Row(children: [
          ChoiceChip(label: const Text("Dine-In"), selected: orderMode=="Dine-In", onSelected: (v)=>setState(()=>orderMode="Dine-In")),
          const SizedBox(width: 8),
          ChoiceChip(label: const Text("Takeaway"), selected: orderMode=="Takeaway", onSelected: (v)=>setState(()=>orderMode="Takeaway")),
          const SizedBox(width: 8),
          ChoiceChip(label: const Text("Delivery"), selected: orderMode=="Delivery", onSelected: (v)=>setState(()=>orderMode="Delivery")),
        ]),
        const SizedBox(height: 12),
        const Text("Table Number"),
        DropdownButtonFormField(value: selectedTable=="Select Table"? null : selectedTable, hint: const Text("Select Table"), items: tables.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v)=>setState(()=>selectedTable=v!), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
        const SizedBox(height: 12),
        const Text("Payment Type"),
        Wrap(spacing: 8, children: payTypes.map((p) => ChoiceChip(label: Text(p), selected: paymentType==p, onSelected: (v)=>setState(()=>paymentType=p))).toList()),
        const SizedBox(height: 12),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF5F6F8), borderRadius: BorderRadius.circular(8)), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Sub Total"), Text("₹$subTotal")]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Discount"), TextButton(onPressed: (){}, child: const Text("ADD"))]),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Effective Discount"), Text("₹0")]),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Taxes"), Text("₹0")]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Service Charge"), TextButton(onPressed: (){}, child: const Text("ADD"))]),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total Amount:", style: TextStyle(fontWeight: FontWeight.bold)), Text("₹$subTotal", style: const TextStyle(fontWeight: FontWeight.bold))]),
        ])),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){ setState(()=>cart.clear()); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bill Saved Successfully!"))); setState(()=>showCart=false); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.all(14)), child: const Text("Confirm & Save", style: TextStyle(color: Colors.white, fontSize: 16)))),
      ]))
    ]));
  }
}
