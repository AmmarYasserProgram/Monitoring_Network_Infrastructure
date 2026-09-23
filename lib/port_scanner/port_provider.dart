import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:project_futter_m_3/port_scanner/port_model.dart';
import 'package:http/http.dart' as http;
class PortProvider extends ChangeNotifier{
  bool isActive = false;
  bool is_Error = false;
  PortScanModel? _data ;


  PortScanModel? get data => _data;

  set data(PortScanModel? value) {
    _data = value;
    notifyListeners();
  }

  scan({required String host,required int sr,required int ed}) async {
    isActive = true;
    is_Error = false;
    _data = null;
    notifyListeners();
    try{
      final resonse = await http.get(Uri.parse("http://127.0.0.1:5000/port/scanner?h=$host&sr=$sr&ed=$ed"));
      if(resonse.statusCode == 200){
        final data = jsonDecode(resonse.body);
        print(data);
        this.data = PortScanModel.from_json(data);
      }
      print(data);
    }catch(e){
      print(e);
      is_Error = true;
      notifyListeners();
    }
    finally {
      isActive = false;
      notifyListeners();
    }
  }
}