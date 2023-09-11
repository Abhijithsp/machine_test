import 'package:demo/screens/random_details_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/RandomNameModel.dart';
import '../network/network_service.dart';
import '../utils/services/sharedPrefrence.dart';

class RandomNameScreen extends StatefulWidget {

  @override
  _RandomNameScreenState createState() => _RandomNameScreenState();

}

class _RandomNameScreenState extends State<RandomNameScreen> {

  late Future<RandomNameModel> getNames;
  String randomUsername="";


  @override
  void initState() {
    super.initState();
    getNames = NetworkService().fetchName();
    Future user = SharedPrefrence().getName();
    user.then((data) async {

       setState(() {
         randomUsername = data;
       });
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Random Names'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: randomUsername==""?FutureBuilder<RandomNameModel>(
                future: getNames,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data!.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                    return CircularProgressIndicator();
                },
              ):Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(randomUsername,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ),
            ),

            Expanded(flex: 0,child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    SharedPrefrence().ClearName('randomUsername');
                    setState(() {
                      randomUsername="";
                    });
                    getNames = NetworkService().fetchName();
                    NetworkService().fetchRandomColor();
                  },
                  child: const Text('Fetch Name',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),   ),

            Expanded(flex: 0,child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {

                    NetworkService().fetchRandomColor();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RandomDetailsScreen()),
                    );
                  },
                  child: const Text('Next',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),   ),
          ],
        ),
      ),
    );
  }
}
