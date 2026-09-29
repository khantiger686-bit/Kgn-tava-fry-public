import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNTableApp()));

class KGNTableApp extends StatefulWidget {
  @override State<KGNTableApp> createState() => _KGNTableAppState();
}

class _KGNTableAppState extends State<KGNTableApp> {
  String selectedCat = "All";
  String search = "";
  String table = "T-1";
  List<String> cats = ["All","Chicken Fry Fry","Mutton Item","Zinga-Machhi","Anda Item","Veg Item","Roti-Rice"];

  List<Map<String,dynamic>> menu = [
    {"id":1,"name":"Murga Do Pyaza","g":"મુર્ગ દો પ્યાઝા","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":2,"name":"Murga Moghlai","g":"મુર્ગ મોગલાઈ","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":3,"name":"Chicken Handi","g":"ચીકન હાન્ડી","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":4,"name":"Chicken Pisawar","g":"ચીકન પીસાવર","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":5,"name":"Murg Shahi Chicken","g":"મુર્ગ શાહી ચીકન","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":6,"name":"Chicken Malai Tikka","g":"ચીકન મલાઈ ટીક્કા","price":350,"half":180,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":7,"name":"Chicken Tikka Masala","g":"ચીકન ટીક્કા મસાલા","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":8,"name":"Chicken Kadhai","g":"ચીકન કઢાઈ","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":9,"name":"Chicken Garlic","g":"ચીકન ગાર્લિક","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":10,"name":"Chicken India","g":"ચીકન ઈન્ડિયા","price":450,"half":250,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":11,"name":"Butter Chicken Boneless","g":"બટર ચીકન બોનલેસ","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":12,"name":"White Chicken","g":"વ્હાઈટ ચીકન","price":350,"half":180,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":13,"name":"Green Chicken","g":"ગ્રીન ચીકન","price":350,"half":180,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":14,"name":"Chicken Fry","g":"ચીકન ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":15,"name":"Chicken Masala","g":"ચીકન મસાલા","price":220,"half":120,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":16,"name":"Chicken Biryani","g":"ચીકન બિરયાની","price":120,"half":80,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":17,"name":"Chicken Tandoori Masala","g":"ચીકન તંદુરી મસાલા","price":480,"half":250,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":18,"name":"Chicken Amdavadi Masala","g":"ચીકન અમદાવાદી મસાલા","price":320,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":19,"name":"Chicken Tikka Rice","g":"ચીકન ટીક્કા રાઈસ","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":20,"name":"Moghlai Mutton","g":"મોગલાઈ મટન","price":280,"half":150,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":21,"name":"Dal Bati Gos","g":"દાલબાટી ગોસ","price":280,"half":150,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":22,"name":"White Mutton","g":"વ્હાઈટ મટન","price":300,"half":160,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":23,"name":"Green Mutton","g":"ગ્રીન મટન","price":280,"half":150,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":24,"name":"Mutton Kurma","g":"મટન કુર્મા","price":300,"half":160,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":25,"name":"Mutton Fry","g":"મટન ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":26,"name":"Mutton Masala","g":"મટન મસાલા","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":27,"name":"Kaleji Masala","g":"કલેજી મસાલા","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":28,"name":"Bhaji Gos","g":"ભાજી ગોસ","price":240,"half":130,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":29,"name":"Paya Fry","g":"પાયા ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":30,"name":"Chaap Fry","g":"ચાંપ ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":31,"name":"Bheja Fry","g":"ભેજા ફ્રાય","price":240,"half":130,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":32,"name":"Boti Masala","g":"બોટી મસાલા","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":33,"name":"Keema Fry","g":"ખીમા ફ્રાય","price":160,"half":80,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":34,"name":"Keema Pulav","g":"ખીમા પુલાવ","price":180,"half":100,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":35,"name":"Machhi Fry","g":"મચ્છી ફ્રાય","price":160,"half":80,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":36,"name":"Machhi Kadi","g":"મચ્છી કઢી","price":200,"half":100,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":37,"name":"Jinga Fry","g":"જીંગા ફ્રાય","price":240,"half":130,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":38,"name":"Jinga Rice","g":"જીંગા રાઈસ","price":320,"half":170,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":39,"name":"Anda Kadi","g":"એંડા કઢી","price":160,"half":80,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":40,"name":"Anda Keema","g":"એંડા ખીમા","price":160,"half":80,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":41,"name":"Anda Bhurji","g":"એંડા ભુર્જી","price":100,"half":50,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":42,"name":"Anda Pulav","g":"એંડા પુલાવ","price":120,"half":60,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":43,"name":"Dal Tadka","g":"દાલ તડકા","price":140,"half":70,"type":"veg","cat":"Veg Item","qty":0},
    {"id":44,"name":"Dal Gotala","g":"દાલ ગોટાલા","price":160,"half":80,"type":"veg","cat":"Veg Item","qty":0},
    {"id":45,"name":"Butter Dal Fry","g":"બટર દાલ ફ્રાય","price":140,"half":70,"type":"veg","cat":"Veg Item","qty":0},
    {"id":46,"name":"Dal Fry","g":"દાલ ફ્રાય","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":47,"name":"Sabji Fry","g":"સબજી ફ્રાય","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":48,"name":"Sev Tameta","g":"સેવ ટમેટા","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":49,"name":"Masala Rice","g":"મસાલા રાઈસ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":50,"name":"Biryani Rice","g":"બિરયાની રાઈસ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":51,"name":"Jeera Rice","g":"જીરા રાઈસ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":52,"name":"Kadi Khichdi","g":"કઢી ખીચડી","price":60,"half":30,"type":"veg","cat":"Veg Item","qty":0},
    {"id":53,"name":"Dal Pulav","g":"દાલ પુલાવ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":54,"name":"Plain Rice","g":"પ્લેન રાઈસ","price":60,"half":30,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":55,"name":"Special Roti","g":"સ્પેશ્યલ રોટી","price":15,"half":15,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":56,"name":"Special Paratha","g":"સ્પેશ્યલ પરાઠા","price":20,"half":20,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":57,"name":"Butter Roti","g":"બટર રોટી","price":15,"half":15,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":58,"name":"Chapati Roti","g":"ચપાટી રોટી","price":7,"half":7,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":59,"name":"Papad Fry","g":"પાપડ ફ્રાય","price":10,"half":10,"type":"veg","cat":"Roti-Rice","qty":0},
  ];

  List get filtered => menu.where((m){
    bool c1 = selectedCat=="All" || m["cat"]==selectedCat;
    bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase());
    return c1 && c2;
  }).toList();

  int get total => menu.fold(0, (a,b)=> a + (b["price"] as int)*(b["qty"] as int));

  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      appBar: AppBar(title: Text("TABLE - KGN Tawa Fry - T-$table - 59 Items"), backgroundColor: Color(0xFFA33900), foregroundColor: Colors.white),
      body: Column(children: [
        Padding(padding: EdgeInsets.all(8), child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search from 59 items...", prefixIcon: Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))))),
        SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, padding: EdgeInsets.symmetric(horizontal:8), itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.only(right:6), child: ChoiceChip(label: Text(cats[i]), selected: selectedCat==cats[i], onSelected: (v)=>setState(()=>selectedCat=cats[i]))))),
        Expanded(child: ListView.builder(padding: EdgeInsets.all(8), itemCount: filtered.length, itemBuilder: (c,i){
          var m=filtered[i];
          return Container(margin: EdgeInsets.only(bottom:6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: ListTile(
            title: Text("${m["name"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize:14)),
            subtitle: Text("${m["g"]} | Half ₹${m["half"]} | Full ₹${m["price"]}", style: TextStyle(fontSize:12, color: Colors.grey.shade700)),
            leading: Container(width:8, height:8, decoration: BoxDecoration(color: m["type"]=="veg"? Colors.green: Colors.red, shape: BoxShape.circle)),
            trailing: m["qty"]>0 ? Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: Icon(Icons.remove), onPressed: ()=>setState(()=>m["qty"]--)), Text("${m["qty"]}", style: TextStyle(fontWeight: FontWeight.bold)), IconButton(icon: Icon(Icons.add), onPressed: ()=>setState(()=>m["qty"]++))]) : ElevatedButton(onPressed: ()=>setState(()=>m["qty"]=1), child: Text("Add")),
          ));
        })),
      ]),
      bottomNavigationBar: total>0 ? Container(padding: EdgeInsets.all(12), color: Colors.white, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total ₹$total", style: TextStyle(fontWeight: FontWeight.bold, fontSize:18, color: Color(0xFFA33900))), ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFA33900), foregroundColor: Colors.white), child: Text("Print KOT"))])) : null,
    );
  }
}
