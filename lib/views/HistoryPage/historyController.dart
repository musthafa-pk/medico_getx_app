import 'dart:convert';

import 'package:get/get.dart';
import 'package:medico_getx_app/Utils/util.dart';
import 'package:medico_getx_app/res/app_urls.dart';
import 'package:http/http.dart' as http;
class HistoryController extends GetxController{


  final RxList<String> toValues = <String>[].obs;

  final RxList<String> filterdValues = <String>[].obs;

  final RxString selectedTo = ''.obs;


  Future<void> getdata(context) async{
    print('function called');
    var apiUrl = Uri.parse(AppUrls.getDetails);
    var requestBody = {
      'st_id':Util.userLoggedId
    };
    try{
      var response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'},
          body:jsonEncode(requestBody));
      print(response.statusCode);
      if(response.statusCode == 200){
        print('passed...');
        var responsedata = jsonDecode(response.body);
        Map<String,dynamic> jsonMap =responsedata;
        print(jsonMap);
        List<dynamic> dataList = jsonMap['data'];
        print('dataList${dataList}');
        Set<String> uniqueToValues = dataList.map((e) => e['to'].toString()).toSet();
        toValues.clear();
        toValues.addAll(uniqueToValues);
        //for add all to values
        // toValues.assignAll(dataList.map((e) => e['to'].toString()));

        // dataList.forEach((item) {
        //   String toValue = item['to'].toString();
        //   toValues.add(toValue);
        // });
        print('to list is');
        print(toValues.toList());

      }else{
        print('its here');
        var responsedata = jsonDecode(response.body);
        Util.flushBarErrorMessage(responsedata['message'], context);
        // Util.toastMessage(responsedata['data']['message']);
      }
    }catch(e){
      Util.flushBarErrorMessage(e.toString(), context);
    }
  }


}