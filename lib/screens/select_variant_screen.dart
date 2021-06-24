import 'package:flutter/material.dart';

class SelectVariantScreen extends StatefulWidget {
  const SelectVariantScreen({ Key? key }) : super(key: key);

  @override
  _SelectVariantScreenState createState() => _SelectVariantScreenState();
}

class _SelectVariantScreenState extends State<SelectVariantScreen> {
   bool choosedvalue = false;
  double _value = 0;
  List sortby = [
    {'Answer': 'Pink', 'selected': false},
    {'Answer': 'Black', 'selected': false},
    {'Answer': 'Blue', 'selected': false},
    {'Answer': 'Green', 'selected': false},
    {'Answer': 'Yellow', 'selected': false},
  ];
  List filter = [
    {'Answer': 'XL', 'selected': false},
    {'Answer': 'XXL', 'selected': false},
    {'Answer': 'L', 'selected': false},
    {'Answer': 'M', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
        final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:Text('Select Variant'),actions: [
        GestureDetector(child: Container(margin: EdgeInsets.only(top:deviceSize.height/4/4/2,right: deviceSize.width/4/4),child: Text('Apply',style: TextStyle(fontWeight: FontWeight.bold),),),onTap: (){
          Navigator.pop(context);
        },)      ],),
      body: SafeArea(child: Container(width: double.infinity,height: double.infinity,child: ListView(
        children: [
            Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Color Selection',
                  style: TextStyle(
                      color: Color(0xFF212529),
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int index1 = 0; index1 < sortby.length; index1++)
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  sortby[index1]['Answer'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                child: sortby[index1]['selected'] == true
                                    ? Container(
                                        margin: EdgeInsets.all(8),
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: sortby[index1]['selected'] == true
                                        ? Colors.green
                                        : Colors.white,
                                    border: Border.all(color: Colors.grey)),
                              )
                            ],
                          ),
                        ),
                        onTap: () => setState(() {
                          sortby[index1]['selected'] =
                              !sortby[index1]['selected'];
                          choosedvalue = !choosedvalue;
                        }),
                      )
                  ]),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Size',
                  style: TextStyle(
                      color: Color(0xFF212529),
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int index1 = 0; index1 < filter.length; index1++)
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  filter[index1]['Answer'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: filter[index1]['selected'] == true
                                        ? Colors.green
                                        : Colors.white,
                                    border: Border.all(color: Colors.grey)),
                              )
                            ],
                          ),
                        ),
                        onTap: () => setState(() {
                          filter[index1]['selected'] =
                              !filter[index1]['selected'];
                          choosedvalue = !choosedvalue;
                        }),
                      )
                  ]),

        ],
      ),)),
    );
  }
}