import 'package:demo/screens/random_name_screen.dart';
import 'package:flutter/material.dart';

import '../models/RandomColorModel.dart';
import '../models/RandomUserModel.dart';
import '../network/network_service.dart';
import '../utils/extension/hex_extension.dart';
import '../utils/services/sharedPrefrence.dart';

class RandomDetailsScreen extends StatefulWidget {
  const RandomDetailsScreen({super.key});

  @override
  State<RandomDetailsScreen> createState() => _RandomDetailsScreenState();
}

class _RandomDetailsScreenState extends State<RandomDetailsScreen> {
  Color? colorHexCode;
  late Future<RandomUserModel> getUser;

  @override
  void initState() {
    super.initState();
    NetworkService().fetchRandomColor();
    getUser = NetworkService().fetchUser();
    Future hexCode = SharedPrefrence().getColor();
    hexCode.then((data) async {
      setState(() {
        colorHexCode = HexColor.fromHex(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorHexCode,
        appBar: AppBar(
          title: const Text("Random User Details"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 0,
                child: FutureBuilder<RandomUserModel>(
                  future: getUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${snapshot.data!.first_name + ' ' + snapshot.data!.last_name}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RandomNameScreen()),
                      );
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),)
            ],
          ),
        ));
  }
}
