import 'package:flutter/material.dart';
import 'package:flutter_application_1/dreamplacescreen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/favorite/favorite_provider.dart';
import 'app_router.dart';
import 'package:go_router/go_router.dart';
import 'features/places/places_provider.dart';
import 'features/places/place.dart';

void main() {
  runApp(
    const ProviderScope(
      child:MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp.router(
          routerConfig: goRouter,
          title: 'Wybierz miejsce',
  
        );
    }
}

class HomeScreen extends ConsumerWidget{
  
  const HomeScreen({super.key});
  Card maker(BuildContext context,Place dps){
    
    return Card(
      color: Color.fromRGBO(77, 114, 216, 0.757),
      shadowColor:  Color.fromRGBO(38, 72, 165, 0.76),
      elevation: 5,
      shape:RoundedRectangleBorder(borderRadius: .circular(20)),
      child:ListTile(
            
            title: Expanded(child:Text(dps.title,style:TextStyle(fontSize: 20))),
            leading: SizedBox(
              width:MediaQuery.of(context).size.width * 0.35,
              child:ClipRRect(
                borderRadius: .circular(20),
                child:Image.asset(dps.path,fit: BoxFit.cover)
              )
              
            ),
            trailing: Row(
              mainAxisSize: .min,
              spacing: 20,
              children:[
                Icon(dps.isFavorite ? Icons.favorite : Icons.favorite_border),
                Icon(Icons.arrow_forward_ios),]),

            onTap: (){
              GoRouter.of(context).push("${DreamPlaceScreen.route}/${dps.id}");
            },
    ));
  }
  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      backgroundColor: Color.fromRGBO(76, 108, 248, 0.867),
      body: ListView(
        children: [
          maker(context,ref.watch(placesProvider)[0]),
          maker(context,ref.watch(placesProvider)[1]),
          maker(context,ref.watch(placesProvider)[2]),
          maker(context,ref.watch(placesProvider)[3]),
          maker(context,ref.watch(placesProvider)[4])

        ]),
    
     appBar: AppBar(
        backgroundColor:  Color.fromRGBO(38, 72, 165, 0.76),
        title: Text("Wybierz miejsce"),
      ),
    );
  }
}