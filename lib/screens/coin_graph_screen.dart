import 'package:flutter/material.dart';

class CoinGraphScreen extends StatefulWidget {
  final String coinId, coinName;
  const CoinGraphScreen({super.key,
    required this.coinId,
    required this.coinName});

  @override
  State<CoinGraphScreen> createState() => _CoinGraphScreenState();
}

class _CoinGraphScreenState extends State<CoinGraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){},
                icon: Icon(
                    Icons.arrow_back_ios_new,
                color: Colors.black,
                ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              widget.coinName,
              style: TextStyle(
                  color: Colors.black,
              fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                      text: "${widget.coinName} Price\n",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: "Rs. 1928937.98\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "2.3984957\n",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: "Rs.293894776.23",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
