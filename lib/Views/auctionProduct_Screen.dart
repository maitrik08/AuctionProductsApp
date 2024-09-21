import 'package:flutter/material.dart';
class AuctionProduct_Screen extends StatefulWidget {
  const AuctionProduct_Screen({super.key});

  @override
  State<AuctionProduct_Screen> createState() => _AuctionProduct_ScreenState();
}

class _AuctionProduct_ScreenState extends State<AuctionProduct_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Auction Products'),
       ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text('${index+1}'),
              title: Text(''),
              subtitle: Text(''),
              trailing: IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.delete)
              ),
            );
          },
      )
    );
  }
}
