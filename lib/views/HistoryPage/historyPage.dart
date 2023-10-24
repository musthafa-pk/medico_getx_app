import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'HistoryController.dart';
import 'historybyto.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final historyController = Get.put(HistoryController());

  @override
  void initState() {
    // TODO: implement initState
    historyController.getdata(context);
    print('sssssssssss');
    print(historyController.filterdValues);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('History'),
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: historyController.toValues.length,
                    itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                        child: InkWell(
                          onTap: (){
                            // historyController.getbyto(context, historyController.toValues[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryByTo(to: historyController.toValues[index]),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                              title: Text('${historyController.toValues[index].toUpperCase()}',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
