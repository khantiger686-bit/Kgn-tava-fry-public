import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: KGNApp(),
  ));
}

class KGNApp extends StatefulWidget {
  @override
  _KGNAppState createState() => _KGNAppState();
}

class _KGNAppState extends State<KGNApp> {
  int nav = 2;
  String cat = "All";
  String table = "T-1";
  String pay = "Cash";
  String search = "";

  List<String> cats = ["All","Chicken","Mutton","Fish","Anda","Veg","Roti"];
  List<String> tables = ["T-1","T-2","T-3","T-4","T-5","T-6"];
  List<String> pays = ["Cash","UPI","PhonePe","Google Pay","Card"];

  List<Map> menu = [
    {"n":"Murgh Do Pyaza","h":170,"f":320,"c":"Chicken"},
    {"n":"Murgh Moghlai","h":160,"f":300,"c":"Chicken"},
    {"n":"Chicken Handi","h":170,"f":320,"c":"Chicken"},
    {"n":"Chicken Fry","h":120,"f":220,"c":"Chicken"},
    {"n":"Chicken Masala","h":120,"f":220,"c":"Chicken"},
    {"n":"Chicken Biryani","h":80,"f":120,"c":"Chicken"},
    {"n":"Butter Chicken","h":170,"f":320,"c":"Chicken"},
    {"n":"Chicken Tikka Rice","h":170,"f":320,"c":"Chicken"},
    {"n":"Moghlai Mutton","h":150,"f":280,"c":"Mutton"},
    {"n":"Mutton Fry","h":120,"f":220,"c":"Mutton"},
    {"n":"Kheema Fry","h":80,"f":160,"c":"Mutton"},
    {"n":"Bheja Fry","h":130,"f":240,"c":"Mutton"},
    {"n":"Machhi Fry","h":80,"f":160,"c":"Fish"},
    {"n":"Jhinga Fry","h":130,"f":240,"c":"Fish"},
    {"n":"Anda Bhurji","h":50,"f":100,"c":"Anda"},
    {"n":"Anda Pulav","h":60,"f":120,"c":"Anda"},
    {"n":"Dal Tadka","h":70,"f":140,"c":"Veg"},
    {"n":"Dal Fry","h":50,"f":100,"c":"Veg"},
    {"n":"Jeera Rice","h":50,"f":100,"c":"Veg"},
    {"n":"Plain Rice","h":30,"f":60,"c":"Veg"},
    {"n":"Special Roti","h":15,"f":15,"c":"Roti"},
    {"n":"Chapati Roti","h":7,"f":7,"c":"Roti"},
    {"n":"Papad Fry","h":10,"f":10,"c":"Roti"},
  ];

  Map<String, List<Map>> orders = {
    "T-1":[], "T-2":[], "T-3":[], "T-4":[], "T-5":[], "T-6":[]
  };
  List<Map> kot = [];
  double sale = 0;
  int bills = 0;

  List<Map> get cur => orders[table]!;
  int get totItems => cur.fold(0, (a,b) => a + b["q"] as int);
  int get totAmt => cur.fold(0, (a,b) => a + (b["p"] as int)*(b["q"] as int));

  List<Map> get filt {
    return menu.where((m){
      bool c1 = cat=="All" || m["c"]==cat;
      bool c2 = m["n"].toString().toLowerCase().contains(search.toLowerCase());
      return c1 && c2;
    }).toList();
  }

  void addCart(Map m, bool full){
    setState((){
      String nm = "${m["n"]} ${full?"F":"H"}";
      int pr = full? m["f"] : m["h"];
      int idx = cur.indexWhere((e)=> e["nm"]==nm);
      if(idx>=0){
        cur[idx]["q"]++;
      } else {
        cur.add({"nm":nm,"p":pr,"q":1});
      }
    });
  }

  void showBill(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text("BILL $table"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Table: $table"),
              Divider(),
             ...cur.map((e){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("${e["nm"]} x${e["q"]}")),
                    Text("Rs ${e["p"]*e["q"]}"),
                  ],
                );
              }).toList(),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total"), Text("Rs $totAmt", style: TextStyle(fontWeight: FontWeight.bold))]),
              SizedBox(height:10),
              Text("Payment: $pay"),
              Wrap(
                spacing: 5,
                children: pays.map((p){
                  return ChoiceChip(label: Text(p), selected: pay==p, onSelected: (v){ setState(()=>pay=p); Navigator.pop(context); showBill(); });
                }).toList(),
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: ()=> Navigator.pop(context), child: Text("Close")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: (){
              setState((){
                sale += totAmt;
                bills++;
                kot.removeWhere((k)=> k["t"]==table);
                orders[table] = [];
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bill Paid Rs $totAmt")));
            },
            child: Text("Paid", style: TextStyle(color: Colors.white)),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: nav==0? homePage() : nav==1? itemPage() : nav==2? orderPage() : nav==3? reportPage() : morePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        onTap: (i){ setState(()=> nav=i); },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Items"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, color: Colors.blue, size: 40), label: "Order"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Report"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
    );
  }

  Widget homePage(){
    int hold = orders.values.where((e)=> e.isNotEmpty).length;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("KGN TAWA FRY", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                box(Icons.check_circle, "Closed", "$bills"),
                box(Icons.access_time, "Hold", "$hold"),
                box(Icons.restaurant, "Items", "${menu.length}"),
              ],
            ),
            SizedBox(height:15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Todays Sale"), Text("Rs $sale", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))]),
                  SizedBox(height:8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Todays Bills"), Text("$bills")]),
                ],
              ),
            ),
            SizedBox(height:15),
            Text("Tables", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height:8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.6, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemCount: tables.length,
                itemBuilder: (c,i){
                  String t = tables[i];
                  bool occ = orders[t]!.isNotEmpty;
                  int amt = orders[t]!.fold(0, (a,b)=> a + (b["p"] as int)*(b["q"] as int));
                  return Container(
                    decoration: BoxDecoration(color: occ? Colors.green : Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: occ? Colors.white: Colors.black)), Text(occ? "Rs $amt":"Empty", style: TextStyle(fontSize: 11, color: occ? Colors.white: Colors.grey))])),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget box(IconData ic, String t, String n){
    return Column(children: [CircleAvatar(backgroundColor: Colors.blue.shade100, child: Icon(ic, color: Colors.blue)), SizedBox(height:5), Text(t, style: TextStyle(fontSize:11)), Text(n, style: TextStyle(fontSize:12, color: Colors.grey))]);
  }

  Widget itemPage(){
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(10), child: TextField(onChanged: (v){ setState(()=> search=v); }, decoration: InputDecoration(hintText: "Search", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
          SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i){ return Padding(padding: EdgeInsets.all(4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], onSelected: (v){ setState(()=> cat=cats[i]); })); })),
          Expanded(child: ListView.builder(itemCount: filt.length, itemBuilder: (c,i){ var m = filt[i]; return Card(child: ListTile(title: Text(m["n"]), subtitle: Text("${m["c"]} H:${m["h"]} F:${m["f"]}"))); }))
        ],
      ),
    );
  }

  Widget orderPage(){
    return SafeArea(
      child: Column(
        children: [
          Container(height:55, color: Colors.white, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: tables.length, itemBuilder: (c,i){ String t = tables[i]; bool sel = t==table; bool occ = orders[t]!.isNotEmpty; return GestureDetector(onTap: (){ setState(()=> table=t); }, child: Container(width:65, margin: EdgeInsets.all(5), decoration: BoxDecoration(color: sel? Colors.blue : occ? Colors.green : Colors.grey.shade300, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(t, style: TextStyle(color: sel||occ? Colors.white: Colors.black, fontWeight: FontWeight.bold))))); })),
          Padding(padding: EdgeInsets.all(8), child: TextField(onChanged: (v){ setState(()=> search=v); }, decoration: InputDecoration(hintText: "Search items", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
          SizedBox(height:35, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: cats.length, itemBuilder: (c,i){ return Padding(padding: EdgeInsets.symmetric(horizontal:4), child: ChoiceChip(label: Text(cats[i]), selected: cat==cats[i], onSelected: (v){ setState(()=> cat=cats[i]); })); })),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.75, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: filt.length,
              itemBuilder: (c,i){
                var m = filt[i];
                int qH = cur.where((e)=> e["nm"]=="${m["n"]} H").fold(0, (a,b)=> a + (b["q"] as int));
                int qF = cur.where((e)=> e["nm"]=="${m["n"]} F").fold(0, (a,b)=> a + (b["q"] as int));
                return Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(height:60, decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.vertical(top: Radius.circular(10))), child: Center(child: Text("Rs ${m["f"]}", style: TextStyle(fontWeight: FontWeight.bold)))),
                      Padding(padding: EdgeInsets.all(4), child: Text(m["n"], maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize:11, fontWeight: FontWeight.bold))),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(child: InkWell(onTap: ()=> addCart(m,false), child: Container(margin: EdgeInsets.all(3), padding: EdgeInsets.all(5), decoration: BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(6), color: qH>0? Colors.orange: Colors.white), child: Center(child: Text("H ${m["h"]} ${qH>0?"x$qH":""}", style: TextStyle(fontSize:10, color: qH>0? Colors.white: Colors.orange)))))),
                          Expanded(child: InkWell(onTap: ()=> addCart(m,true), child: Container(margin: EdgeInsets.all(3), padding: EdgeInsets.all(5), decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(6), color: qF>0? Colors.green: Colors.white), child: Center(child: Text("F ${m["f"]} ${qF>0?"x$qF":""}", style: TextStyle(fontSize:10, color: qF>0? Colors.white: Colors.green)))))),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          if(totItems>0) Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("$totItems Items Rs $totAmt", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                OutlinedButton(onPressed: (){ setState(()=> kot.add({"t":table, "items": List.from(cur)})); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$table Hold + KOT"))); }, child: Text("Hold")),
                SizedBox(width:8),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: showBill, child: Text("Bill", style: TextStyle(color: Colors.white))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget reportPage(){
    return SafeArea(child: Padding(padding: EdgeInsets.all(15), child: Column(children: [Text("Reports", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)), SizedBox(height:15), Container(padding: EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Sale"), Text("Rs $sale")]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Bills"), Text("$bills")]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Hold Tables"), Text("${orders.values.where((e)=> e.isNotEmpty).length}")])]))])));
  }

  Widget morePage(){
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(title: Text("KGN TAWA FRY"), subtitle: Text("Smart Restaurant App")),
          Divider(),
          ListTile(leading: Icon(Icons.print), title: Text("Printer Support"), subtitle: Text("Bluetooth WiFi USB")),
          ListTile(leading: Icon(Icons.kitchen), title: Text("KOT Management"), subtitle: Text("${kot.length} Active")),
          ListTile(leading: Icon(Icons.table_bar), title: Text("Table Management"), subtitle: Text("6 Tables")),
          ListTile(leading: Icon(Icons.settings), title: Text("Settings"), subtitle: Text("No GST")),
        ],
      ),
    );
  }
}
