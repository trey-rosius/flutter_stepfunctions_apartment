import 'package:apartment_complex/model/apartment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
class BookingScreen extends StatefulWidget {
  const BookingScreen(this.apartmentModel);
  final ApartmentModel apartmentModel;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  Future<void> startStepFunctions() async {
    try{
      String graphqlDoc =
          '''
          mutation add(\$id:ID!
                        \$arn:String!) {
  addStepFunction(input: {id: \$id, arn: \$arn}) {
    id
    arn
  }
}
          
          ''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
            document: graphqlDoc,
            apiName: "cdkMomoApi",
            variables: {
              "id":"mobile20983487234",
              "arn":"arn:aws:states:us-east-2:132260253285:stateMachine:MomoStateMachine"
            }

      ));
          var response = await operation.response;

          var data = response.data;

      if (kDebugMode) {
        print('Mutation result is$data');
        print('Mutation error: ${response.errors}');
      }



    }catch(ex){
      if (kDebugMode) {
        print(ex.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            floating:true, pinned: false, snap: false,
            leading: Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 10, right: 5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF007FFF),

              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),


            // backgroundColor:Theme.of(context).accentColor,
            expandedHeight: size.height / 2.2,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Container(
                width: size.width,
                child: Hero(
                  tag: widget.apartmentModel.id,
                  child: InteractiveViewer(
                    panEnabled: true,
                    scaleEnabled: true,
                    child: Container(
                        child: Image.asset( widget.apartmentModel.imageAsset,fit: BoxFit.cover,)),

                  ),
                ),
              ),
            ),
            actions: [

            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.apartmentModel.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Row(

                            children: [
                              Text('\$${widget.apartmentModel.price}',style: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xFF007FFF),
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('/night',style: const TextStyle(
                                  fontSize: 15,

                              ),),
                            ],
                          ),
                        ],
                      )),
                  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",style: TextStyle(color: Colors.grey),),
                 Divider(),
                 Container(

                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                           padding: EdgeInsets.symmetric(vertical: 10),
                           child: Text("Facilities",style: TextStyle(fontWeight: FontWeight.bold),)),
                       Container(
                         height: 60,

                         child: MediaQuery.removePadding(
                           removeTop: true,
                           removeBottom: true,
                           context: (context),
                           child: GridView.count(
                             crossAxisCount:4,
                             children: [
                               Icon(Icons.wifi,color: Color(0xFF007FFF),),
                               Icon(Icons.beach_access,color: Colors.purpleAccent,),
                               Icon(Icons.motorcycle,),
                               Icon(Icons.tv,color: Colors.green,)
                             ],
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
                  Divider(),

                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          print("add demo clicked");
          startStepFunctions();
        },
        child: Container(
          height: 60,
          color:Color(0xFF007FFF),
          alignment: Alignment.center,
          child: Text('Reserve',style: TextStyle( fontFamily: 'lobster',fontSize: 25,color: Colors.white),),
        ),
      ),
    );
  }
}
