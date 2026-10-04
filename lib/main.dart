import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main(){runApp(MaterialApp(debugShowCheckedModeBanner:false,home:LoginScreen()));}

class LoginScreen extends StatefulWidget{
  @override State<LoginScreen> createState()=>_LoginState();
}
class _LoginState extends State<LoginScreen>{
  String sel="Salman";
  List<String> waiters=["Salman","Aslam","Imran","Rizwan","Admin"];
  @override Widget build(BuildContext c){
    return Scaffold(
      backgroundColor:Color(0xFFFFF3E0),
      body:Center(child:Padding(padding:EdgeInsets.all(24),
        child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
          Icon(Icons.restaurant,size:70,color:Colors.deepOrange),
          SizedBox(height:12),
          Text("KGN TAWA FRY",style:TextStyle(fontSize:26,fontWeight:FontWeight.bold,color:Colors.deepOrange)),
          Text("PRO - NO GST",style:TextStyle(color:Colors.grey)),
          SizedBox(height:20),
          ...waiters.map((w)=>Card(
            child:RadioListTile(
              title:Text(w), value:w, groupValue:sel,
              onChanged:(v){setState(()=>sel=v.toString());},
              activeColor:Colors.deepOrange
            )
          )).toList(),
          SizedBox(height:16),
          ElevatedButton(
            onPressed:(){Navigator.pushReplacement(c,MaterialPageRoute(builder:(_)=>MainApp(waiterName:sel)));},
            child:Text("LOGIN  "+sel),
            style:ElevatedButton.styleFrom(backgroundColor:Colors.deepOrange,foregroundColor:Colors.white,minimumSize:Size(double.infinity,50))
          )
        ])
      ))
    );
  }
}

class MainApp extends StatefulWidget{
  final String waiterName;
  MainApp({required this.waiterName});
  @override State<MainApp> createState()=>_MainState();
}
class _MainState extends State<MainApp>{
  int idx=0;
  List<Map<String,dynamic>> tables=List.generate(8,(i)=>{"id":i+1,"name":"T-${i+1}","status":"Empty","amount":0.0,"pax":0,"items":[],"time":"","isHold":false,"waiter":"","startTime":null,"discount":0.0});
  List<Map<String,dynamic>> history=[];
  double dayCollection=0;
  FlutterTts tts=FlutterTts();
  List<Map<String,dynamic>> menu=[
    {"name":"Murgh Do Pyaza","half":160,"full":300,"cat":"Chicken"},
    {"name":"Murgh Mughlai","half":170,"full":320,"cat":"Chicken"},
    {"name":"Chicken Handi","half":160,"full":300,"cat":"Chicken"},
    {"name":"Chicken Pesawar","half":170,"full":320,"cat":"Chicken"},
    {"name":"Murgh Shahi","half":170,"full":320,"cat":"Chicken"},
    {"name":"Malai Tikka","half":180,"full":350,"cat":"Chicken"},
    {"name":"Tikka Masala","half":170,"full":320,"cat":"Chicken"},
    {"name":"Chicken Karahi","half":160,"full":300,"cat":"Chicken"},
    {"name":"Chicken Garlic","half":160,"full":300,"cat":"Chicken"},
    {"name":"Chicken India","half":250,"full":450,"cat":"Chicken"},
    {"name":"Butter Chicken","half":170,"full":320,"cat":"Chicken"},
    {"name":"White Chicken","half":180,"full":350,"cat":"Chicken"},
    {"name":"Green Chicken","half":180,"full":350,"cat":"Chicken"},
    {"name":"Chicken Fry","half":120,"full":220,"cat":"Chicken"},
    {"name":"Chicken Masala","half":120,"full":220,"cat":"Chicken"},
    {"name":"Chicken Biryani","half":80,"full":120,"cat":"Biryani"},
    {"name":"Tandoori Masala","half":250,"full":480,"cat":"Chicken"},
    {"name":"Ahmedabadi","half":160,"full":320,"cat":"Chicken"},
    {"name":"Tikka Rice","half":170,"full":320,"cat":"Rice"},
    {"name":"Mughlai Mutton","half":150,"full":280,"cat":"Mutton"},
    {"name":"DalBati Gos","half":150,"full":280,"cat":"Mutton"},
    {"name":"White Mutton","half":160,"full":300,"cat":"Mutton"},
    {"name":"Green Mutton","half":150,"full":280,"cat":"Mutton"},
    {"name":"Mutton Kurma","half":160,"full":300,"cat":"Mutton"},
    {"name":"Mutton Fry","half":120,"full":220,"cat":"Mutton"},
    {"name":"Mutton Masala","half":120,"full":220,"cat":"Mutton"},
    {"name":"Kaleji Masala","half":120,"full":220,"cat":"Mutton"},
    {"name":"Bhaji Gos","half":130,"full":240,"cat":"Mutton"},
    {"name":"Paya Fry","half":120,"full":220,"cat":"Mutton"},
    {"name":"Champ Fry","half":120,"full":220,"cat":"Mutton"},
    {"name":"Bheja Fry","half":130,"full":240,"cat":"Mutton"},
    {"name":"Boti Masala","half":120,"full":220,"cat":"Mutton"},
    {"name":"Kheema Fry","half":80,"full":160,"cat":"Mutton"},
    {"name":"Kheema Pulav","half":100,"full":180,"cat":"Rice"},
    {"name":"Fish Fry","half":80,"full":160,"cat":"Fish"},
    {"name":"Fish Kadhi","half":100,"full":200,"cat":"Fish"},
    {"name":"Prawns Fry","half":130,"full":240,"cat":"Fish"},
    {"name":"Prawns Rice","half":170,"full":320,"cat":"Rice"},
    {"name":"Anda Kadhi","half":80,"full":160,"cat":"Egg"},
    {"name":"Anda Kheema","half":80,"full":160,"cat":"Egg"},
    {"name":"Anda Bhurji","half":50,"full":100,"cat":"Egg"},
    {"name":"Anda Pulav","half":60,"full":120,"cat":"Rice"},
    {"name":"Dal Tadka","half":70,"full":140,"cat":"Veg"},
    {"name":"Dal Gotala","half":80,"full":160,"cat":"Veg"},
    {"name":"Butter Dal","half":70,"full":140,"cat":"Veg"},
    {"name":"Dal Fry","half":50,"full":100,"cat":"Veg"},
    {"name":"Sabji Fry","half":50,"full":100,"cat":"Veg"},
    {"name":"Sev Tameta","half":50,"full":100,"cat":"Veg"},
    {"name":"Masala Rice","half":50,"full":100,"cat":"Rice"},
    {"name":"Biryani Rice","half":50,"full":100,"cat":"Rice"},
    {"name":"Jeera Rice","half":50,"full":100,"cat":"Rice"},
    {"name":"Kadhi Khichdi","half":30,"full":60,"cat":"Rice"},
    {"name":"Dal Pulav","half":50,"full":100,"cat":"Rice"},
    {"name":"Plain Rice","half":50,"full":100,"cat":"Rice"},
    {"name":"Special Roti","half":15,"full":15,"cat":"Roti"},
    {"name":"Paratha","half":20,"full":20,"cat":"Roti"},
    {"name":"Butter Roti","half":15,"full":15,"cat":"Roti"},
    {"name":"Chapati","half":7,"full":7,"cat":"Roti"},
    {"name":"Papad Fry","half":10,"full":10,"cat":"Roti"},
  ];

  void clearTable(int i){
    setState(()=>tables[i]={
      "id":i+1,"name":"T-${i+1}","status":"Empty","amount":0.0,
      "pax":0,"items":[],"time":"","isHold":false,
      "waiter":"","startTime":null,"discount":0.0
    });
  }

  void transferTable(int from,int to){
    if(tables[to]["status"]!="Empty") return;
    setState((){
      tables[to]=Map.from(tables[from]);
      tables[to]["name"]="T-${to+1}";
      tables[to]["id"]=to+1;
      clearTable(from);
    });
  }

  @override Widget build(BuildContext c){
    List<Widget> pages=[
      TableGrid(tables:tables,waiterName:widget.waiterName,
        onTapTable:(i){
          Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderScreen(
            table:tables[i],menu:menu,
            onSave:(o){
              setState((){
                o["waiter"]=widget.waiterName;
                if(o["status"]=="Occupied" && tables[i]["startTime"]==null){
                  o["startTime"]=DateTime.now();
                } else {
                  o["startTime"]=tables[i]["startTime"];
                }
                tables[i]=o;
                history.add(o);
                double tot=(o["amount"] as num).toDouble() - (o["discount"] as num).toDouble();
                dayCollection+=tot;
              });
            }
          )));
        },
        onTransfer:(f,t)=>transferTable(f,t)
      ),
      NewOrderQuick(tables:tables,onSelect:(i){
        setState(()=>idx=0);
        Navigator.push(c,MaterialPageRoute(builder:(_)=>OrderScreen(
          table:tables[i],menu:menu,
          onSave:(o){
            setState((){
              o["waiter"]=widget.waiterName;
              if(tables[i]["startTime"]==null) o["startTime"]=DateTime.now();
              else o["startTime"]=tables[i]["startTime"];
              tables[i]=o;
              history.add(o);
              double tot=(o["amount"] as num).toDouble() - (o["discount"] as num).toDouble();
              dayCollection+=tot;
            });
          }
        )));
      }),
      KOTScreen(tables:tables),
      OrdersScreen(tables:tables,onClear:(i)=>clearTable(i)),
      SummaryScreen(tables:tables,history:history,dayCollection:dayCollection,
        waiterName:widget.waiterName,
        onReset:(){setState((){dayCollection=0; history.clear();});}
      ),
      AdminScreen(menu:menu,onSave:(m){setState(()=>menu=m);}),
    ];

    return Scaffold(
      backgroundColor:Color(0xFFFFF9F5),
      appBar:AppBar(
        title:Text(idx==0?"KGN - "+widget.waiterName:idx==1?"New Order":idx==2?"KOT":idx==3?"Bills":idx==4?"Report":"Admin"),
        backgroundColor:Colors.deepOrange, foregroundColor:Colors.white,
        actions:[IconButton(icon:Icon(Icons.logout),onPressed:(){Navigator.pushReplacement(c,MaterialPageRoute(builder:(_)=>LoginScreen()));})]
      ),
      body:pages[idx],
      bottomNavigationBar:BottomNavigationBar(
        currentIndex:idx,
        onTap:(i)=>setState(()=>idx=i),
        selectedItemColor:Colors.deepOrange, unselectedItemColor:Colors.grey,
        type:BottomNavigationBarType.fixed,
        items:[
          BottomNavigationBarItem(icon:Icon(Icons.table_restaurant),label:"Tables"),
          BottomNavigationBarItem(icon:Icon(Icons.add_circle),label:"New"),
          BottomNavigationBarItem(icon:Icon(Icons.restaurant_menu),label:"KOT"),
          BottomNavigationBarItem(icon:Icon(Icons.receipt_long),label:"Bills"),
          BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label:"Report"),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label:"Admin"),
        ]
      )
    );
  }
}

class TableGrid extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final String waiterName;
  final Function(int) onTapTable;
  final Function(int,int) onTransfer;
  TableGrid({required this.tables,required this.waiterName,required this.onTapTable,required this.onTransfer});

  String getDuration(DateTime? start){
    if(start==null) return "";
    int m=DateTime.now().difference(start).inMinutes;
    return "${m}m";
  }

  @override Widget build(BuildContext c){
    return Column(children:[
      Container(padding:EdgeInsets.all(8),color:Colors.orange.shade100,
        child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
          Text("Waiter: "+waiterName,style:TextStyle(fontWeight:FontWeight.bold)),
          Text("Occ: ${tables.where((t)=>t["status"]=="Occupied").length}/8")
        ])
      ),
      Expanded(child:GridView.builder(
        padding:EdgeInsets.all(12),
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:12,mainAxisSpacing:12),
        itemCount:tables.length,
        itemBuilder:(co,i){
          var t=tables[i];
          Color col=t["status"]=="Empty"?Colors.green.shade100:t["isHold"]==true?Colors.yellow.shade100:Colors.red.shade100;
          return InkWell(
            onTap:()=>onTapTable(i),
            onLongPress:(){
              showDialog(context:co,builder:(ctx)=>AlertDialog(
                title:Text("Transfer "+t["name"]),
                content:Column(mainAxisSize:MainAxisSize.min,children:
                  tables.where((x)=>x["status"]=="Empty").map((e)=>ListTile(
                    title:Text(e["name"]),
                    onTap:(){Navigator.pop(ctx); onTransfer(i,e["id"]-1);}
                  )).toList()
                ),
                actions:[TextButton(onPressed:()=>Navigator.pop(ctx),child:Text("Cancel"))]
              ));
            },
            child:Container(
              decoration:BoxDecoration(color:col,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.orange.shade200)),
              child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
                Text(t["name"],style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                Text(t["status"],style:TextStyle(fontWeight:FontWeight.bold,color:t["status"]=="Empty"?Colors.green:Colors.red)),
                if((t["amount"] as num)>0) Text("Rs "+(t["amount"]- (t["discount"]??0)).toStringAsFixed(0),style:TextStyle(fontWeight:FontWeight.bold)),
                Text("PAX ${t["pax"]} | ${t["items"].length} Items",style:TextStyle(fontSize:10)),
                if(t["waiter"]!="") Text(t["waiter"],style:TextStyle(fontSize:10,color:Colors.blue)),
                if(t["startTime"]!=null) Text(getDuration(t["startTime"])+" ago",style:TextStyle(fontSize:9)),
                if(t["isHold"]==true) Text("HOLD",style:TextStyle(fontSize:10,color:Colors.orange,fontWeight:FontWeight.bold)),
              ])
            )
          );
        }
      ))
    ]);
  }
}

class NewOrderQuick extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final Function(int) onSelect;
  NewOrderQuick({required this.tables,required this.onSelect});
  @override Widget build(BuildContext c){
    return ListView.builder(
      padding:EdgeInsets.all(12),
      itemCount:tables.length,
      itemBuilder:(co,i){
        var t=tables[i];
        return Card(child:ListTile(
          leading:CircleAvatar(backgroundColor:t["status"]=="Empty"?Colors.green:Colors.red,child:Text(t["name"],style:TextStyle(color:Colors.white,fontSize:12))),
          title:Text(t["name"].toString()+" - "+t["status"].toString()),
          subtitle:Text(t["status"]=="Occupied"?"Rs "+(t["amount"]-(t["discount"]??0)).toString()+" | "+t["waiter"]:"Empty"),
          trailing:Icon(Icons.arrow_forward),
          onTap:()=>onSelect(i)
        ));
      }
    );
  }
}

class KOTScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  KOTScreen({required this.tables});
  @override Widget build(BuildContext c){
    var live=tables.where((t)=>t["status"]=="Occupied").toList();
    if(live.isEmpty) return Center(child:Text("No Live Orders"));
    return ListView.builder(
      padding:EdgeInsets.all(12),
      itemCount:live.length,
      itemBuilder:(co,i){
        var t=live[i];
        return Card(color:Color(0xFFFFF3E0),child:Padding(padding:EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
            Text(t["name"].toString()+" - KOT ["+t["waiter"].toString()+"]",style:TextStyle(fontWeight:FontWeight.bold)),
            Text(t["time"].toString())
          ]),
          Divider(),
          ...List.generate(t["items"].length,(j){
            var it=t["items"][j];
            int ex=it["extraButter"]==true?20:0;
            int pr=(it["price"] as int)*(it["qty"] as int)+ex;
            String portion=it["portion"]??"Full";
            return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
              Expanded(child:Text("${j+1}. ${it["name"]} [$portion]",style:TextStyle(fontSize:12,fontWeight:FontWeight.bold))),
              Text("x${it["qty"]} Rs $pr",style:TextStyle(fontSize:12))
            ]);
          }),
          if(t["isHold"]==true) Container(margin:EdgeInsets.only(top:8),padding:EdgeInsets.all(6),color:Colors.yellow.shade200,child:Text("HOLD - Wait",style:TextStyle(fontWeight:FontWeight.bold,fontSize:12))),
          SizedBox(height:8),
          ElevatedButton.icon(icon:Icon(Icons.print,size:16),label:Text("Print KOT"),
            onPressed:(){
              showDialog(context:co,builder:(_)=>AlertDialog(
                title:Text("KOT - "+t["name"]),
                content:Text(t["items"].map((e)=>e["name"].toString()+" ["+ (e["portion"]??"Full") +"] x"+e["qty"].toString()).join("\n")),
                actions:[TextButton(onPressed:()=>Navigator.pop(co),child:Text("OK"))]
              ));
            },
            style:ElevatedButton.styleFrom(backgroundColor:Colors.orange,foregroundColor:Colors.white)
          )
        ])));
      }
    );
  }
}

class OrdersScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final Function(int) onClear;
  OrdersScreen({required this.tables,required this.onClear});
  @override Widget build(BuildContext c){
    var occ=tables.where((t)=>t["status"]=="Occupied").toList();
    if(occ.isEmpty) return Center(child:Text("No Bills"));
    return ListView.builder(
      padding:EdgeInsets.all(12),
      itemCount:occ.length,
      itemBuilder:(co,i){
        var t=occ[i];
        int ri=tables.indexWhere((x)=>x["id"]==t["id"]);
        double sub=t["items"].fold(0.0,(s,it)=>s+ (it["price"]*it["qty"])+(it["extraButter"]==true?20:0));
        double disc=(t["discount"]??0).toDouble();
        double tot=sub-disc;
        return Card(child:ExpansionTile(
          title:Text(t["name"].toString()+" - Rs "+tot.toStringAsFixed(0),style:TextStyle(fontWeight:FontWeight.bold)),
          subtitle:Text("${t["pax"]} Pax | ${t["time"]} | ${t["waiter"]}"),
          children:[
            ...List.generate(t["items"].length,(j){
              var it=t["items"][j];
              int ex=it["extraButter"]==true?20:0;
              int pr=(it["price"] as int)*(it["qty"] as int)+ex;
              String portion=it["portion"]??"Full";
              return ListTile(title:Text(it["name"].toString()+" ["+portion+"]",style:TextStyle(fontSize:13)),trailing:Text("Rs $pr"));
            }),
            Divider(),
            ListTile(title:Text("Subtotal"),trailing:Text("Rs "+sub.toStringAsFixed(0))),
            if(disc>0) ListTile(title:Text("Discount"),trailing:Text("-Rs "+disc.toStringAsFixed(0))),
            ListTile(title:Text("TOTAL (No GST)",style:TextStyle(fontWeight:FontWeight.bold)),trailing:Text("Rs "+tot.toStringAsFixed(0),style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))),
            Padding(padding:EdgeInsets.all(8),child:Row(children:[
              Expanded(child:ElevatedButton.icon(icon:Icon(Icons.print),label:Text("Bill"),
                onPressed:(){
                  showDialog(context:co,builder:(_)=>AlertDialog(
                    title:Text("BILL - "+t["name"]),
                    content:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[
                      Text("KGN TAWA FRY"),
                      Text(t["name"]+" | "+t["waiter"]),
                      Divider(),
                      ...t["items"].map((e)=>Text(e["name"].toString()+" x"+e["qty"].toString(),style:TextStyle(fontSize:11))).toList(),
                      Divider(),
                      Text("TOTAL Rs "+tot.toStringAsFixed(0),style:TextStyle(fontWeight:FontWeight.bold)),
                      SizedBox(height:8),
                      Text("UPI: kgn@upi"),
                    ]),
                    actions:[TextButton(onPressed:()=>Navigator.pop(co),child:Text("OK"))]
                  ));
                },
                style:ElevatedButton.styleFrom(backgroundColor:Colors.blue,foregroundColor:Colors.white)
              )),
              SizedBox(width:8),
              Expanded(child:ElevatedButton(onPressed:()=>onClear(ri),child:Text("Paid Clear"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white))),
            ])),
            SizedBox(height:8)
          ]
        ));
      }
    );
  }
}

class SummaryScreen extends StatelessWidget{
  final List<Map<String,dynamic>> tables;
  final List<Map<String,dynamic>> history;
  final double dayCollection;
  final String waiterName;
  final VoidCallback onReset;
  SummaryScreen({required this.tables,required this.history,required this.dayCollection,required this.waiterName,required this.onReset});
  @override Widget build(BuildContext c){
    int occ=tables.where((t)=>t["status"]=="Occupied").length;
    double live=tables.fold(0,(s,t)=>s+((t["amount"] as num).toDouble() - ((t["discount"]??0) as num).toDouble()));
    Map<String,double> waiterWise={};
    for(var h in history){
      String w=h["waiter"]??"Unknown";
      double amt=(h["amount"] as num).toDouble() - ((h["discount"]??0) as num).toDouble();
      waiterWise[w]=(waiterWise[w]??0)+amt;
    }
    return ListView(padding:EdgeInsets.all(16),children:[
      Card(col
