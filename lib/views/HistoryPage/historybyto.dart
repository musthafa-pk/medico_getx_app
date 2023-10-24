import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Utils/util.dart';
import '../../res/app_urls.dart';
import '../../res/components/customDropdown.dart';
import 'HistoryController.dart';

class HistoryByTo extends StatefulWidget {
  final String to;

  const HistoryByTo({required this.to, Key? key}) : super(key: key);

  @override
  State<HistoryByTo> createState() => _HistoryByToState();
}
class _HistoryByToState extends State<HistoryByTo> {
  final historyController = Get.put(HistoryController());
  List<Map<String, dynamic>> selectedItems = [];
  bool selectAll = false;
  List<dynamic> filtertableDataset = [];

  Future<List<Map<String, dynamic>>> getFilterData(String to) async {
    try {
      var requestBody = {
        'log_id': Util.userLoggedId,
        'to': to,
      };

      final response = await http.post(
        Uri.parse(AppUrls.filterData),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData is List) {
          return List<Map<String, dynamic>>.from(responseData);
        } else if (responseData is Map<String, dynamic>) {
          return [responseData];
        }
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print('Error: $error');
    }

    // Return an empty list if there is an error or if the response doesn't match the expected types.
    return [];
  }


  @override
  void initState() {
    super.initState();
    print('passed value is ${widget.to}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('${widget.to.toUpperCase()}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
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
                        widget.to.toString())
                        .map<DataRow>((data) {
                      return buildDataRow(data);
                    }).toList(),
                    onSelectAll: (isSelectedAll) {},
                  )
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(Map<String, dynamic> data) {
    bool isSelected = selectedItems.contains(data) || selectAll;
    print(selectedItems);
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
            hintText: data['status'] == null ? '-' : data['status'].toString(),
            onChanged: (value) {
              // historyController.selectedTo = value.toString().obs;
            },
          ),
        ),
      ],
    );
  }

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
}
