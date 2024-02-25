import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'crop_info_screen.dart';
import 'market_price_screen.dart';
import 'SoilTesting.dart';
import 'disease_detection.dart';
import 'Quality_Grade.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDyd0fitkKLL5JXi7JXaCyndoV2TxTBtK0',
        appId: '1:753708203802:android:5e6d10ff18283e5c28b6a3',
        messagingSenderId: '753708203802',
        projectId: 'farmers-476a9'
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CropInfoScreen(),
    DiseaseDetectionPage(),
    SoilTestingScreen(),
    MarketPriceScreen(),
    QualityGradeAnalysisPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: Image.asset('assets/images/logo.jpg'),
        leadingWidth: 50,
        title: const Text(
          'Farmers Guide',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Crop Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Disease Detection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Soil Testing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Market Price',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            label: 'Quality Grade',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          'assets/images/home_image.jpeg',
          fit: BoxFit.cover,
        ),

      ],
    );
  }
}



