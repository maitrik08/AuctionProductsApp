import 'package:auctionapp/Controllers/database_Controller.dart';
import 'package:auctionapp/Views/auctionProduct_Screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  TextEditingController NameController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController CatagoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionProduct_Screen()));
              },
              child: Text(
                  'Auction \nProducts',
                textAlign: TextAlign.center,
              ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Database_Controller.database_controller.FetchAllProducts(),
        builder: (context, snapshot) {
          List<Map<String,dynamic>>? data = snapshot.data;
          if(snapshot.hasData){
            return ListView.builder(
                itemCount:  data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('${index+1}'),
                    title: Text(data[index]['Name']),
                    subtitle: Text('${data[index]['Price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      TextField(
                                        controller: NameController,

                                        decoration: InputDecoration(
                                          hintText: 'Enter Product Name',
                                          prefixText: data[index]['Name']
                                        ),
                                      ),
                                      TextField(
                                        controller: PriceController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Product Price',
                                        ),
                                      ),
                                      TextField(
                                        controller: CatagoryController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Product Category',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')
                                    ),
                                    TextButton(
                                        onPressed: ()async {
                                          var success = Database_Controller.database_controller.UpdateProductDetail(Name: NameController.text, Price: PriceController.text, Catagory: CatagoryController.text,Id: index+1);
                                          await (success==1)?print('added product'):print ('Product insertation failed');
                                          NameController.clear();
                                          PriceController.clear();
                                          CatagoryController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update')
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () {
                              Database_Controller.database_controller.DeleteProduct(id: index+1);
                            },
                            icon: Icon(Icons.delete)
                        ),
                      ],
                    ),
                  );
                },
            );
          }
          else if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Column(
                      children: [
                        TextField(
                          controller: NameController,
                          decoration: InputDecoration(
                            hintText: 'Enter Product Name',
                          ),
                        ),
                        TextField(
                          controller: PriceController,
                          decoration: InputDecoration(
                            hintText: 'Enter Product Price',
                          ),
                        ),
                        TextField(
                          controller: CatagoryController,
                          decoration: InputDecoration(
                            hintText: 'Enter Product Category',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')
                      ),
                      TextButton(
                          onPressed: ()async {
                            var success = Database_Controller.database_controller.AddProduct(Name: NameController.text, Price: PriceController.text, Catagory: CatagoryController.text);
                            await (success==1)?print('added product'):print ('Product insertation failed');
                            NameController.clear();
                            PriceController.clear();
                            CatagoryController.clear();
                            Navigator.pop(context);
                          },
                          child: Text('Add')
                      )
                    ],
                  );
                },
            );

          },
        child: Icon(Icons.add),
      ),
    );
  }
}
