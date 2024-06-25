import 'dart:convert';
import 'package:crypto_app/App_Theme/app_theme.dart';
import 'package:crypto_app/model/coin_details.dart';
import 'package:crypto_app/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //this is show the user details from profile on our drawer
  String username = "", email = "", age = "";

  bool isDarkMode = AppTheme.isDarkModeEnabled;

  final GlobalKey <ScaffoldState> _globalKey = GlobalKey <ScaffoldState>();

  String url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur';
  final String apiKey = 'CG-MmgBpYFtyosYswUtLquVUyP9';

  List<CoinDetailsModel> coinDetailsList = [];

  late Future<List<CoinDetailsModel>>coinDetailsFuture;

  @override
  void initState() {
    //this loads as soon as the screen is built
    super.initState();
    getUserDetails();
    coinDetailsFuture = getCoinsDetails();
  }

  void getUserDetails() async { //to access the storage/to get the details
    SharedPreferences prefs = await
    SharedPreferences.getInstance();
  setState(() { // the setState lets us see the details in real time
    username = prefs.getString('username') ?? "";
    email = prefs.getString('email') ?? "";
    //age = prefs.getString('age') ?? "";
    });
  }

  Future<List<CoinDetailsModel>> getCoinsDetails()async{
    //this helps us load our API from the server
    Uri  uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'accept': 'application/json',
      'x-cg-demo-api-key': apiKey
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      List coinsData = json.decode (response.body);
      List<CoinDetailsModel> data = coinsData.map((e) =>
          CoinDetailsModel.fromJson(e)).toList();
      return data;
    }else{
      print("failed to load data: ${response.body}");
      return <CoinDetailsModel>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      key: _globalKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            _globalKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.black,),
        ),
        title: const Text(
          "Black Point Trade",
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text(username,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    accountEmail: Text("$email ", //n/Age: $age
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  currentAccountPicture: const Icon(
                    Icons.account_circle_rounded,
                    size: 70, color: Colors.grey,
                  ),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>
                        UpdateProfileScreen(),
                        ),
                    );
                  },
                  leading: Icon(
                      Icons.account_circle_rounded,
                      color: isDarkMode ? Colors.white : Colors.black
                  ),
                  title: Text(
                      "Update Profile",
                    style: TextStyle( color: isDarkMode ? Colors.white : Colors.black),
                  ),
                ), //update profile button n icon
                ListTile(
                  onTap: () async {
                    SharedPreferences prefs = await
                    SharedPreferences.getInstance();

                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                    await prefs.setBool('isDarkMode', isDarkMode);
                    AppTheme.isDarkModeEnabled = isDarkMode;
                  },
                  leading: Icon(
                      isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode,
                      color: isDarkMode ? Colors.white : Colors.black
                  ),
                  title: Text(
                    isDarkMode ? "Light Mode" :"Dark Mode",
                    style: TextStyle(
                      fontSize: 17,
                      color: isDarkMode ? Colors.white : Colors.black
                    ),
                  ),
                ), //DarkMode button n icon
                Spacer(),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Developed by ',
                      style: TextStyle(
                        fontSize: 18.0,
                          color: isDarkMode ? Colors.white : Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'TEKHED',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]
                    ),
                  ),
                )
              ],
            ),
      ),
      body: FutureBuilder(
          future: coinDetailsFuture,
          builder: (context, AsyncSnapshot<List<CoinDetailsModel>> snapshot){
        if (snapshot.hasData) {
          if (coinDetailsList.isEmpty){
            coinDetailsList = snapshot.data!;
          }
         return Column(
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(
                 vertical: 10,
                 horizontal:20,
               ),
               child: TextField(
                 onChanged: (query){
                   List<CoinDetailsModel> searchResult =
                   snapshot.data!.where((element){
                     String coinName = element.name;
                     bool isItemFound = coinName.contains(query);
                     return isItemFound;
                   }).toList();

                   setState(() {
                     coinDetailsList = searchResult;
                   });
                 },
                  decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search_outlined),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(40),
                   ),
                   hintText: "Search for a coin",
                 ),
               ),
             ),
             Expanded(
                 child: ListView.builder(
               itemCount: coinDetailsList.length,
               itemBuilder: (context, index){
                 return coinDetails(coinDetailsList[index]);
               },
              ),
             ),
           ],
         );
        }else{
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          );
        }
      }),
    );
  }
  Widget coinDetails  (CoinDetailsModel model){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: SizedBox(
          height: 50,
            width: 50,
            child: Image.network(model.image)),
        title: Text("${model.name}\n${model.symbol}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: RichText(
          textAlign: TextAlign.end,
            text: TextSpan(
              text: "€ ${model.currentPrice}\n",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "${model.priceChangePercentage24h}%",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500, color: Colors.red,
                  )
                ),
              ]
            ),
        ),
      ),
    );
  }
}
