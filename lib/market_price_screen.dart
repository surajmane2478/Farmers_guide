// market_price_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MarketPriceScreen extends StatefulWidget {
  const MarketPriceScreen({super.key});

  @override
  _MarketPriceScreenState createState() => _MarketPriceScreenState();
}

class _MarketPriceScreenState extends State<MarketPriceScreen> {
// Set the correct index for Market Price in the bottom navigation
  final auth =FirebaseAuth.instance;
  final ref= FirebaseDatabase.instance.ref("market_price");

  String _selectedState = 'Maharashtra';
  String _selectedCrop = 'Maize';

  List<String> states = [
    "Andhra Pradesh",
    "Maharashtra",
    "Uttar Pradesh",
    "Bihar",
    "Goa",
    "Chhattisgarh",
    "Karnataka",
    "Punjab",
    "Mizoram",
    "West Bengal",
    "Tripura",
    "Assam",
    "Arunachal Pradesh",
    "Manipur",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Kerala",
    "Jharkhand",
    "Rajasthan",
    "Odisha",
    "Madhya Pradesh",
    "Nagaland",
    "Tamil Nadu" ,
    "Delhi" ,
    "Telangana" ,
    "Meghalaya" ,
    "Sikkim" ,
    "Uttarakhand" ,
    "Jammu and Kashmir"
  ];



  List<String> crops = [
    'Maize',
    'Termaric',
    'Wheat',
    'Rice',
    'Sugarcane',
    'Tomato',
    'Potato',
    'Groundnut',
    'Jwari',
    'Moong',
  ];
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Price'),
        centerTitle: true
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropdownButtonFormField<String>(
            //   value: _selectedState,
            //   onChanged: (newValue) {
            //     setState(() {
            //       _selectedState = newValue!;
            //     });
            //   },
            //   items: states.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   decoration: const InputDecoration(
            //     labelText: 'Select State',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 16),
            // DropdownButtonFormField<String>(
            //   value: _selectedCrop,
            //   onChanged: (newValue) {
            //     setState(() {
            //       _selectedCrop = newValue!;
            //     });
            //   },
            //   items: crops.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   decoration: const InputDecoration(
            //     labelText: 'Select Crop',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add your search logic here
            //     if (kDebugMode) {
            //       print('Selected State: $_selectedState');
            //     }
            //     print('Selected Crop: $_selectedCrop');
            //     // You can implement the search functionality or navigate to another page
            //   },
            //   child: const Text('Search'),
            // ),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: ' search by crop name or state',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  String state = snapshot.child("state").value.toString().toLowerCase();
                  String crop = snapshot.child('crop').value.toString().toLowerCase();

                  if (_searchQuery.isNotEmpty &&
                      !crop.contains(_searchQuery) &&
                      !state.contains(_searchQuery)) {
                    return SizedBox(); // Return an empty SizedBox if the item doesn't match the search query
                  }

                  return Card(elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                            // spreadRadius: 5,
                            blurRadius: 7,
                            // offset: const Offset(0, 3), // Customize the shadow offset
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.child("image_url").value.toString(),
                              fit: BoxFit.cover,
                              width: 80.0,
                              height: 80.0,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(child: CircularProgressIndicator(color: Colors.blueAccent));
                                }
                              },
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return Center(child: Icon(Icons.broken_image, size: 80.0));
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Crop Name: ${snapshot.child("crop").value.toString()}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                               Text(
                                  'Rate: ${snapshot.child('price').value.toString()} Rupee/Kg',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'State: ${snapshot.child('state').value.toString()}',
                                  style: const TextStyle(

                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          // Quantity and Buttons

                        ],
                      ),
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }



}
