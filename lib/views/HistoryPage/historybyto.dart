import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medico_getx_app/views/HistoryPage/historyController.dart';

import '../../Utils/util.dart';
import '../../res/app_urls.dart';
import 'package:http/http.dart' as http;

import '../../res/components/customDropdown.dart';
class HistoryByTo extends StatefulWidget {
  String to;
  HistoryByTo({required this.to, Key? key}) : super(key: key);

  @override
  State<HistoryByTo> createState() => _HistoryByToState();
}

class _HistoryByToState extends State<HistoryByTo> {
  final historyController = Get.put(HistoryController());
  List<Map<String, dynamic>> selectedItems = [];
  bool selectAll = false;

  List<dynamic> filtertableDataset = [];
  void toggleSelection(Map<String, dynamic> item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add({
          'st_id': item['st_id'],
          'id': item['id'],
          'status': item['status'],
        });
      }
    });
  }
  Future<void>getfilterdata(to)async{
    var requestBody = {
      'log_id': Util.userLoggedId,
      'to':to.toString()
    };
    final response = await http.post(
      Uri.parse(AppUrls.filterData),
      headers: {
        'Content-Type': 'application/json',
        // Add any other headers you may need
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      // print("Success: ${response.body}");
      var responseData = jsonDecode(response.body);
      // print(responseData);

      if (responseData is List) {
        print('its list');
        // If the response data is a List, directly set it to tableDataset
        // setState(() {
        filtertableDataset = responseData;
        // });
      } else if (responseData is Map<String, dynamic>) {
        print('map');
        // If the response data is a Map, extract the desired data and set it to tableDataset
        // setState(() {
        filtertableDataset = [responseData];
        print('last map is : ${filtertableDataset}');
        // });
      }

      // Do something with the response data
    } else {
      print("Error: ${response.statusCode}, ${response.body}");
      // Handle the error
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print('passed value is ${widget.to}');
    // historyController.getbyto(context, widget.to);

    getfilterdata(widget.to);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final historyController = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('${widget.to.toUpperCase()}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
              future: getfilterdata(widget.to),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Some Error Occured !'));
                } else {
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('Select')),
                      DataColumn(label: Text('Stockist')),
                      DataColumn(label: Text('To')),
                      DataColumn(label: Text('Amount')),
                      DataColumn(label: Text('Bill Num')),
                      DataColumn(label: Text('Status'))
                    ],
                    rows: filtertableDataset[0]['data']
                        .where((data) =>
                    data['to'].toString() ==
                        historyController.selectedTo.toString())
                        .map<DataRow>((data) {
                      return buildDataRow(data);
                    }).toList(),
                    onSelectAll: (isSelectedAll) {

                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
  DataRow buildDataRow(Map<String, dynamic> data) {
    bool isSelected = selectedItems.contains(data) || selectAll;

    return DataRow(
      cells: [
        DataCell(
          Checkbox(
            value: isSelected,
            onChanged: (_) {
              toggleSelection(data);
            },
          ),
        ),
        DataCell(Text(data['stockist_name'].toString())),
        DataCell(Text(data['to'].toString())),
        DataCell(Text(data['amount'].toString())),
        DataCell(Text(data['bill_num'].toString())),
        DataCell(
          CustomDropdown(
            options: ['In Transit', 'Delivered'],
            hintText:
            data['status'] == null ? '-' : data['status'].toString(),
            onChanged: (value) {
              // historyController.selectedTo = value.toString().obs;
            },
          ),
        ),
      ],
    );
  }
}
