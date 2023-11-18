import 'dart:convert';
import 'screem2.dart';
import 'country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Thông Tin Quốc Gia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Country> ds = [];
  bool load = true;
  Future _incrementCounter() async {
  final response = await http.get(
  Uri.parse('http://api.geonames.org/countryInfoJSON?username=duy1234'));
  if (response.statusCode == 200) {
   var userMap = jsonDecode(response.body);
      for (var itemx in userMap.values) {
        itemx.forEach((element) {
          Country ct = Country(
        continent: element['continent'].toString(),capital: element['capital'].toString(),
        languages: element[' languages'].toString(),geonameId: element['geonameId'].toString(),
        south: element['south'].toString(),isoAlpha3: element['isoAlpha3'].toString(),
            north: element['north'].toString(),fipsCode: element['fipsCode'].toString(),
            population: element['population'].toString(), east: element['east'].toString(),
            isoNumeric: element['isoNumeric'].toString(), areaInSqKm: element['areaInSqKm'].toString(),
            countryCode: element['countryCode'].toString(), west: element['west'].toString(),
          countryName: element['countryName'].toString(), postalCodeFormat: element['postalCodeFormat'].toString(),
            continentName: element['continentName'].toString(),   currencyCode: element['currencyCode'].toString(),
            flag:
              "https://img.geonames.org/flags/m/${element['countryCode'].toString().toLowerCase()}.png");
          ds.add(ct);
        });
        setState(() {
          load = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: (load)
            ? const Center(
                child: Text(
                  "Loading ......",
                ),
              )
            : Column(
                children: <Widget>[
                  // Header row
                  const Row(
                    children: <Widget>[
                      Expanded(
                        child:
                            Text(' Cờ', textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text('Diện Tích', textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child:
                            Text('Tên Quốc Gia', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  // ListView
                  Expanded(
                    child: ListView.builder(
                      itemCount: ds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SecondScreen(country: ds[index]),
                                ),
                              );
                            },
                            trailing: Text(
                              ds[index].countryName,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              ds[index].areaInSqKm,
                              textAlign: TextAlign.left,
                            ),
                            leading: Image.network(ds[index].flag,
                                width: 60, height: 50, fit: BoxFit.fill),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}
