import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(debugShowCheckedModeBanner:false,home:KGNApp()));
class KGNApp extends StatefulWidget{ @override State<KGNApp> createState()=>_KGNAppState();}
class _KGNAppState extends State<KGNApp>{
String cat="All"; String s="";
List<String> cats=["All","Chicken","Mutton","Fish","Egg","Veg","Roti"];
List<Map<String,dynamic>> menu=[
{"n":"Murga Do Pyaza","p":300,"h":160,"c":"Chicken","q":0,"t":"n"},
{"n":"Murga Moghlai","p":320,"h":170,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Handi","p":300,"h":160,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Pisawar","p":320,"h":170,"c":"Chicken","q":0,"t":"n"},
{"n":"Shahi Chicken","p":320,"h":170,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Malai Tikka","p":350,"h":180,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Tikka Masala","p":320,"h":170,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Kadhai","p":300,"h":160,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Garlic","p":300,"h":160,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken India","p":450,"h":250,"c":"Chicken","q":0,"t":"n"},
{"n":"Butter Chicken Boneless","p":320,"h":170,"c":"Chicken","q":0,"t":"n"},
{"n":"White Chicken","p":350,"h":180,"c":"Chicken","q":0,"t":"n"},
{"n":"Green Chicken","p":350,"h":180,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Fry","p":220,"h":120,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Masala","p":220,"h":120,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Biryani","p":120,"h":80,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Tandoori Masala","p":480,"h":250,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Amdavadi Masala","p":320,"h":160,"c":"Chicken","q":0,"t":"n"},
{"n":"Chicken Tikka Rice","p":320,"h":170,"c":"Chicken","q":0,"t":"n"},
{"n":"Moghlai Mutton","p":280,"h":150,"c":"Mutton","q":0,"t":"n"},
{"n":"Dal Bati Gos","p":280,"h":150,"c":"Mutton","q":0,"t":"n"},
{"n":"White Mutton","p":300,"h":160,"c":"Mutton","q":0,"t":"n"},
{"n":"Green Mutton","p":280,"h":150,"c":"Mutton","q":0,"t":"n"},
{"n":"Mutton Kurma","p":300,"h":160,"c":"Mutton","q":0,"t":"n"},
{"n":"Mutton Fry","p":220,"h":120,"c":"Mutton","q":0,"t":"n"},
{"n":"Mutton Masala","p":220,"h":120,"c":"Mutton","q":0,"t":"n"},
{"n":"Kaleji Masala","p":220,"h":120,"c":"Mutton","q":0,"t":"n"},
{"n":"Bhaji Gos","p":240,"h":130,"c":"Mutton","q":0,"t":"n"},
{"n":"Paya Fry","p":220,"h":120,"c":"Mutton","q":0,"t":"n"},
{"n":"Chaap Fry","p":220,"h":120,"c":"Mutton","q":0,"t":"n"},
{"n":"Bheja Fry","p":240,"h":130,"c":"Mutton","q":0,"t":"n"},
{"n":"Boti Masala","p":220,"h":120,"c":"Mutton","q":0,"t":"n"},
{"n":"Keema Fry","p":160,"h":80,"c":"Mutton","q":0,"t":"n"},
{"n":"Keema Pulav","p":180,"h":100,"c":"Mutton","q":0,"t":"n"},
{"n":"Machhi Fry","p":160,"h":80,"c":"Fish","q":0,"t":"n"},
{"n":"Machhi Kadi","p":200,"h":100,"c":"Fish","q":0,"t":"n"},
{"n":"Jinga Fry","p":240,"h":130,"c":"Fish","q":0,"t":"n"},
{"n":"Jinga Rice","p":320,"h":170,"c":"Fish","q":0,"t":"n"},
{"n":"Anda Kadi","p":160,"h":80,"c":"Egg","q":0,"t":"n"},
{"n":"Anda Keema","p":160,"h":80,"c":"Egg","q":0,"t":"n"},
{"n":"Anda Bhurji","p":100,"h":50,"c":"Egg","q":0,"t":"n"},
{"n":"Anda Pulav","p":120,"h":60,"c":"Egg","q":0,"t":"n"},
{"n":"Dal Tadka","p":140,"h":70,"c":"Veg","q":0,"t":"v"},
{"n":"Dal Gotala","p":160,"h":80,"c":"Veg","q":0,"t":"v"},
{"n":"Butter Dal Fry","p":140,"h":70,"c":"Veg","q":0,"t":"v"},
{"n":"Dal Fry","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Sabji Fry","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Sev Tameta","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Masala Rice","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Biryani Rice","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Jeera Rice","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Kadi Khichdi","p":60,"h":30,"c":"Veg","q":0,"t":"v"},
{"n":"Dal Pulav","p":100,"h":50,"c":"Veg","q":0,"t":"v"},
{"n":"Plain Rice","p":60,"h":30,"c":"Roti","q":0,"t":"v"},
{"n":"Special Roti","p":15,"h":15,"c":"Roti","q":0,"t":"v"},
{"n":"Special Paratha","p":20,"h":20,"c":"Roti","q":0,"t":"v"},
{"n":"Butter Roti","p":15,"h":15,"c":"Roti","q":0,"t":"v"},
{"n":"Chapati Roti","p":7,"h":7,"c":"Roti","q":0,"t":"v"},
{"n":"Papad Fry","p":10,"h":10,"c":"Roti","q":0,"t":"v"},
];
List get f=>menu.where((m){bool c1=cat=="All"||m["c"]==cat;bool c2=m["n"].toString().toLowerCase().contains(s.toLowerCase());return c1&&c2;}).toList();
int get tot=>menu.fold(0,(a,b)=>a+(b["p"] as int)*(b["q"] as int));
@override Widget build(BuildContext context){
return Scaffold(
appBar:AppBar(title:Text("KGN TAWA FRY - 59 Items"),backgroundColor:Color(0xFFA33900),foregroundColor:Colors.white),
body:Column(children:[
Padding(padding:EdgeInsets.all(8),child:TextField(onChanged:(v)=>setState(()=>s=v),decoration:InputDecoration(hintText:"Search 59 items...",prefixIcon:Icon(Icons.search),border:OutlineInputBorder(borderRadius:BorderRadius.circular(12))))),
SizedBox(height:40,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:cats.length,itemBuilder:(c,i)=>Padding(padding:EdgeInsets.only(right:6,left:i==0?8:0),child:ChoiceChip(label:Text(cats[i]),selected:cat==cats[i],onSelected:(v)=>setState(()=>cat=cats[i]))))),
Expanded(child:ListView.builder(padding:EdgeInsets.all(8),itemCount:f.length,itemBuilder:(c,i){var m=f[i];return Card(child:ListTile(title:Text(m["n"],style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text("Half \u20B9${m["h"]} | Full \u20B9${m["p"]}"),leading:Icon(m["t"]=="v"?Icons.circle:Icons.play_arrow,color:m["t"]=="v"?Colors.green:Colors.red,size:16),trailing:m["q"]>0?Row(mainAxisSize:MainAxisSize.min,children:[IconButton(icon:Icon(Icons.remove),onPressed:()=>setState(()=>m["q"]--)),Text("${m["q"]}"),IconButton(icon:Icon(Icons.add),onPressed:()=>setState(()=>m["q"]++))]):ElevatedButton(onPressed:()=>setState(()=>m["q"]=1),child:Text("Add"))));})),
]),
bottomNavigationBar:tot>0?Container(padding:EdgeInsets.all(12),color:Colors.white,child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text("Total \u20B9$tot",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFA33900),foregroundColor:Colors.white),onPressed:(){},child:Text("Print KOT"))])):null,
);
}
}
