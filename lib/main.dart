import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNTableApp()));

class KGNTableApp extends StatefulWidget {
  @override
  _KGNTableAppState createState() => _KGNTableAppState();
}

class _KGNTableAppState extends State<KGNTableApp> {
  String selectedTable = "T-1";
  String channel = "dine";
  int pax = 2;
  String selectedCat = "All";
  String search = "";
  bool showNotes = false;

  List<String> cats = ["All","Bestsellers","Tava Fry Specials","Chicken Item","Mutton Item","Roti Item","Veg Item"];

  List<Map<String, dynamic>> menu = [
    {"id":1,"name":"Chapati Roti","price":7,"type":"veg","qty":0,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
    {"id":2,"name":"chaas","price":20,"type":"veg","qty":0,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1544148103-005eec06c04d"},
    {"id":3,"name":"Kheema masala Half","price":80,"type":"nonveg","qty":0,"cat":"Mutton Item","img":"https://images.unsplash.com/photo-1541518763669-27fef04b14ea"},
    {"id":4,"name":"Chicken Masala Half","price":120,"type":"nonveg","qty":0,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"id":5,"name":"Chicken Tava Fry","price":280,"type":"nonveg","qty":2,"cat":"Tava Fry Specials","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"id":6,"name":"Mutton Bheja Masala Fry","price":320,"type":"nonveg","qty":1,"cat":"Tava Fry Specials","img":"https://images.unsplash.com/photo-1541518763669-27fef04b14ea"},
    {"id":7,"name":"Tandoori Roti (Butter)","price":25,"type":"veg","qty":4,"cat":"Roti Item","img":"https://images.unsplash.com/photo-1585937421612-70a008356fbe"},
    {"id":8,"name":"Fresh Lime Soda","price":60,"type":"veg","qty":2,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1544148103-005eec06c04d"},
    {"id":9,"name":"Murgh Do Pyaza","price":170,"type":"nonveg","qty":0,"cat":"Chicken Item","img":"https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"},
    {"id":10,"name":"Dal Tadka","price":70,"type":"veg","qty":0,"cat":"Veg Item","img":"https://images.unsplash.com/photo-1546833999-b9f581a1996d"},
  ];

  List<Map<String, dynamic>> get filtered {
    return menu.where((m) {
      bool c1 = selectedCat == "All" || m["cat"] == selectedCat;
      if(selectedCat=="Bestsellers") c1 = (m["id"] as int) <=6;
      if(selectedCat=="Tava Fry Specials") c1 = m["cat"]=="Tava Fry Specials";
      bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase());
      return c1 && c2;
    }).toList();
  }

  int get totalQty { int t=0; for(var m in menu) t+=m["qty"] as int; return t; }
  int get totalItems { int t=0; for(var m in menu) if((m["qty"] as int)>0) t++; return t; }
  int get totalAmount { int t=0; for(var m in menu) t+=(m["price"] as int)*(m["qty"] as int); return t; }

  void showTableSheet(){
    showModalBottomSheet(context: context, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (ctx){
      return Container(padding: EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Select Table", style: TextStyle(fontWeight: FontWeight.bold)),
          IconButton(icon: Icon(Icons.close), onPressed: ()=>Navigator.pop(context))
        ]),
        GridView.builder(shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: 6, itemBuilder: (c,i){
          String t="T-${i+1}";
          bool sel=selectedTable==t;
          return InkWell(onTap: (){ setState(()=>selectedTable=t); Navigator.pop(context); }, child: Container(decoration: BoxDecoration(color: sel? Color(0xFFFFDBCE): Color(0xFFDAE2FD), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(t, style: TextStyle(fontWeight: FontWeight.bold)))));
        })
      ]));
    });
  }

  Widget channelBtn(String label, String val){
    bool sel=channel==val;
    return InkWell(onTap: (){ setState(()=>channel=val); }, child: Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: sel? Colors.white: Colors.transparent, borderRadius: BorderRadius.circular(6)), child: Text(label, style: TextStyle(fontSize: 11, fontWeight: sel? FontWeight.bold: FontWeight.normal, color: sel? Color(0xFFA33900): Colors.grey))));
  }

  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, title: Row(children: [
        Container(width: 36, height: 32, color: Colors.orange, child: Center(child: Text("KGN", style: TextStyle(fontSize: 8, color: Colors.white)))),
        SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("New Order", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          Text("KGN Tava Fry • Main Branch", style: TextStyle(color: Colors.grey, fontSize: 10))
        ])
      ])),
      body: Column(children: [
        Container(margin: EdgeInsets.all(10), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(onTap: showTableSheet, child: Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Color(0xFFDCE9FF), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.table_restaurant, color: Color(0xFFA33900), size: 20), SizedBox(width: 8), Text("Table $selectedTable", style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.expand_more, size: 18)]))),
            Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Color(0xFFE5EEFF), borderRadius: BorderRadius.circular(8)), child: Row(children: [channelBtn("Dine-in","dine"), channelBtn("Takeaway","parcel"), channelBtn("Delivery","delivery")]))
          ])
        ])),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: TextField(onChanged: (v){ setState(()=>search=v); }, decoration: InputDecoration(hintText: "Search dishes...", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
        SizedBox(height: 8),
        SizedBox(height: 36, child: ListView.builder(scrollDirection: Axis.horizontal, padding: EdgeInsets.symmetric(horizontal: 10), itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.only(right: 6), child: ChoiceChip(label: Text(cats[i], style: TextStyle(fontSize: 12)), selected: selectedCat==cats[i], selectedColor: Color(0xFFA33900), labelStyle: TextStyle(color: selectedCat==cats[i]? Colors.white: Colors.black), onSelected: (v){ setState(()=>selectedCat=cats[i]); })))),
        SizedBox(height: 8),
        Expanded(child: ListView.builder(padding: EdgeInsets.fromLTRB(10,0,10,140), itemCount: filtered.length, itemBuilder: (c,i){
          var m=filtered[i];
          bool added=(m["qty"] as int)>0;
          return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(children: [
            Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Container(width: 70, height: 70, color: Colors.grey.shade200, child: Image.network(m["img"], fit: BoxFit.cover, errorBuilder: (c,e,s)=> Icon(Icons.fastfood)))),
              Positioned(top: 4, right: 4, child: Container(padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(4)), child: Text("₹${m["price"]}", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))))
            ]),
            SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(m["cat"], style: TextStyle(fontSize: 11, color: Colors.grey)),
              Text("₹${m["price"]}${added? " × ${m["qty"]} = ₹${(m["price"] as int)*(m["qty"] as int)}":""}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFA33900)))
            ])),
            added? Row(children: [
              InkWell(onTap: (){ setState(()=> m["qty"]=(m["qty"] as int)-1); }, child: Container(width: 32, height: 32, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: Icon(Icons.remove, size: 16))),
              Container(width: 28, child: Center(child: Text("${m["qty"]}", style: TextStyle(fontWeight: FontWeight.bold)))),
              InkWell(onTap: (){ setState(()=> m["qty"]=(m["qty"] as int)+1); }, child: Container(width: 32, height: 32, decoration: BoxDecoration(color: Color(0xFFA33900), borderRadius: BorderRadius.circular(6)), child: Icon(Icons.add, size: 16, color: Colors.white))),
            ]) : ElevatedButton(onPressed: (){ setState(()=> m["qty"]=1); }, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE5EEFF), elevation: 0), child: Text("Add", style: TextStyle(color: Color(0xFFA33900))))
          ]));
        })),
      ]),
      bottomSheet: totalItems>0? Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("$totalItems Items ($totalQty Qty) • Total: ₹$totalAmount", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT Printed for $selectedTable"))); }, icon: Icon(Icons.print), label: Text("Print KOT"))),
          SizedBox(width: 8),
          Expanded(flex: 2, child: ElevatedButton.icon(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Sent - $selectedTable - ₹$totalAmount"))); setState(()=>{ for(var m in menu) m["qty"]=0 }); }, icon: Icon(Icons.bolt), label: Text("Save & Punch"), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFA33900), foregroundColor: Colors.white)))
        ])
      ])): null,
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, selectedItemColor: Color(0xFFA33900), currentIndex: 1, items: [
        BottomNavigationBarItem(icon: Icon(Icons.table_restaurant), label: "Tables"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "New Order"),
        BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: "Live KOT"),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Summary"),
      ]),
    );
  }
}
