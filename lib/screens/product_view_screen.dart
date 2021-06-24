import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/model/products.dart';
import 'package:shoppy/provider/detailsProvider.dart';
import 'package:shoppy/screens/homepage.dart';
import 'package:shoppy/screens/select_variant_screen.dart';

import 'details_screen.dart';

class ProductViewScreen extends StatefulWidget {
  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  var _isLoading = true;
  List<Products> details = [];
  getdetails() async {
    details = Provider.of<Detailsprovider>(context, listen: false).cartupdate;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: _isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : details.length == 0
                  ? Center(
                      child: Text('Cart Is Empty'),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Expanded(
                            child: ListView.builder(
                                //shrinkWrap: true,
                                itemCount: details.length,
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(

                                    child: Card(
                                      elevation: .3,
                                      color: Color(0xFFEBEAEF),
                                      margin: EdgeInsets.only(left: deviceSize.width/4/4,right: deviceSize.width/4/4,top: deviceSize.height/4/4/4,bottom: deviceSize.height/4/4/4),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                          width: double.infinity,
                                          height: deviceSize.height / 4 * .7,
                                          child: FittedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          deviceSize.width / 4 / 4/2,
                                                    ),
                                          Container(
                                                height: deviceSize.height / 4 / 3,
                                                width: deviceSize.width / 4 * .9,
                                                decoration: BoxDecoration(
                                                    // color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    'https://images-na.ssl-images-amazon.com/images/I/71gdBQP%2BqGL._UY679_.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: deviceSize.width / 4 / 4 / 2,
                                              ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            details[index]
                                                                .name
                                                                .toString(),
                                                            overflow: TextOverflow
                                                                .ellipsis),
                                                        SizedBox(
                                                          height:
                                                              deviceSize.height /
                                                                  4 /
                                                                  4 /
                                                                  4,
                                                        ),
                                                        Text(
                                                          details[index]
                                                              .unitpr
                                                              .toString(),
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              deviceSize.height /
                                                                  4 /
                                                                  4 /
                                                                  4,
                                                        ),
                                                        Text(
                                                          details[index]
                                                              .specialpr
                                                              .toString(),
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: deviceSize.height /
                                                          4 /
                                                          4),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Variant: " +
                                                            details[index]
                                                                .variant
                                                                .toString(),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(height: deviceSize.height/4/4/4,),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () async {
                                                                print(details[index]
                                                                    .quantity
                                                                    .toString());
                                                                setState(() {
                                                                  Provider.of<Detailsprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .minusproductTocart(
                                                                    details[index]
                                                                        .id,
                                                                    details[index]
                                                                        .unitpr,
                                                                  );
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.delete)),
                                                          // GestureDetector(
                                                          //   child: Container(
                                                          //     //margin: EdgeInsets.all(10),
                                                          //     padding:
                                                          //         EdgeInsets.all(
                                                          //             10),
                                                          //     color: Colors
                                                          //         .yellow[800],
                                                          //     child: Text(
                                                          //         'Select Variant'),
                                                          //   ),
                                                          //   onTap: () {
                                                          //     Navigator.push(
                                                          //         context,
                                                          //         MaterialPageRoute(
                                                          //             builder:
                                                          //                 (ctx) {
                                                          //       return SelectVariantScreen();
                                                          //     }));
                                                          //   },
                                                          // ),
                                                          Container(
                                                            // padding: EdgeInsets.only(bottom: deviceSize.height/4/4/3),
                                                            height:
                                                                deviceSize.height /
                                                                    4 /
                                                                    4 *
                                                                    .8,
                                                                    padding: EdgeInsets.only(bottom: deviceSize.height/4/4/4),
                                          
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            // alignment:
                                                            //     Alignment.center,
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                GestureDetector(
                                                                    child:
                                                                        Container(
                                                                       margin: EdgeInsets.only(
                                                                     
                                                                      left: deviceSize
                                                                              .width /
                                                                          4 /
                                                                          4 /
                                                                          3),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color: Colors
                                                                              .white),
                                                                      child: Icon(
                                                                        Icons
                                                                            .minimize,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      // details[index]
                                                                      //             .quantity !=
                                                                      //         0
                                                                      //     ? await Provider.of<Detailsprovider>(context, listen: false).minusproductTocart(
                                                                      //         details[index]
                                                                      //             .id,
                                                                      //         details[index]
                                                                      //             .unitpr)
                                                                      //     : null;
                                                                      // setState(() {
                                                                      //   details[index].quantity !=
                                                                      //           0
                                                                      //       ? details[index]
                                                                      //           .quantity--
                                                                      //       : null;
                                                                      // });
                                                                    }),
                                          
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: deviceSize
                                                                              .height /
                                                                          4 /
                                                                          4 /
                                                                          4,
                                                                      left: deviceSize
                                                                              .width /
                                                                          4 /
                                                                          4 /
                                                                          3),
                                                                  // padding:
                                                                  //     EdgeInsets
                                                                  //         .all(8),
                                                                  // alignment:
                                                                  //     Alignment
                                                                  //         .center,
                                                                  child: Text(
                                                                    details[index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ),
                                          
                                                                Container(
                                                                
                                                                  child: IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        // await Provider.of<Detailsprovider>(context, listen: false).addProductToCart(
                                                                        //     details[index]
                                                                        //         .id,
                                                                        //     details[index]
                                                                        //         .name,
                                                                        //     details[index]
                                                                        //         .unitpr,
                                                                        //     details[index]
                                                                        //         .specialpr,
                                                                        //     details[index]
                                                                        //         .quantity,
                                                                        //     details[index]
                                                                        //         .variant);
                                                                        // setState(
                                                                        //     () {
                                                                        //   details[index]
                                                                        //       .quantity++;
                                                                        // });
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.add,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                ),
                                                                // SizedBox(
                                                                //   width: deviceSize.width / 4 / 4 / 4,
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                deviceSize.width /
                                                                    4 /
                                                                    4,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          
                                                //  SizedBox(width: deviceSize.width/4/4/4,)
                                              ],
                                            ),
                                          )),
                                    ),
                                   onTap: (){
                                Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return DetailsScreen(
                            index: index,
                            title: details[index].name,
                          );
                        }));
                            },
                                  );
                                }),
                          ),
                          details.length == 0
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: deviceSize.width/4/4,right: deviceSize.width/4/4),
                                      margin: EdgeInsets.all(10),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text(
                                        'Subtotal', style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ), Text(
                                       
                                            '0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),])
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: deviceSize.width/4/4,right: deviceSize.width/4/4),
                                      margin: EdgeInsets.all(10),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text(
                                        'Shipping', style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ), Text(
                                       
                                            '0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),])
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: deviceSize.width/4/4,right: deviceSize.width/4/4),
                                      margin: EdgeInsets.all(10),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text(
                                        'Total', style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ), Text(
                                        Provider.of<Detailsprovider>(
                                                    context,
                                                    listen: false)
                                                .totalprice
                                                .toString(),
                                           
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),])
                                    ),
                                    
                                  ],
                                ),
                          details.length == 0
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.all(20),
                                  width: double.infinity,
                                  height: deviceSize.height / 4 / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.black),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Proceed To Buy',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                        ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
            return Homepage();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
