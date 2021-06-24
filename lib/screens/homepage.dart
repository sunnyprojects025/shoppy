import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/model/products.dart';
import 'package:shoppy/provider/detailsProvider.dart';
import 'package:shoppy/screens/details_screen.dart';
import 'package:shoppy/screens/product_view_screen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _isLoading = true;
  List<Products> details = [];
  getdetails() async {
    await Provider.of<Detailsprovider>(context, listen: false).getshopdetail();
    details = Provider.of<Detailsprovider>(context, listen: false).details;
    setState(() {
      _isLoading = false;
    });
  }

  refreshdata() async {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Detailsprovider>(context, listen: false).cartupdate.length == 0
        ? await getdetails()
        : null;
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
        appBar: AppBar(
          title: Text('Shoppy'),
          actions: [
            Container(
                margin: EdgeInsets.only(top: deviceSize.height / 4 / 4 / 4),
                child: Text("Total Units: " +
                    '${Provider.of<Detailsprovider>(context, listen: false).cartupdate.length.toString()}\n'
                        "Total Price: "
                        '${Provider.of<Detailsprovider>(context, listen: false).totalprice.toString()}')),
            Container(
              margin: EdgeInsets.only(
                  right: deviceSize.width / 4 / 4,
                  top: deviceSize.height / 4 / 4 / 4),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      padding: EdgeInsets.all(3),
                      alignment: Alignment.center,
                      child: Text(
                        Provider.of<Detailsprovider>(context, listen: false)
                                    .cartupdate
                                    .length ==
                                0
                            ? ''
                            : Provider.of<Detailsprovider>(context,
                                    listen: false)
                                .cartupdate
                                .length
                                .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return ProductViewScreen();
                        })).then((value) {
                          setState(() {
                            refreshdata();
                          });
                        });
                      },
                      icon: Icon(Icons.shopping_cart))
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : details.length == 0
                    ? Center(
                        child: Text('No Data Found'),
                      )
                    : ListView.builder(
                        itemCount: details.length,
                        itemBuilder: (ctx, index) {
                          print(details);
                          return GestureDetector(
                            child: Card(
                              elevation: .2,
                              color: Color(0xFFF8F8F8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(
                                  left: deviceSize.width / 4 / 4,
                                  right: deviceSize.width / 4 / 4,
                                  top: deviceSize.height / 4 / 4 / 4,
                                  bottom: deviceSize.height / 4 / 4 / 4),
                              child: Container(
                                  width: double.infinity,
                                  height: deviceSize.height / 4 * .8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: deviceSize.width / 4 / 4 / 2,
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
                                              Text(details[index].name.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              SizedBox(
                                                height:
                                                    deviceSize.height / 4 / 4 / 4,
                                              ),
                                              Text(
                                                details[index].unitpr.toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height:
                                                    deviceSize.height / 4 / 4 / 4,
                                              ),
                                              Text(
                                                details[index]
                                                    .specialpr
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        // padding: EdgeInsets.only(bottom: deviceSize.height/4/4/3),
                                        height: deviceSize.height / 4 / 4,
                                        margin: EdgeInsets.only(
                                            top: deviceSize.height / 4 / 3),
                          
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                       // alignment: Alignment.center,
                                        child: Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom:
                                                      deviceSize.height ),
                                              child: IconButton(
                                                  onPressed: () async {
                                                    details[index].quantity != 0
                                                        ? await Provider.of<
                                                                    Detailsprovider>(
                                                                context,
                                                                listen: false)
                                                            .minusproductTocart(
                                                                details[index].id,
                                                                details[index]
                                                                    .unitpr)
                                                        : null;
                                                    setState(() {
                                                      details[index].quantity != 0
                                                          ? details[index]
                                                              .quantity--
                                                          : null;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.minimize,
                                                    color: Colors.orange[400],
                                                  )),
                                            ),
                          
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: deviceSize.height /
                                                      4 /
                                                      4 /
                                                      4 /
                                                      2),
                                              padding: EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              child: Text(
                                                details[index]
                                                    .quantity
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                          
                                            IconButton(
                                                onPressed: () async {
                                                  await Provider.of<
                                                              Detailsprovider>(
                                                          context,
                                                          listen: false)
                                                      .addProductToCart(
                                                          details[index].id,
                                                          details[index].name,
                                                          details[index].unitpr,
                                                          details[index]
                                                              .specialpr,
                                                          details[index].quantity,
                                                          details[index].variant);
                                                  setState(() {
                                                    details[index].quantity++;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.orange[400],
                                                )),
                                            // SizedBox(
                                            //   width: deviceSize.width / 4 / 4 / 4,
                                            // )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: deviceSize.width / 4 / 4 / 4 / 3,
                                      )
                                    ],
                                  )),
                            ),
                            onTap: (){
                                Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return DetailsScreen(
                            index: index,
                            title: details[index].name,
                          );
                        })).then((value) {
                          setState(() {
                            refreshdata();
                          });
                        });
                            },
                          );
                        }),
          ),
        ));
  }
}
