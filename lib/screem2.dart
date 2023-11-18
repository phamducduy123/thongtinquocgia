import 'package:flutter/material.dart';
import 'country.dart';
class SecondScreen extends StatelessWidget {
  final Country country;

  // In the constructor, require a Country object
  SecondScreen({required this.country});  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông Tin Chi Tiết"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // xuat ra thông tin chi tiết quốc gia đó
        children: [
          Text(
            "Mã Quốc Gia:${country.countryCode}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Tên Quốc Gia :${country.countryName}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Thủ Đô :${country.capital}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Dân Số :${country.population} Người",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Diện Tích:${country.areaInSqKm} KM2",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Đơn Vị tiền tệ:${country.currencyCode}\n\n",
            style: TextStyle(fontSize: 20),
          ),
          Image.network(
              "https://img.geonames.org/img/country/250/${country.countryCode}.png") //image hình ảnh với contrycode viết hoa 
        ],
      ),
    );
  }
}
