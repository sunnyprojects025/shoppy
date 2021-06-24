import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/model/products.dart';
import 'package:shoppy/provider/detailsProvider.dart';
import 'package:shoppy/screens/product_view_screen.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic title, index;

  DetailsScreen({this.title, this.index});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
        title: Text('Product'),
        centerTitle: true,
        actions: [
          // Container(
          //     margin: EdgeInsets.only(top: deviceSize.height / 4 / 4 / 4),
          //     child: Text("Total Units: " +
          //         '${Provider.of<Detailsprovider>(context, listen: false).cartupdate.length.toString()}\n'
          //             "Total Price: "
          //             '${Provider.of<Detailsprovider>(context, listen: false).totalprice.toString()}')),
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
                          : Provider.of<Detailsprovider>(context, listen: false)
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
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
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
          child: _isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceSize.width / 4 / 4,
                          right: deviceSize.width / 4 / 4),
                      width: double.infinity,
                      height: deviceSize.height / 2,
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/default.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: deviceSize.width,
                      alignment: Alignment.center,
                      height: deviceSize.height / 4 / 2,
                      //color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Container(
                            // padding: EdgeInsets.only(bottom: deviceSize.height/4/4/3),
                            height: deviceSize.height / 4 / 4 * .9,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            // alignment: Alignment.center,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: deviceSize.height),
                                  child: IconButton(
                                      onPressed: () async {
                                        details[widget.index].quantity != 0
                                            ? await Provider.of<
                                                        Detailsprovider>(
                                                    context,
                                                    listen: false)
                                                .minusproductTocart(
                                                    details[widget.index].id,
                                                    details[widget.index]
                                                        .unitpr)
                                            : null;
                                        setState(() {
                                          details[widget.index].quantity != 0
                                              ? details[widget.index].quantity--
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
                                      top: deviceSize.height / 4 / 4 / 4 / 2),
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    details[widget.index].quantity.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),

                                IconButton(
                                    onPressed: () async {
                                      await Provider.of<Detailsprovider>(
                                              context,
                                              listen: false)
                                          .addProductToCart(
                                              details[widget.index].id,
                                              details[widget.index].name,
                                              details[widget.index].unitpr,
                                              details[widget.index].specialpr,
                                              details[widget.index].quantity,
                                              details[widget.index].variant);
                                      setState(() {
                                        details[widget.index].quantity++;
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: deviceSize.width/4/4,top: deviceSize.height/4/4/4),
                      child: Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: deviceSize.height / 4 / 2,
                      width: double.infinity,
                      padding: EdgeInsets.all(deviceSize.width/4/4/2),
                      child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu elit vel arcu vulputate congue. Sed auctor blandit turpis at convallis. Aliquam rutrum enim at nulla sollicitudin, nec pharetra lectus gravida. Mauris fringilla nibh hendrerit volutpat condimentum. Donec porta sit amet ante eu mollis. Integer maximus blandit sem vitae pellentesque. Sed semper tortor tellus, convallis pretium risus accumsan a. Aliquam efficitur nisi aliquet, pulvinar neque at, interdum neque.',overflow: TextOverflow.fade,),
                    ),
                    Container(
                      width: double.infinity,
                      height: deviceSize.height/4/3,
                      margin: EdgeInsets.only(left: deviceSize.width/4/4,right: deviceSize.width/4/4,top: deviceSize.height/4/4/4,bottom: deviceSize.height/4/4/4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF2D87E6)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Row(children: [
                          Icon(Icons.lock,color: Colors.white,),
                          SizedBox(width: deviceSize.width/4/4,),
                           Text('Add To Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                        ],),
                        Text('${Provider.of<Detailsprovider>(context, listen: false).totalprice.toString()}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                       
                      ],),
                    ),
                  //  SizedBox(height: deviceSize.height,)
                  ],
                )),
    );
  }
}
