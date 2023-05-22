import 'dart:async';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxi/core/utils/magic_router.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../tracker_map/presentations/views/tracker_map.dart';
import '../../../data/models/direction_details_model.dart';
import '../../../../../global_variables.dart';
import '../../../../../core/utils/request_helper.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/models/notification_details_model.dart';
import '../../../data/models/receipt_model.dart';
import '../../views/receipt_view.dart';
import '../../views/widgets/bottom_sheets.dart';

part 'get_direction_state.dart';

class GetDirectionCubit extends Cubit<GetDirectionState> {

  
  GetDirectionCubit() : super(GetDirectionInitial());

  static GetDirectionCubit of(context) => BlocProvider.of(context);

  DirectionDetails? directionDetails;
  NotificationDetails? notificationDetails;
  ReceiptModel? receiptModel;
  DriverModel? driverModel;

  late double latx;
  late double lngx;

  TextEditingController controller = TextEditingController();
  final Completer<GoogleMapController> controllerx = Completer();
  late GoogleMapController mapController;
  bool isAvailable = false;
  final panelController = PanelController();
  // static const LatLng destination = LatLng(31.0354, 31.3939);
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey, // Your Google Map Key
     PointLatLng(currentPosition.latitude, currentPosition.longitude),
    // PointLatLng(latx,lngx
    const PointLatLng(31.026520,31.226520),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      
    }
  }

  void getCurrentPositionUpdate() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    GoogleMapController googleMapController = await controllerx.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: 18,
                  target: LatLng(currentPosition.latitude, currentPosition.longitude)))
  );}
  // void getCurrentPositionUpdate() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   currentPosition = position;
  //   GoogleMapController googleMapController = await _controller.future;
  //   LocationSettings settings = const LocationSettings(
  //       accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);
  //   homeTabPositionStream =
  //       Geolocator.getPositionStream(locationSettings: settings)
  //           .listen((Position newposition) {
  //         currentPosition = newposition;
  //         googleMapController.animateCamera(CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //                 zoom: 18,
  //                 target: LatLng(newposition.latitude, newposition.longitude))));
  //         setState(() {});
  //       });
  // }
  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,'assets/images/car_top.png',)
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, AssetsData.srcLocation,)
        .then((icon) {
      currentLocationIcon = icon;
    });
  }
  
   Future<DirectionDetails?> getDirectionDetails(
      Position startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKeyWithBilling';

    var response = await RequestHelper.getRequest(url);
    if (response == 'failed' || response['status'] != 'OK') {
      return null;
    }

     directionDetails = DirectionDetails(
        distanceText: response['routes'][0]['legs'][0]['distance']['text'],
        distanceValue: response['routes'][0]['legs'][0]['distance']['value'],
        durationText: response['routes'][0]['legs'][0]['duration']['text'],
        durationValue: response['routes'][0]['legs'][0]['duration']['value'],
        encodedPoints: response['routes'][0]['overview_polyline']['points'],
        endAddress: response['routes'][0]['legs'][0]['end_address'],
        startAddress: response['routes'][0]['legs'][0]['start_address']
     );
     log(directionDetails!.distanceValue.toString());
     log(directionDetails!.distanceText.toString());
     log(directionDetails!.durationValue.toString());
     log(directionDetails!.durationText.toString());
    return directionDetails;
  }

//////////
void getRequest()async{ listenNotification.onValue.listen((DatabaseEvent event) {
  emit(GetDirectionGetRequest());
if(event.snapshot.value == null){
 emit(GetDirectionDoneRequest());
  return ;
}else{
  final data = event.snapshot.value as Map;
      String board = data['board'].toString();
       String driver = data['driver'].toString();
       String phone = data['phone'].toString();
       String photo = data['photo'].toString();
       int rate = data['rate'];
       String type = data['type'].toString();
       String IDdriver = data['IDdriver'].toString();
       dynamic late = data['late'];
       int ride = data['ride'];
       driverId =IDdriver; 
       notificationDetails = NotificationDetails(
         board: board,
         driver: driver,
         phone: phone,
         photo: photo,
         rate: rate,
         type: type,
         IDdriver: IDdriver,
         late: late,
         ride: ride,
       );
       driverId = IDdriver ;
       driverPhone = phone;
       print('222222222222222222222222');
       print(driverId);
       print(IDdriver);
        assetsAudioPlayer.play();
      Timer(const Duration(seconds: 5), () {assetsAudioPlayer.stop(); });
        showSnackBar(LocaleKeys.driverIsAccepted.tr(),margin: EdgeInsets.only(bottom: 500.h,left: 25.w,right: 25.w));
        print('222222222222222222222222');
       //MagicRouter.navigateTo(TrackerMapView(lat: lat, lng: lng,));
       MagicRouter.navigateTo(TrackerMapView(iDdriver: IDdriver, board: board, driver: driver, phone: phone, photo: photo, rate: rate, ride: ride, type: type,));
       listenNotification.remove();
       emit(GetDirectionDoneRequest());
} 
     });
   }


//////////
  void getReceipt()async{
    // emit(GetDirectionGetRequest());
       listenReceipt.onValue.listen((DatabaseEvent event) async { 
     emit(GetDirectionLoading());
  if(event.snapshot.value == null){
   emit(GetDirectionDoneRequest());
    return ;
  }else{
 final data = event.snapshot.value as Map;
   String time = data['Time'].toString();
      int clientId = data['clientId'];
      String distance = data['distance'].toString();
      String endRide = data['endRide'].toString();
      String endTime = data['endTime'].toString();
      int id = data['id'];
      String startTime = data['startTime'].toString();
      String cost = data['cost'].toString();
      String fee = data['fee'].toString();
      String total = data['Total'].toString();
      String startRide = data['startRide'].toString();
      String late = data['late'].toString();
      receiptModel = ReceiptModel(
        Time: time,
        clientId: clientId,
        distance: distance,
        endRide: endRide,
        endTime: endTime,
        id: id,
        startTime: startTime,
        cost: cost,
        fee:fee,
        Total:total,
        startRide: startRide,
        late: late,
      );
      
     MagicRouter.navigateTo( ReceiptView(dis: distance, endAdd: endRide, endTime: endTime, fee: fee, startTime: startTime, startTAdd: startRide, time: time, cost:cost, total:data['Total'].toString(),late: late,)
     );
      emit(GetDirectionFinish());
     print(distance);
     print(cost);
    await listenReceipt.remove();
    await reference.remove();
    }}
    );
  }


   void getDriverData() {
    reference.onValue.listen((DatabaseEvent event) {
      emit(GetDriverDataLoaded());
      if (event.snapshot.value == null) {
         emit(GetDriverDataLoaded());
        //  log('driverId =');
        //  log(driverId!);
        return;
      } else {
        final Map data = event.snapshot.value as Map;
         latx = data['lat'];
         lngx = data['lng'];
        //  driverModel = DriverModel(
        // lat: lat,
        // lng: lng,
        // );
        print('33333333333333333333333333333333333');
        print(latx);
        print(lngx);
         log('driverId =');
         log(driverId!);
        print('33333333333333333333333333333333333');
        emit(GetDriverDataLoadingDone());
      }

    });
  }


/////////////
  void driverArrived()async{ listenDriverArrived.onValue.listen((DatabaseEvent event) {
      emit(GetDirectionLoading());
if(event.snapshot.value == null){
   emit(GetDirectionDoneRequest());
  return ;
}else{
  final data = event.snapshot.value as Map;
  print('arrived');
   showSnackBar(LocaleKeys.driverIsArrived.tr(),margin: EdgeInsets.only(bottom: 500.h,left: 25.w,right: 25.w));
  //  assetsAudioPlayer.open(
  //     Audio("assets/sounds/alert.mp3"),
  //     autoStart: false,
  //     showNotification: true,
  //   );
   assetsAudioPlayer.play();
   Timer(const Duration(seconds: 5), () {assetsAudioPlayer.stop(); });
   listenDriverArrived.remove();
 
 emit(GetDirectionFinish());    
} 
     });
   }

   void drivercancelled(context)async{ listenDriverCanceled.onValue.listen((DatabaseEvent event) {
      emit(GetDirectionLoading());
if(event.snapshot.value == null){
   emit(GetDirectionDoneRequest());
  return ;
}else{
  final data = event.snapshot.value as Map;
  log('Driver Cancelled Ride');
 //  showSnackBar(LocaleKeys.driverCancelledRide.tr(),margin: EdgeInsets.only(bottom: 500.h,left: 25.w,right: 25.w));
   showCancleAlertDialog(context: context);

   listenDriverCanceled.remove();
 emit(GetDirectionFinish());    
} 
     });
   }

  }






 //   showAlertDialog(context ) async {
  // return showDialog<void>(
  //   context: context,
  //   barrierDismissible: false, // user must tap button!
  //   builder: (BuildContext context) {
  //     return AlertDialog( 
  //       // <-- SEE HERE
  //       title:const  Center(child:  Text('Driver Is Arrived ',style: TextStyle(color: kDeepBlue),)),
  //       content:  SizedBox(
  //         height: 150.h,
  //         child: Column(children: [
  //           Image.asset(AssetsData.bookCar),
  //          SizedBox(height: 15.h,),
  //           SizedBox(width: 150.w,
  //             child: CustomButton(
  //               text: 'Call',
  //                textColor: kWhite,
  //                 backgroundColor: kDeepBlue,
  //                 onPressed:()=>launch('tel:${notificationDetails!.phone}'),
  //                 ))        
  //         ],),
  //       )
  //     );
  //   },
  // );
//} 

 // DatabaseReference listenReceipt = FirebaseDatabase.instance.ref();
// void getReceipt()async{
//    emit(GetDirectionGetRequest());
//     final snapShot =await  listenReceipt.child("Notifications/Rides/${CacheHelper.getData(key:'userId')}").get();
//     if(snapShot.exists){
//       emit(GetDirectionDoneRequest());
//  final data = snapShot.value as Map;
//    String time = data['Time'].toString();
//       int clientId = data['clientId'];
//       String distance = data['distance'].toString();
//       String endRide = data['endRide'].toString();
//       String endTime = data['endTime'].toString();
//       int id = data['id'];
//       String startTime = data['startTime'].toString();
//       String cost = data['cost'].toString();
//       String fee = data['fee'].toString();
//       String total = data['Total'].toString();
//       String startRide = data['startRide'].toString();
//       receiptModel = ReceiptModel(
//         Time: time,
//         clientId: clientId,
//         distance: distance,
//         endRide: endRide,
//         endTime: endTime,
//         id: id,
//         startTime: startTime,
//         cost: cost,
//         fee:fee,
//         Total:total,
//         startRide: startRide,
//       );
//      MagicRouter.navigateTo(const ReceiptView());
//      print(distance);
//      print(time);
//      print(total);
//      print(fee);
//      print(cost);
//      listenReceipt.remove();
//     }else
//     {print('error');
//     }  
//   }


//////////
   