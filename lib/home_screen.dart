import 'package:apartment_complex/booking_screen.dart';
import 'package:flutter/material.dart';

import 'model/apartment_model.dart';

class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            leading: Container(),
            expandedHeight: 150.0,
            floating: true, pinned: true, snap: false,
            backgroundColor: Color(0xFF007FFF),

            flexibleSpace:  const FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text("Book An Appointment",
                style: TextStyle( fontFamily: 'lobster',fontSize: 20,fontWeight: FontWeight.bold,color:Colors.white),)),


          ),

          SliverList(delegate: SliverChildBuilderDelegate((context, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingScreen((apartmentModelList[index]))));
              },
              child: Hero(
                tag: apartmentModelList[index].id,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(apartmentModelList[index].imageAsset,height: 200,fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(apartmentModelList[index].name,style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text('\$${apartmentModelList[index].price}/night',style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star,color: Colors.green,size: 20,),
                                        Text('${apartmentModelList[index].reviews} reviews',style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.wifi,color: Color(0xFF007FFF)),
                                        Icon(Icons.beach_access,color: Colors.purpleAccent,)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },childCount: apartmentModelList.length))
        ],
      ),
    );
  }
}
