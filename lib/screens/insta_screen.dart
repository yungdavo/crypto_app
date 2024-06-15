import 'package:flutter/material.dart';

class InstaScreen extends StatefulWidget {
  const InstaScreen({super.key});

  @override
  State<InstaScreen> createState() => _InstaScreenState();
}

class _InstaScreenState extends State<InstaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 55, left: 5, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Instagram", style: TextStyle(fontSize: 20),),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 210)),
                    Icon(Icons.favorite),
                  ],
                ),
                Icon(Icons.message_sharp)],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 50),),
                    Icon(Icons.circle_outlined, size: 80,),
                    Icon(Icons.circle_outlined, size: 80,),
                    Icon(Icons.circle_outlined, size: 80,),
                    Icon(Icons.circle_outlined, size: 80,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
