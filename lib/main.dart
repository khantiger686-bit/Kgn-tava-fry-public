import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNTableApp()));

class KGNTableApp extends StatefulWidget {
  @override _KGNTableAppState createState() => _KGNTableAppState();
}

class _KGNTableAppState extends State<KGNTableApp> {
  String selectedTable = "T-1";
  String channel = "dine";
  int pax = 2;
  String selectedCat = "All";
  String search = "";
  bool showNotes = false;
  List<String> cats = ["All","⭐ Bestsellers","🔥 Tava Fry Specials","🍗 Starters","🍛 Gravies & Biryani","🫓 Breads/Naan","🥤 Beverages"];

  List<Map<String, dynamic>> menu = [
    {"id":1,"name":"Chicken Tava Fry","sub":"Spicy tender tava boneless","price":280,"type":"nonveg","half":"Half","qty":2,"img":"https://lh3.googleusercontent.com/aida-public/AB6AXuAil2swEH7Brv-SzcP6VCV_MIpZvmpcrLgajBGTYmIJX11foCjXay4bZfYdkR_viA6XVgj48rFUJpgBD1XxsX9Z7zc3YacdMHELd8yBgTMjVGevL3IDyUS_HoOhA4gHMjdcLWgXAqXIZZETqc076NfyExap729p0G9jcba5FBvZfVF048trHTayLsR2Pf_mdU5NBk72Tvk_sy1DZS3Y_qtvm5xqCZjz4GKokJSVudgKr8janu3OYGSu","cat":"Tava Fry Specials"},
    {"id":2,"name":"Mutton Bheja Masala Fry","sub":"Signature house special","price":320,"type":"nonveg","half":"","qty":1,"img":"https://lh3.googleusercontent.com/aida-public/AB6AXuD_AXZp-qGqQ9KNfZp2MrSsvKt0pSePF_kfJSV324ej0ML2EOgqRElMYTW5e-5ftj5r2pr6T5TNfZja_1BAzLjl810Ne_AWc6No6upz0Agqzu9LJAV5oKWxuFhwc34NfqoERLrBdrN4saoiUZwopMn-aFf9QZ8mxWcS-jcrj2xmDqpG2YF4J4eChwo1iwnnNg1Go5w1_BplrEvFiBQlC9tvKj7WvBPV-9EIs13hfn-4PYjSti072Sey","cat":"Tava Fry Specials"},
    {"id":3,"name":"Tandoori Roti (Butter)","sub":"Crisp clay-oven wheat roti","price":25,"type":"veg","half":"","qty":4,"img":"https://lh3.googleusercontent.com/aida-public/AB6AXuAlBDudoiZnIp3oBYFhkF3N8_rE0Ut0_cYTxuqE-F_itU24i4YenjqltsPzMmI9gLhgqyiZ04yrUbC2Aiu61MxwqRCZOZA4omkW83pXXJoWLnjrbSSmC-b0UIprppjbdB_A1M8MefQ_eROfMFKXkVVmdMHuYbKgb72lPuKzC7cq9rOcCGzLouMn1khQwVTCk21hQY53Coa9zBN6NVYxB3qjRUAMMi7w6_Z1k6SnqzQumllr060tdypC","cat":"Breads/Naan"},
    {"id":4,"name":"Fresh Lime Soda","sub":"Sweet & Salt chilled fizz","price":60,"type":"veg","half":"","qty":2,"img":"https://lh3.googleusercontent.com/aida-public/AB6AXuAmUKmjzZd1paSYTrLgzYLdghPq8sxi1kKZfMTg4L0Q-Y9plEPRocT9k0DnIlcI4ZYzrSbNv5F4aAyTIvRwIrQc3Y8Dk26HMyh8x-QDACKeMea9k65UyQuIXOsHuLrgLGK18mZ-y4yUhnNqzVCF5kuOKYsQNjQ8dhCHGsx_JOeyewdi1KzFQjMWTdyoUSerTqtIu8yjLzXxcGLPNM0kUI1MXkyfhzse","cat":"Beverages"},
    {"id":5,"name":"Paneer Tava Bhurji","sub":"Amritsari butter toss","price":220,"type":"veg","half":"","qty":0,"img":"https://lh3.googleusercontent.com/aida-public/AB6AXuBxzmq6P9mCkoXPChZ_yOAT_nNXxBUqakJJuOKxUibBNhr5zqHETQivVvt0V_3UQfgleHLKUECIgL5t5s6786QLONp1Fc7MrzFRx1x-OTB2g1jA0U5TzYSsVg3-Y_FGj2XVnI25Z0v-vD7_M5QNa1bXvgZ2121afWrqI8R6-aS3BlVUdxsNPLfoHPZcwDPrDSKfYAB3WPf2Am3YFbBBhV5B09OX_DmNmNIwCWnSuAJTDu0c1nvJHmXA","cat":"Starters"},
    {"id":6,"name":"Special Chicken Dum Biryani","sub":"Fragrant dum rice with egg","price":260,"type":"nonveg","half":"","qty":0,"img":"https://lh3.googleusercontent.com/aida-public/AB6AXuBfdGEgcCCSd0DtudDeIrPe4bxnso31xU3quIf3IUXWWUBeAl0_rSSFPgBI1rge7WHNDg6s-luKiRmGSVhrPUQQqiaDxsqVAy2_xMkJtothu-l6iEidcIfdwkuHZ-xR4WAmgZeS0i6ISVdA0WupO1w_cCQ4Mog1ODlOihToMG3lsRVjJ8UkI0Iomz0U6KVFF_1_TgV5XVOFLqrf8ksAKeC9402H_iHIi3blWpJfUOB4i8kij_dIPV5a","cat":"Gravies & Biryani"},
  ];

  List<Map<String, dynamic>> get filtered => menu.where((m){
    bool c1 = selectedCat=="All" || m["cat"].toString().contains(selectedCat.replaceAll(RegExp(r'[⭐🔥🍗🍛🫓🥤 ]'), '').trim()) || selectedCat.contains(m["cat"]);
    if(selectedCat=="All") c1=true;
    bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase());
    return c1 && c2;
  }).toList();

  int get totalQty => menu.fold(0, (a,b)=> a + (b["qty"] as int));
  int get totalItems => menu.where((m)=> m["qty"]>0).length;
  int get totalAmount => menu.fold(0, (a,b)=> a + (b["price"] as int)*(b["qty"] as int));

  void _showTableSheet(){
    showModalBottomSheet(context: context, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (ctx)=> Container(padding: EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Select Table / Station", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)), Text("Ground Floor & Family AC", style: TextStyle(fontSize:12, color: Colors.grey))]), IconButton(icon: Icon(Icons.close), onPressed: ()=>Navigator.pop(context))]),
      SizedBox(height:12),
      GridView.builder(shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, crossAxisSpacing:8, mainAxisSpacing:8), itemCount:6, itemBuilder: (c,i){
        String t="T-${i+1}";
        bool isSel = selectedTable==t;
        return InkWell(onTap: (){ setState(()=>selectedTable=t); Navigator.pop(context); }, child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: isSel? Color(0xFFFFDBCE): Color(0xFFDAE2FD), borderRadius: BorderRadius.circular(12)), child: Column(children: [Text(t, style: TextStyle(fontWeight: FontWeight.bold)), Text(isSel? "Active Bill":"Available", style: TextStyle(fontSize:10, color: isSel? Colors.brown: Colors.green, fontWeight: FontWeight.bold)), if(isSel) Text("₹$totalAmount", style: TextStyle(fontWeight: FontWeight.bold, fontSize:12))])) );
      }),
    ])));
  }

  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      appBar: PreferredSize(preferredSize: Size.fromHeight(64), child: AppBar(backgroundColor: Colors.white.withOpacity(0.9), elevation: 0, title: Row(children: [
        Container(width:36, height:32, color: Colors.orange, child: Center(child: Text("KGN", style: TextStyle(fontSize:8, color: Colors.white)))),
        SizedBox(width:8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Text("New Order", style: TextStyle(color: Colors.black, fontSize:16, fontWeight: FontWeight.bold)), SizedBox(width:6), Container(width:8, height:8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle))]),
          Row(children: [Text("KGN Tava Fry • Main Branch", style: TextStyle(color: Colors.grey, fontSize:10)), SizedBox(width:4), Container(padding: EdgeInsets.symmetric(horizontal:4, vertical:1), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: Text("Live", style: TextStyle(fontSize:9, color: Colors.green, fontWeight: FontWeight.bold)))])
        ])
      ]), actions: [IconButton(icon: Icon(Icons.sync, color: Colors.green), onPressed: (){}), CircleAvatar(radius:16, backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuDKh20SviJSN310oAEsPBv_EugFXp4HMGMYy6C_0vQM-E7uzQeyrplVn6iDqlM1qjbGKze0MwXfs75OZocBmbyPCvosl0A1hkllzrcvi2uSm5a73iJxHl1VBoJ5IrDqMzJVs-eevN-vPQXZY-Ytrl8Ln6i3chsQSIM0nHA6L_0deGIQiD4pmzNezmFrqsUZJvkyt3OnWv7poq2UDY0u967N2_RFrRzDxDmg5TJ1wn9Tn7pyk6CV0biu"))])),
      body: Column(children: [
        // TABLE + CHANNEL + PAX
        Container(margin: EdgeInsets.all(10), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(onTap: _showTableSheet, child: Container(padding: EdgeInsets.symmetric(horizontal:12, vertical:6), decoration: BoxDecoration(color: Color(0xFFDCE9FF), borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.table_restaurant, color: Color(0xFFA33900), size:20), SizedBox(width:8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Table $selectedTable", style: TextStyle(fontWeight: FontWeight.bold, fontSize:14)), Text("Dine-in Floor", style: TextStyle(fontSize:10, color: Color(0xFFA33900), fontWeight: FontWeight.bold))]), Icon(Icons.expand_more, size:18)]))),
            Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Color(0xFFE5EEFF), borderRadius: BorderRadius.circular(8)), child: Row(children: [
              _channelBtn("Dine-in","dine"),
              _channelBtn("Takeaway","parcel"),
              _channelBtn("Delivery","delivery"),
            ]))
          ]),
          SizedBox(height:10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text("Guests (PAX):", style: TextStyle(fontSize:11, fontWeight: FontWeight.bold, color: Colors.grey)),
              SizedBox(width:6),
              Row(children: [1,2,3,4].map((n)=> InkWell(onTap: ()=>setState(()=>pax=n), child: Container(margin: EdgeInsets.only(right:4), width:30, height:30, decoration: BoxDecoration(color: pax==n? Color(0xFFA33900): Color(0xFFE5EEFF), borderRadius: BorderRadius.circular(8)), child: Center(child: Text(n==4? "4+":"$n", style: TextStyle(color: pax==n? Colors.white: Colors.black, fontWeight: FontWeight.bold, fontSize:12)))))).toList())
            ]),
            Container(padding: EdgeInsets.symmetric(horizontal:8, vertical:4), decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(6)), child: Row(children: [Icon(Icons.badge, size:14, color: Colors.green), SizedBox(width:4), Text("Capt. Deepak", style: TextStyle(fontSize:11, fontWeight: FontWeight.bold))]))
          ])
        ])),
        // SEARCH
        Padding(padding: EdgeInsets.symmetric(horizontal:10), child: Row(children: [
          Expanded(child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search dishes (e.g. Bheja, Chicken Tikka, Roti)...", prefixIcon: Icon(Icons.search, size:20), suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.mic, size:20), SizedBox(width:8), Icon(Icons.barcode_reader, size:20), SizedBox(width:12)]), filled: true, fillColor: Colors.white, contentPadding: EdgeInsets.symmetric(vertical:12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
        ])),
        SizedBox(height:8),
        // CATEGORY PILLS
        SizedBox(height:36, child: ListView.builder(scrollDirection: Axis.horizontal, padding: EdgeInsets.symmetric(horizontal:10), itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.only(right:6), child: ChoiceChip(label: Text(cats[i], style: TextStyle(fontSize:12, fontWeight: FontWeight.bold)), selected: selectedCat==cats[i], selectedColor: Color(0xFFA33900), backgroundColor: Colors.white, labelStyle: TextStyle(color: selectedCat==cats[i]? Colors.white: Colors.black), onSelected: (v)=>setState(()=>selectedCat=cats[i]))))),
        SizedBox(height:8),
        // MENU LIST - PHOTO PE PRICE
        Expanded(child: ListView.builder(padding: EdgeInsets.fromLTRB(10,0,10,150), itemCount: filtered.length, itemBuilder: (c,i){
          var m = filtered[i];
          bool added = m["qty"]>0;
          return Container(margin: EdgeInsets.only(bottom:8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(children: [
            Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Container(width:70, height:70, child: Image.network(m["img"], fit: BoxFit.cover, errorBuilder: (c,e,s)=> Container(color: Colors.grey.shade200, child: Icon(Icons.fastfood))))),
              Positioned(top:4, left:4, child: Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(4)), child: m["type"]=="veg"? Container(width:12, height:12, decoration: BoxDecoration(border: Border.all(color: Colors.green, width:1.5)), child: Center(child: Container(width:5, height:5, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)))) : Container(width:12, height:12, decoration: BoxDecoration(border: Border.all(color: Colors.red, width:1.5)), child: Center(child: Icon(Icons.play_arrow, size:8, color: Colors.red))))))
            ]),
            SizedBox(width:10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Flexible(child: Text(m["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize:14), overflow: TextOverflow.ellipsis)), if(m["half"]!="") Container(margin: EdgeInsets.only(left:4), padding: EdgeInsets.symmetric(horizontal:4, vertical:1), decoration: BoxDecoration(color: Color(0xFFD3E4FE), borderRadius: BorderRadius.circular(4)), child: Text(m["half"], style: TextStyle(fontSize:10, fontWeight: FontWeight.bold, color: Color(0xFFA33900))))]),
              Text(m["sub"], style: TextStyle(fontSize:11, color: Colors.grey)),
              SizedBox(height:4),
              Row(children: [Text("₹${m["price"]}", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFA33900), fontSize:14)), if(added) Text(" × ${m["qty"]} = ₹${(m["price"] as int)*(m["qty"] as int)}", style: TextStyle(fontSize:11, color: Colors.grey))])
            ])),
            added? Container(padding: EdgeInsets.all(2), decoration: BoxDecoration(color: Color(0xFFE5EEFF), borderRadius: BorderRadius.circular(8)), child: Row(children: [
              InkWell(onTap: ()=>setState(()=> m["qty"]>0? m["qty"]--: null), child: Container(width:32, height:32, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: Icon(Icons.remove, size:16))),
              Container(width:28, child: Center(child: Text("${m["qty"]}", style: TextStyle(fontWeight: FontWeight.bold)))),
              InkWell(onTap: ()=>setState(()=>m["qty"]++), child: Container(width:32, height:32, decoration: BoxDecoration(color: Color(0xFFA33900), borderRadius: BorderRadius.circular(6)), child: Icon(Icons.add, size:16, color: Colors.white))),
            ]))
            : ElevatedButton(onPressed: ()=>setState(()=>m["qty"]=1), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE5EEFF), elevation:0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add, size:16, color: Color(0xFFA33900)), Text("Add", style: TextStyle(color: Color(0xFFA33900), fontWeight: FontWeight.bold))]))
          ]));
        })),
      ]),
      // BOTTOM CART - Save & Hold / Save & Bill + Print KOT
      bottomSheet: totalItems>0? Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [Container(width:10, height:10, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)), SizedBox(width:6), Text("$totalItems Items ($totalQty Qty)", style: TextStyle(fontWeight: FontWeight.bold, fontSize:12)), SizedBox(width:6), Text("• Total:", style: TextStyle(fontSize:11, color: Colors.grey)), Text(" ₹$totalAmount", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFA33900), fontSize:14))]),
          InkWell(onTap: ()=>setState(()=>showNotes=!showNotes), child: Row(children: [Icon(Icons.edit_note, size:16), Text("Add Notes / Modifiers", style: TextStyle(fontSize:11, fontWeight: FontWeight.bold))]))
        ]),
        if(showNotes) Container(margin: EdgeInsets.only(top:6), child: Wrap(spacing:6, children: [Chip(label: Text("🌶️ Extra Spicy Tava", style: TextStyle(fontSize:10)), backgroundColor: Color(0xFFFFDBCE)), Chip(label: Text("No Garlic", style: TextStyle(fontSize:10))), Chip(label: Text("Roti Well Done", style: TextStyle(fontSize:10))), Chip(label: Text("+ Custom Note", style: TextStyle(fontSize:10)))])),
        SizedBox(height:8),
        Row(children: [
          Expanded(flex:2, child: OutlinedButton.icon(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT Printed for $selectedTable"))); }, icon: Icon(Icons.print, size:18), label: Text("Print KOT"), style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical:14), backgroundColor: Color(0xFF565E74), foregroundColor: Colors.white))),
          SizedBox(width:8),
          Expanded(flex:3, child: ElevatedButton.icon(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Sent to Kitchen Display (KOT) - Table $selectedTable - ₹$totalAmount"))); setState(()=>{ for(var m in menu) m["qty"]=0; }); }, icon: Icon(Icons.bolt, size:18), label: Text("Save & Punch"), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFA33900), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical:14)))),
        ])
      ])) : null,
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, selectedItemColor: Color(0xFFA33900), unselectedItemColor: Colors.grey, currentIndex:1, items: [
        BottomNavigationBarItem(icon: Icon(Icons.table_restaurant), label: "Tables"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "New Order"),
        BottomNavigationBarItem(icon: Icon(Icons.skillet), label: "Live KOT"),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Summary"),
      ]),
    );
  }

  Widget _channelBtn(String label, String val){
    bool sel = channel==val;
    return InkWell(onTap: ()=>setState(()=>channel=val), child: Container(padding: EdgeInsets.symmetric(horizontal:10, vertical:6), decoration: BoxDecoration(color: sel? Colors.white: Colors.transparent, borderRadius: BorderRadius.circular(6), boxShadow: sel? [BoxShadow(color: Colors.black12, blurRadius:2)]: []), child: Text(label, style: TextStyle(fontSize:11, fontWeight: sel? FontWeight.bold: FontWeight.normal, color: sel? Color(0xFFA33900): Colors.grey))));
  }
}
