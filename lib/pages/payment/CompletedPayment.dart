import 'package:flutter/material.dart';



class Home extends StatelessWidget {
  //const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text('Payment Completed'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Text('Payment Successful'),
    );
  }
}
