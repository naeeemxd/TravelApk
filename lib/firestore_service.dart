import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch Best Destinations
  Future<List<Map<String, dynamic>>> fetchBestDestinations() async {
    var querySnapshot = await _db.collection('destinations').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Fetch Special Trip Offers
  Future<List<Map<String, dynamic>>> fetchSpecialTripOffers() async {
    var querySnapshot = await _db.collection('special_trip_offers').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Fetch Popular Trip Packages
  Future<List<Map<String, dynamic>>> fetchPopularTripPackages() async {
    var querySnapshot = await _db.collection('popular_trip_packages').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
