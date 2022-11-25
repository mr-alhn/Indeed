import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:indeed_jobs/const.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('usr');
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: ((context) => DataProvider()))],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final tinyDB = Hive.box('usr');
  @override
  void initState() {
    getpermission();
    super.initState();
  }

  getpermission() async {
    if (tinyDB.get('Country') != null) {
      Provider.of<DataProvider>(context, listen: false)
          .getcountryinfo(tinyDB.get('Country'));
    } else {
      Provider.of<DataProvider>(context, listen: false).getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    var error = Provider.of<DataProvider>(context).error;
    return Scaffold(
      body: Center(
        child: error == ''
            ? const CircularProgressIndicator()
            : error != 'no'
                ? Text(
                    error,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                : const InfoLayout(),
      ),
    );
  }
}

class InfoLayout extends StatefulWidget {
  const InfoLayout({super.key});

  @override
  State<InfoLayout> createState() => _InfoLayoutState();
}

class _InfoLayoutState extends State<InfoLayout> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context).countrydata;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Deatils',
            style: GoogleFonts.quicksand(),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'countryCode : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data!['geonames']['country']['countryCode'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'countryName : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['countryName'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'isoNumeric : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['isoNumeric'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'isoAlpha3 : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['isoAlpha3'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'fipsCode : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['fipsCode'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'continent : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['continent'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'continentName : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['continentName'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'capital : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['capital'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'areaInSqKm : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['areaInSqKm'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'population : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['population'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'currencyCode : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['currencyCode'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'languages : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    data['geonames']['country']['languages'],
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    maxLines: 50,
                  ),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'geonameId : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['geonameId'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'west : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['west'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'north : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['north'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'east : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['east'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'south : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['south'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                    )
                  ]),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'postalCodeFormat : ',
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  data['geonames']['country']['postalCodeFormat'],
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
            ),
          ],
        ));
  }
}
