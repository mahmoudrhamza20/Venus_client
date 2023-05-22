import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/translations/locale_keys.g.dart';
import 'core/utils/cache_helper.dart';
import 'features/home/data/models/direction_details_model.dart';
import 'features/home/presentations/views_models/post_details_cubit/post_details_cubit.dart';

               
String mapKey = 'AIzaSyBaj8TdogqYDV8xOtl2HyJT7HO8m1IkcIE';
String mapKeyWithBilling = 'AIzaSyBaj8TdogqYDV8xOtl2HyJT7HO8m1IkcIE';
final globalScaffoldKey = GlobalKey<ScaffoldMessengerState>();
const CameraPosition googlePlex = CameraPosition(
  target: LatLng(31.0274113, 31.3732026),
  zoom: 14.4746,
);


////////////////////////////////////////////////////////////////////////////
String  currentLocation = LocaleKeys.yourLocation.tr() ;
late Position currentPosition;
late GoogleMapController mapController;
late LatLng destinationPosition;
 Position driverLocation = currentPosition;
late DirectionDetails directionDetailsGlobal;
TextEditingController currentLocationController = TextEditingController();
TextEditingController destinationController = TextEditingController();
////////////////////////////////////////////////////////////////////////////

late StreamSubscription<Position> homeTabPositionStream;
late StreamSubscription<Position> ridePositionStream;
//final assetsAudioPlayer = AssetsAudioPlayer();
// late DatabaseReference tripRequestRef;
int? rideIdCancel ;
  DatabaseReference listenReceipt = FirebaseDatabase.instance.ref("Receipt/${CacheHelper.getData(key:'userId')}");
  DatabaseReference listenNotification = FirebaseDatabase.instance.ref("AcceptRide/${CacheHelper.getData(key:'userId')}");
  DatabaseReference listenDriverArrived = FirebaseDatabase.instance.ref("Arrived/${CacheHelper.getData(key:'userId')}");
  DatabaseReference listenDriverCanceled= FirebaseDatabase.instance.ref("cancleRides/${CacheHelper.getData(key:'userId')}");
  DatabaseReference reference = FirebaseDatabase.instanceFor( app: Firebase.app('VenusDriver'),
  databaseURL: 'https://venus-captin-default-rtdb.firebaseio.com/',).ref().child('Drivers/$driverId/location');
  
FirebaseAuth auth = FirebaseAuth.instance;
final assetsAudioPlayer = AssetsAudioPlayer();
  String? driverId ;
  String? driverPhone;
 late  double lat;
 late double lng;
DatabaseReference refClientInfo = FirebaseDatabase.instance.ref("Client/${CacheHelper.getData(key:'userId')}");
Country selectedCountry = Country(
    phoneCode: '962',
    countryCode: 'JO',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Jordan',
    example: 'Jordan',
    displayName: 'Jordan',
    displayNameNoCountryCode: 'JO',
    e164Key: '');
