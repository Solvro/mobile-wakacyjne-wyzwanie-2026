import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Homescreen(),
            
        );
    }
}

class Homescreen extends StatelessWidget{
  Homescreen({super.key});
  final japonia = DreamPlaceScreen(
    backcolor:Color.fromARGB(255, 110, 110, 233),
    text1:"Kyoto, dawna stolica Japonii",
    text2:"Serce japońskiej kultury, które mieści tysiące świątyń, pięknych ogrodów i tradycyjnych herbaciarni.",
    path:'assets/images/obrazek.webp',
    listastr:["Jedzenie","Herbata","Świątynie i zamki","Ogrody"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.emoji_food_beverage_outlined),Icon(Icons.castle),Icon(Icons.place)],
    title:"Kyoto, Japonia"
  );
  final grecja = DreamPlaceScreen(
    backcolor:Color.fromARGB(255, 91, 207, 223),
    text1:"Białe klify Zakynthos",
    text2:"Jedna z najbardziej malowniczych wysp Grecji.",
    path:'assets/images/grecja.webp',
    listastr:["Jedzenie","Nurkowanie","Plaże","Zwiedzanie"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.scuba_diving),Icon(Icons.beach_access),Icon(Icons.place)],
    title:"Zakynthos, Grecja"
  );
  final hisz = DreamPlaceScreen(
    backcolor:Color.fromARGB(255, 238, 223, 90),
    text1:"Malaga, hiszpańskie miasto portowe",
    text2:"Słoneczne miasto na wybrzeżu Costa del Sol.",
    path:'assets/images/hiszpania.webp',
    listastr:["Jedzenie","Teatr","Surfing","Muzeum Picassa"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.theater_comedy),Icon(Icons.surfing),Icon(Icons.art_track)],
    title:"Malaga, Hiszpania"
  );
  final china = DreamPlaceScreen(
    backcolor:Color.fromARGB(255, 238, 80, 80),
    text1:"Chongqing - miasto labirynt",
    text2:"Megamiasto położone w górach, które posiada wielopoziomową architekturę.",
    path:'assets/images/china.jpg',
    listastr:["Jedzenie","Miasto mgieł","Podniebny most","Ogrody"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.foggy),Icon(Icons.cloud),Icon(Icons.place)],
    title:"Chongqing, Chiny"
  );
  final taj = DreamPlaceScreen(
    backcolor:Color.fromARGB(255, 177, 230, 92),
    text1:"Bangkok, stolica Tajlandii",
    text2:"Najczęściej odwiedzane miasto przez turystów z całego świata.",
    path:'assets/images/tajlandia.jpg',
    listastr:["Street food","Nurkowanie","Świątynie i zamki","Dżungla i wyspy"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.scuba_diving_outlined),Icon(Icons.castle),Icon(Icons.place)],
    title:"Bangkok, Tajlandia"
  );

  ListTile maker(BuildContext context,DreamPlaceScreen dps){
    return ListTile(
            
            title: Expanded(child:Text(dps.title,style:TextStyle(fontSize: 20))),
            
            
            leading: SizedBox(
              width:MediaQuery.of(context).size.width * 0.4,
              child:Image.asset(dps.path,fit: BoxFit.cover),
            ),

            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => dps));
                },
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(76, 108, 248, 0.867),
      body: ListView(
        children: [
          maker(context,japonia),
          maker(context,grecja),
          maker(context,hisz),
          maker(context,taj),
          maker(context,china)

        ]),
    
     appBar: AppBar(
        backgroundColor:  Color.fromRGBO(38, 72, 165, 0.76),
        title: Text("Wybierz miejsce"),
      ),
    );
  }
}


class DreamPlaceScreen extends StatefulWidget{
  final String text1,text2,path,title;
  final List<String> listastr;
  final List<Icon> listaicon;
  final Color backcolor;
  DreamPlaceScreen({
    required this.text1,
    required this.text2,
    required this.path,
    required this.title,
    required this.backcolor,
    required this.listaicon,
    required this.listastr,
    super.key
  });
  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();//backcolor,text1,text2,path,listastr,listaicon,title);
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;
  void _toggleFavorite(){
    setState(() {
      if(_isFavorited){
        _isFavorited=false;
      }else{
        _isFavorited=true;
      }
    });
  }
  void onPressed(){
    _toggleFavorite();
  }
  Widget returnIcon(){
      if(_isFavorited){
        return Icon(Icons.favorite);
      }
       return Icon(Icons.favorite_border);   
  }
  _DreamPlaceScreenState();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      backgroundColor: widget.backcolor,
      body: SingleChildScrollView(child:
      Column(
        children: [
          Image.asset(widget.path,fit: BoxFit.cover,),
          Padding(padding: const EdgeInsets.all(16.0),
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(widget.text1,style:TextStyle(fontSize: 20),softWrap:true),
                  SizedBox(height: 8),
                  Text(widget.text2,softWrap:true)
                  ],
                  
              ),),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Column(children:[widget.listaicon[0],Text(widget.listastr[0])]),
                    Column(children:[widget.listaicon[1],Text(widget.listastr[1])]),
                    Column(children:[widget.listaicon[2],Text(widget.listastr[2])]),
                    Column(children:[widget.listaicon[3],Text(widget.listastr[3])])

                ],
              )
          ]),),
      
      
     appBar: AppBar(
        backgroundColor: 
        Color.alphaBlend(const Color.fromARGB(120, 51, 47, 51), widget.backcolor),
        title: Text(widget.title),
        actions: [IconButton(onPressed: onPressed,
         icon: returnIcon())
          ],
      ),
    );
    
  }
}