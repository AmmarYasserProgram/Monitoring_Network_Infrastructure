import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project_futter_m_3/device_scanner/device_model.dart';

class DeviceProvider extends ChangeNotifier{

  bool isActive = false;
  DeviceModel? _data ;

  DeviceModel? get data => _data;

  set data(DeviceModel? value) {
    _data = value;
    notifyListeners();
  }

  Future scan(String host) async {
    isActive = true;
    _data = null;
    notifyListeners();

    try{
      final resonse = await http.get(
          Uri.parse(
              "http://127.0.0.1:5000/device/scanner?host=$host",
          )
      );
      if(resonse.statusCode == 200){
        final data = jsonDecode(resonse.body);
        print(data);
        this.data = DeviceModel.from_json(data);
      }
      print(data);
    }catch(e){
      print(e);
    }
    finally {
      isActive = false;
      notifyListeners();
    }
  }
}