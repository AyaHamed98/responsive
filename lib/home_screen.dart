import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsiive/categoryModel.dart';
import 'package:responsiive/extension.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   List<String> imagePaths=[
    "assets/images/AdobeStock_168826035_Preview.jpeg",
    "assets/images/AdobeStock_384552930_Preview.jpeg",
    "assets/images/AdobeStock_396308417_Preview.jpeg",
    "assets/images/AdobeStock_440299419_Preview.jpeg",
    "assets/images/AdobeStock_491170369_Preview.jpeg"
  ];
   List<CategoryModel>categories=[
    CategoryModel(Icons.person, "ولي الامر"),
    CategoryModel(Icons.notes, "طلب مقابلة"),
    CategoryModel(Icons.add_to_queue_outlined, "طلب توظيف"),
    CategoryModel(Icons.featured_play_list_outlined, "نماذج"),
    CategoryModel(Icons.all_inclusive_rounded, "رواب عامة"),
    CategoryModel(Icons.data_array_outlined, " رزنامة العام"),
    CategoryModel(Icons.voicemail_sharp, "تواصل معنا"),
  ];

  @override
  Widget build(BuildContext context) {

    final media=MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        leading:const Icon(Icons.backpack_outlined),
        title:const Text("الصفحة الرئيسية"),
        centerTitle: true,
        actions:const [
          Icon(Icons.logout)
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: context.height*.34,
              child: CarouselSlider.builder(
                  itemCount: imagePaths.length,
                  itemBuilder: (context,index,realIndex)=>carouselSliderItem(context, index),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2)
                  )
              ),
            ),

            media==Orientation.portrait?portrait(context):landScape(context),


            Padding(
                padding: EdgeInsetsDirectional.only(start: media==Orientation.portrait? context.width*.25:context.width*.0),
                child: _itemPortrait(context, categories.length-1))
          ],
        ),
      ),
    );
  }

  GridView portrait(BuildContext context) {
    return GridView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: context.height*.0012,
              ),
              itemCount: categories.length-1,
              itemBuilder: (context,index)=> _itemPortrait(context, index),
          );
  }
  GridView landScape(BuildContext context) {
    final media=MediaQuery.of(context).orientation;
    return GridView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: media==Orientation.portrait? context.width*.001:context.width*.0013
              ),
              itemCount: categories.length-1,
              itemBuilder: (context,index)=> _itemPortrait(context, index),
          );
  }

  Container carouselSliderItem(BuildContext context, int index) {
    return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.width*.14),
                    image: DecorationImage(
                      image:AssetImage( imagePaths[index],),
                      fit: BoxFit.cover,

                    )
                  ),

                );
  }

  Padding _itemPortrait(BuildContext context, int index) {
    final media=MediaQuery.of(context).orientation;
    return Padding(
                padding:  EdgeInsets.all(media==Orientation.portrait? context.width*.02:context.width*.02),
                child: Stack(
                  children: [
                    Container(
                      height:media==Orientation.portrait? context.height*.28:context.height*.7,
                    ),
                   Positioned(
                     top:media==Orientation.portrait? context.width*.12:context.width*.1,

                     child: CircleAvatar(
                       radius:media==Orientation.portrait? context.width*.18:context.width*.1,
                       backgroundColor: Colors.blue,
                       child: CircleAvatar(
                         radius:media==Orientation.portrait? context.width*.17:context.width*.09,
                         backgroundColor: Colors.white,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Icon(categories[index].iconData,size:media==Orientation.portrait? context.width*.18:context.width*.09,),
                             Text(categories[index].txt,style:const TextStyle(fontWeight: FontWeight.bold),)
                           ],
                         ),
                       ),
                     ),
                   ),
                    Positioned(
                        left:media==Orientation.portrait? context.width*.3:context.width*.14,
                        bottom:media==Orientation.portrait? null:context.height*.36,
                        child: Image.asset("assets/images/4295332.png",width: media==Orientation.portrait? context.width*.2:context.width*.15,)),
                  ],
                ),
              );
  }
}
