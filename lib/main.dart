import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: KGNTableApp()));

class KGNTableApp extends StatefulWidget { @override _KGNTableAppState createState()=>_KGNTableAppState(); }

class _KGNTableAppState extends State<KGNTableApp> {
  String selectedCat = "All";
  String search = "";
  String table = "T-1";

  List<String> cats = ["All","Chicken Fry","Mutton Item","Zinga-Machhi","Anda Item","Veg Item","Roti-Rice"];

  // 59 ITEMS - FROM YOUR 3 PHOTOS - CORRECTED PRICE (Full Price)
  List<Map<String, dynamic>> menu = [
    // CHICKEN - 19
    {"id":1,"name":"Murga Do Pyaza","name_g":"મુર્ગ દો પ્યાઝા","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":2,"name":"Murga Moghlai","name_g":"મુર્ગ મોગલાઈ","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":3,"name":"Chicken Handi","name_g":"ચીકન હાન્ડી","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":4,"name":"Chicken Pisawar","name_g":"ચીકન પીસાવર","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":5,"name":"Murg Shahi Chicken","name_g":"મુર્ગ શાહી ચીકન","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":6,"name":"Chicken Malai Tikka","name_g":"ચીકન મલાઈ ટીક્કા","price":350,"half":180,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":7,"name":"Chicken Tikka Masala","name_g":"ચીકન ટીક્કા મસાલા","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":8,"name":"Chicken Kadhai","name_g":"ચીકન કઢાઈ","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":9,"name":"Chicken Garlic","name_g":"ચીકન ગાર્લિક","price":300,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":10,"name":"Chicken India","name_g":"ચીકન ઈન્ડિયા","price":450,"half":250,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":11,"name":"Butter Chicken Boneless","name_g":"બટર ચીકન બોનલેસ","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":12,"name":"White Chicken","name_g":"વ્હાઈટ ચીકન","price":350,"half":180,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":13,"name":"Green Chicken","name_g":"ગ્રીન ચીકન","price":350,"half":180,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":14,"name":"Chicken Fry","name_g":"ચીકન ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":15,"name":"Chicken Masala","name_g":"ચીકન મસાલા","price":220,"half":120,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":16,"name":"Chicken Biryani","name_g":"ચીકન બિરયાની","price":120,"half":80,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":17,"name":"Chicken Tandoori Masala","name_g":"ચીકન તંદુરી મસાલા","price":480,"half":250,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":18,"name":"Chicken Amdavadi Masala","name_g":"ચીકન અમદાવાદી મસાલા","price":320,"half":160,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},
    {"id":19,"name":"Chicken Tikka Rice","name_g":"ચીકન ટીક્કા રાઈસ","price":320,"half":170,"type":"nonveg","cat":"Chicken Fry Fry","qty":0},

    // MUTTON - 15
    {"id":20,"name":"Moghlai Mutton","name_g":"મોગલાઈ મટન","price":280,"half":150,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":21,"name":"Dal Bati Gos","name_g":"દાલબાટી ગોસ","price":280,"half":150,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":22,"name":"White Mutton","name_g":"વ્હાઈટ મટન","price":300,"half":160,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":23,"name":"Green Mutton","name_g":"ગ્રીન મટન","price":280,"half":150,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":24,"name":"Mutton Kurma","name_g":"મટન કુર્મા","price":300,"half":160,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":25,"name":"Mutton Fry","name_g":"મટન ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":26,"name":"Mutton Masala","name_g":"મટન મસાલા","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":27,"name":"Kaleji Masala","name_g":"કલેજી મસાલા","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":28,"name":"Bhaji Gos","name_g":"ભાજી ગોસ","price":240,"half":130,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":29,"name":"Paya Fry","name_g":"પાયા ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":30,"name":"Chaap Fry","name_g":"ચાંપ ફ્રાય","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":31,"name":"Bheja Fry","name_g":"ભેજા ફ્રાય","price":240,"half":130,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":32,"name":"Boti Masala","name_g":"બોટી મસાલા","price":220,"half":120,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":33,"name":"Keema Fry","name_g":"ખીમા ફ્રાય","price":160,"half":80,"type":"nonveg","cat":"Mutton Item","qty":0},
    {"id":34,"name":"Keema Pulav","name_g":"ખીમા પુલાવ","price":180,"half":100,"type":"nonveg","cat":"Mutton Item","qty":0},

    // ZINGA-MACHHI - 4
    {"id":35,"name":"Machhi Fry","name_g":"મચ્છી ફ્રાય","price":160,"half":80,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":36,"name":"Machhi Kadi","name_g":"મચ્છી કઢી","price":200,"half":100,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":37,"name":"Jinga Fry","name_g":"જીંગા ફ્રાય","price":240,"half":130,"type":"nonveg","cat":"Zinga-Machhi","qty":0},
    {"id":38,"name":"Jinga Rice","name_g":"જીંગા રાઈસ","price":320,"half":170,"type":"nonveg","cat":"Zinga-Machhi","qty":0},

    // ANDA - 4
    {"id":39,"name":"Anda Kadi","name_g":"એંડા કઢી","price":160,"half":80,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":40,"name":"Anda Keema","name_g":"એંડા ખીમા","price":160,"half":80,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":41,"name":"Anda Bhurji","name_g":"એંડા ભુર્જી","price":100,"half":50,"type":"nonveg","cat":"Anda Item","qty":0},
    {"id":42,"name":"Anda Pulav","name_g":"એંડા પુલાવ","price":120,"half":60,"type":"nonveg","cat":"Anda Item","qty":0},

    // VEG + ROTI RICE - 17 = TOTAL 59
    {"id":43,"name":"Dal Tadka","name_g":"દાલ તડકા","price":140,"half":70,"type":"veg","cat":"Veg Item","qty":0},
    {"id":44,"name":"Dal Gotala","name_g":"દાલ ગોટાલા","price":160,"half":80,"type":"veg","cat":"Veg Item","qty":0},
    {"id":45,"name":"Butter Dal Fry","name_g":"બટર દાલ ફ્રાય","price":140,"half":70,"type":"veg","cat":"Veg Item","qty":0},
    {"id":46,"name":"Dal Fry","name_g":"દાલ ફ્રાય","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":47,"name":"Sabji Fry","name_g":"સબજી ફ્રાય","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":48,"name":"Sev Tameta","name_g":"સેવ ટમેટા","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":49,"name":"Masala Rice","name_g":"મસાલા રાઈસ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":50,"name":"Biryani Rice","name_g":"બિરયાની રાઈસ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":51,"name":"Jeera Rice","name_g":"જીરા રાઈસ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":52,"name":"Kadi Khichdi","name_g":"કઢી ખીચડી","price":60,"half":30,"type":"veg","cat":"Veg Item","qty":0},
    {"id":53,"name":"Dal Pulav","name_g":"દાલ પુલાવ","price":100,"half":50,"type":"veg","cat":"Veg Item","qty":0},
    {"id":54,"name":"Plain Rice","name_g":"પ્લેન રાઈસ","price":60,"half":30,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":55,"name":"Special Roti","name_g":"સ્પેશ્યલ રોટી","price":15,"half":15,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":56,"name":"Special Paratha","name_g":"સ્પેશ્યલ પરાઠા","price":20,"half":20,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":57,"name":"Butter Roti","name_g":"બટર રોટી","price":15,"half":15,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":58,"name":"Chapati Roti","name_g":"ચપાટી રોટી","price":7,"half":7,"type":"veg","cat":"Roti-Rice","qty":0},
    {"id":59,"name":"Papad Fry","name_g":"પાપડ ફ્રાય","price":10,"half":10,"type":"veg","cat":"Roti-Rice","qty":0},
  ];

  List<Map<String,dynamic>> get filtered => menu.where((m){
    bool c1 = selectedCat=="All" || m["cat"]==selectedCat;
    bool c2 = m["name"].toString().toLowerCase().contains(search.toLowerCase()) || m["name_g"].toString().contains(search);
    return c1 && c2;
  }).toList();

  int get totalAmt => menu.fold(0, (a,b)=> a + (b["price"] as int)*(b["qty"] as int));

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("KGN Tawa Fry - Table $table"), backgroundColor: Color(0xFFA33900), foregroundColor: Colors.white),
      body: Column(children: [
        Padding(padding: EdgeInsets.all(8), child: TextField(onChanged: (v)=>setState(()=>search=v), decoration: InputDecoration(hintText: "Search 59 items...", prefixIcon: Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
        SizedBox(height:36, child: ListView.builder(scrollDirection: Axis.horizontal, padding: EdgeInsets.symmetric(horizontal:8), itemCount: cats.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.only(right:6), child: ChoiceChip(label: Text(cats[i]), selected: selectedCat==cats[i], onSelected: (v)=>setState(()=>selectedCat=cats[i]))))),
        Expanded(child: ListView.builder(padding: EdgeInsets.all(8), itemCount: filtered.length, itemBuilder: (c,i){
          var m=filtered[i];
          return Card(child: ListTile(
            leading: m["type"]=="veg" ? Icon(Icons.circle, color: Colors.green, size:14) : Icon(Icons.play_arrow, color: Colors.red, size:14),
            title: Text("${m["name"]} / ${m["name_g"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize:13)),
            subtitle: Text("Half ₹${m["half"]} | Full ₹${m["price"]}", style: TextStyle(color: Color(0xFFA33900))),
            trailing: m["qty"]>0 ? Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: Icon(Icons.remove), onPressed: ()=>setState(()=>m["qty"]--)), Text("${m["qty"]}"), IconButton(icon: Icon(Icons.add), onPressed: ()=>setState(()=>m["qty"]++))]) : ElevatedButton(onPressed: ()=>setState(()=>m["qty"]=1), child: Text("Add")),
          ));
        })),
        if(totalAmt>0) Container(padding: EdgeInsets.all(12), color: Colors.orange.shade50, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total: ₹$totalAmt", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)), ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text("Print KOT & Bill"), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFA33900), foregroundColor: Colors.white))]))
      ]),
    );
  }
}
