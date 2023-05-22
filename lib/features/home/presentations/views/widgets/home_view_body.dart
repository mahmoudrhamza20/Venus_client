import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/direction_details_model.dart';
import '../../../../../global_variables.dart';
import '../../../../../translations/locale_keys.g.dart';
import 'bottom_sheets.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final Completer<GoogleMapController> _controller = Completer();

  //late GoogleMapController mapController;
  String mapTheme = '';
  String availabilityTitle = 'Go Online';
  Color availabilityColor = Colors.deepOrange;
  bool isAvailable = false;
  String location = "Search Location";
  late DirectionDetails directionDetails;

  // final Set<Marker> _marker = {
  //   Marker(
  //     markerId: const MarkerId("2"),
  //     position: LatLng(destination.latitude, destination.longitude),
  //   ),
  //   Marker(
  //     markerId: MarkerId("2"),
  //     position: LatLng(31.1035893, 31.4266869),
  //   ),
  //   const Marker(
  //     markerId: MarkerId("2"),
  //     position: LatLng(31.0554, 31.3939),
  //   ),
  // };
  Set<Marker> markersList = {};
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController googleMapController;
  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey, // Your Google Map Key
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(destinationPosition.latitude, destinationPosition.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, AssetsData.srcLocation,)
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  void getCurrentPositionUpdate() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: 18,
                  target: LatLng(currentPosition.latitude, currentPosition.longitude)))
  );}

  @override
  void initState() {
    super.initState();
   // GetDirectionCubit.of(context).getRequest();
   // GetDirectionCubit.of(context).getReceipt();
    setCustomMarker();
    getCurrentPositionUpdate();
    DefaultAssetBundle.of(context)
        .loadString('assets/map/map_theme.json')
        .then((value) => {mapTheme = value});
  }

  @override
  Widget build(BuildContext context) {
    final cubit = GetDirectionCubit.of(context);
    return Stack(alignment: Alignment.topRight, children: [
      GoogleMap(
        padding: const EdgeInsets.only(top: 135),
        initialCameraPosition: googlePlex,
        //myLocationEnabled: true,
        polylines:
        {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: kDeepBlue,
            width: 5,
          ),
        },
        markers: markersList,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
          mapController = controller;
          getCurrentPositionUpdate();
        },
      ),
      Padding(
        padding: EdgeInsets.only(top: 40.h, right: 13.w),
        child: Builder(builder: (context) {
          return customIconBack(
          onTap: () =>
           Scaffold.of(context).openDrawer(),
         //showCancleAlertDialog(context: context),
        
icon: Icons.menu);
        }),
      ),
      BlocListener<GetDirectionCubit, GetDirectionState>(
        listener: (context, state) {
        },
        child: Positioned(
          top: 60.h,
          right: 5.w,
          left: 5.w,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () async {
                var place = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: mapKey,
                    mode: Mode.overlay,
                    types: [],
                    strictbounds: false,
                    components: [Component(Component.country, 'eg')],
                    //google_map_webservice package
                    onError: (err) {
                      debugPrint(err.toString());
                    });

                if (place != null) {
                  setState(() {
                    location = place.description.toString();
                  });
                  //form google_maps_webservice package
                  final plist = GoogleMapsPlaces(
                    apiKey: mapKey,
                    apiHeaders: await const GoogleApiHeaders().getHeaders(),
                    //from google_api_headers package
                  );
                  String placeId = place.placeId ?? "0";
                  final detail = await plist.getDetailsByPlaceId(placeId);
                  final geometry = detail.result.geometry!;
                  final lat = geometry.location.lat;
                  final lang = geometry.location.lng;
                   destinationPosition = LatLng(lat, lang);
                  debugPrint('------------------------------');
                  debugPrint(destinationPosition.latitude.toString());
                  debugPrint(destinationPosition.longitude.toString());
                  print(CacheHelper.getData(key:'userId'));
                  debugPrint('------------------------------');
                  markersList.add(Marker(
                      markerId: const MarkerId("destinationPosition"),
                      position: LatLng(lat, lang),
                      infoWindow: InfoWindow(title: detail.result.name)));
                  markersList.add(Marker(
                    icon: sourceIcon,
                      markerId: const MarkerId("currentPosition"),
                      position: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      infoWindow: const InfoWindow(title: 'Current Position'))
                  );
                  setCustomMarker();
                   getPolyPoints();
                  destinationController.text = detail.result.name;
                  currentLocationController.text = currentLocation;
                  cubit.getDirectionDetails(currentPosition, destinationPosition);
                  setState(() {});
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: destinationPosition, zoom: 17)));
                }
              },
              child: Card(
                child: Container(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(
                        location,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      trailing: const Icon(Icons.search),
                      dense: true,
                    )),
              ),
            ),
          ),
        ),
      ),

      Positioned(
          bottom: 50.h,
          right: 100.w,
          left: 100.w,
          child: SizedBox(
              width: 200.w,
              child: CustomButton(
                text: LocaleKeys.bookRide.tr(),
                textColor: kWhite,
                backgroundColor: kDeepBlue,
                onPressed: () async{
                  var connectivityResult = await (Connectivity().checkConnectivity());
                  if (connectivityResult != ConnectivityResult.mobile &&
                      connectivityResult != ConnectivityResult.wifi) {
                    showSnackBar(
                      LocaleKeys.noInternetConnectivity.tr(),
                    );
                  }
                  try {
  if(destinationPosition != null ){
  
     buildSearchModalBottomSheet(context);
  }
}  catch (e) {
 CacheHelper.getData(key: 'lang') =='en'? showSnackBar('Choose your address'):showSnackBar('يجب ان تختار وجهتك');
}
                
                }
              ))),
    ]);
  }

 
}
