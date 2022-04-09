import 'package:flutter/material.dart';
import 'package:my_project/helper/ui/ui_library.dart';



class CommunityView extends StatefulWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {

  int indexPost = 5;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Scaffold(

          body: ListView.builder(
              itemCount: indexPost,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  child: Card(
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.account_circle,
                                        size: 35,),
                                      //radius: 13,
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Pablo Lopez"),
                                  ]
                              ),),


                            Row (
                              children: [
                                Text("hace 15 min"),
                                IconButton(
                                    onPressed: () {},
                                    splashRadius: 5,
                                    icon: Icon(Icons.more_vert))
                              ],
                            ),


                          ],
                        ),


                        Padding(
                          padding: EdgeInsets.only(left: 6, right: 6),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.black54,
                                thickness: 2,
                                indent: 0,
                                endIndent: 00,
                              ),
                              Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenea"),
                            ],
                          ),),



                        ButtonBar(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.mode_comment_outlined)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.repeat)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.favorite))
                          ],
                        )

                      ],
                    ),


                  ),
                );
              }
          ),


          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.black54,
            selectedLabelStyle: TextStyle(fontSize: 12),
            unselectedLabelStyle: TextStyle(fontSize: 12),

            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.autorenew,
                    /*color: Colors.black54,*/),
                  label: 'Refrescar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Buscar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.create_outlined),
                  label: 'Realizar Post'),


            ],

          ),
        ));
  }
}