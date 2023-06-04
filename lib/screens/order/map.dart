import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController? mapController;
  List<LatLng> points = [
    LatLng(10.7760, 106.6674), // Vị trí cửa hàng
    LatLng(10.7748, 106.6642), // Vị trí khách hàng
  ];
  var isLoading;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    return Scaffold(
      appBar: isLoading == true
          ? null
          : AppBar(
              backgroundColor: Color.fromARGB(255, 0, 135, 246),
              title: Text('Vị trí'),
            ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[100],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                strokeWidth: 4.0,
              ),
            )
          : Stack(
              children: [
                Positioned(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: points[
                          0], // Tọa độ trung tâm của bản đồ là điểm đầu tiên
                      zoom: 17.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      // Tạo Marker cho 2 điểm
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            width: 50,
                            height: 50,
                            point: points[1], // Điểm đầu tiên
                            builder: (ctx) => Stack(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/shipper.jpeg'),
                                    radius: 220,
                                  ),
                                ),
                              ],
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Marker(
                            width: 50,
                            height: 50,
                            point: points[0], // Điểm thứ hai
                            builder: (ctx) => Icon(
                              Icons.location_pin,
                              color: primaryColor,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                      // Tạo Polyline nối 2 điểm
                      PolylineLayerOptions(
                        polylines: [
                          Polyline(
                            points: points,
                            color: Color.fromARGB(255, 0, 135, 246),
                            strokeWidth: 7.0,
                            isDotted: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 40,
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 80,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 135, 246),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Shipper đang di chuyển đến bạn",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Thời gian dự kiến : 13 phút",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        )))
              ],
            ),
    );
  }
}
