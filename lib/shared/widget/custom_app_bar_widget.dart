import 'package:bookly_app/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

Padding appBarWidget({required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
    child: Row(
      children: [
        Image.asset('asset/image/Logo.png',height: 18.0,),
        const Spacer(),
        IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
          },
          icon: const Icon(
            Icons.search_outlined,
            size: 22.0,
          ),
        ),
      ],
    ),
  );
}
