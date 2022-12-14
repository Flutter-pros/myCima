import 'package:cima_app/controller/api.dart';
import 'package:cima_app/controller/menu_view_controller.dart';
import 'package:cima_app/models/menu_api_model.dart';
import 'package:cima_app/models/texonomy_model.dart';
import 'package:cima_app/screens/films_screen.dart';
import 'package:cima_app/screens/home_screen.dart';
import 'package:cima_app/screens/series_screen.dart';
import 'package:cima_app/screens/sub_category.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  MenuController menuController = MenuController();
  MenuApi menuApi = MenuApi();
  TaxonomyApi taxonomyApi =TaxonomyApi();
  late Future<List<TaxonomyModel>> taxonomyData;
  bool isSeries = true;
  late Future<List<MenuModel>> menuData;
  Children children=Children();
  List<Widget>icons=[
    const Icon(Icons.drive_file_move),
    const Icon(Icons.live_tv),
    const Icon(Icons.file_download),
    const Icon(Icons.live_tv),
    const Icon(Icons.search),

  ];

  @override
  void initState() {
    // TODO: implement initState
    menuData = menuApi.getDataMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromRGBO(14, 19, 49, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            children: [
              Container(
                margin:const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(35, 40, 72, 1),
                ),
                child: TextFormField(
                  decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(35, 40, 72, 1),
                      ),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                    hintText: '    ???????? ???? ?????? ????????',

                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search,color: Colors.white,),
                      onPressed: (){

                      },
                    )
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(35, 40, 72, 1),
                ),
                height: 60,
                width: double.infinity,
                child:  ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                  },
                  title: const Text(
                    '???????????? ????????????????',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
              FutureBuilder<List<MenuModel>>(
                  future: menuData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<MenuModel>;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            //height: 70,
                            margin: const EdgeInsets.only(
                                top: 2, left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(35, 40, 72, 1),
                            ),
                            child: ExpansionTile(

                              // initiallyExpanded: true,
                              //maintainState: true,
                              // childrenPadding: EdgeInsets.zero,
                               tilePadding: EdgeInsets.zero,
                              title:ListTile(
                                title:  InkWell(
                                  onTap: (){
                                    if(index==0){
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context)=>const FilmsScreen()),
                                      );

                                    }else if(index==1){
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context)=>const SeriesScreen()),
                                      );
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  child: Text(
                                    "${data[index].name}",
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    //  textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                      maxWidth: 20,
                                      maxHeight: 20,
                                    ),
                                    child: InkWell(
                                        onTap: (){
                                          return null;
                                        },
                                        child: icons[index]),
                                  ),
                              ),
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxHeight: 400, minHeight: 10.0),
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    //scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    //physics: const BouncingScrollPhysics(),
                                    itemCount: data[index].children!.length,
                                    itemBuilder: (context, index2) {
                                      final name =
                                          data[index].children![index2].name;
                                      return GestureDetector(
                                        onTap: () {
                                          // taxonomyApi.getCategory(
                                          //     data[index].children![index2].name!,
                                          //     data[index].children![index2].id!
                                          // taxonomyApi.getSubCategory(
                                          //    // '${children.name}',
                                          //     '${children.id}'
                                          // );
                                          // Navigator.push(context, MaterialPageRoute(
                                          //     builder: (context)=>const SubCategoryItem()));
                                          //   if(index==0){
                                          //     Navigator.push(context, MaterialPageRoute(
                                          //              builder: (context)=>const FilmsScreen()));
                                           // }

                                          // setState(() {
                                          //   //    taxonomyApi.getCategory(
                                          //   //       // data[index].children![index2].id!,
                                          //   //     // filter: data[index].children![index2].name!,
                                          //   //
                                          //   // );
                                          //      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                                          //   // menuController.categoryData =
                                          //   //     FilteredData(
                                          //   //         termID: data[index]
                                          //   //             .children![index2]
                                          //   //             .id!);
                                          //   // (index == 0)
                                          //   //     ? isSeries = false
                                          //   //     : isSeries = true;
                                          //   // Navigator.pop(context);
                                          // });
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=> SubCategoryItem(
                                                subItems:TaxonomyApi().getSubCategory(
                                                  id: "${data[index].children![index2].id}"
                                                ),
                                              )));
                                        },
                                        child: ListTile(
                                          title: Text(
                                            name!,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],

                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      if (kDebugMode) {
                        print(snapshot.error.toString());
                      }
                      return const Text('has error');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ));
  }
}


/*
Column(
              children:  [
                const ListTile(
                  title:  Text(
                    '???????????? ????????????????',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                 trailing: Icon(Icons.home,color: Colors.blue,size: 30,),
                ),
                FutureBuilder(
                    future: menuData ,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return  ExpansionTile(
                                // childrenPadding: EdgeInsets.zero,
                                // tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "${snapshot.data[index]['name']}",
                                  style: const TextStyle(
                                      fontSize:18.0, fontWeight:  FontWeight.w500,color: Colors.white),
                                ),
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 250,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: snapshot.data[index]["children"].length,
                                        itemBuilder: (context,index2){
                                          String name=snapshot.data[index]["children"][index2]['name'];
                                          return GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                menuController.categoryData =
                                                    FilteredData(
                                                        termID: snapshot.data[index]["children"]
                                                        [index2]["id"]);
                                                (index == 0)
                                                    ? isSeries = false
                                                    : isSeries = true;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(name,style: const TextStyle(
                                                fontSize:18.0, fontWeight:  FontWeight.w500,color: Colors.white),),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );

                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),

              ],
            ),
 */
/*
Column(
              children:  [
                const ListTile(
                  title:  Text(
                    '???????????? ????????????????',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                 trailing: Icon(Icons.home,color: Colors.blue,size: 30,),
                ),
                FutureBuilder(
                    future: menuController.apiMenu.getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return  ExpansionTile(
                                // childrenPadding: EdgeInsets.zero,
                                // tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "${snapshot.data[index]['name']}",
                                  style: const TextStyle(
                                      fontSize:18.0, fontWeight:  FontWeight.w500,color: Colors.white),
                                ),
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 250,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: snapshot.data[index]["children"].length,
                                        itemBuilder: (context,index2){
                                          String name=snapshot.data[index]["children"][index2]['name'];
                                          return GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                menuController.categoryData =
                                                    FilteredData(
                                                        termID: snapshot.data[index]["children"]
                                                        [index2]["id"]);
                                                (index == 0)
                                                    ? isSeries = false
                                                    : isSeries = true;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(name,style: const TextStyle(
                                                fontSize:18.0, fontWeight:  FontWeight.w500,color: Colors.white),),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );

                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),

              ],
            ),
 */
