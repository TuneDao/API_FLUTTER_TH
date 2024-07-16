import 'dart:io';

import 'package:app_api/app/model/bill.dart';
import 'package:flutter/material.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: bill.length,
        itemBuilder: (context, index) {
          var data = bill[index];
          return Column(
            children: [
              Text('Tên phim: ' + data.productName),
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(data.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Image(
                    width: 128,
                    height: 128,
                    fit: BoxFit.cover,
                    image: FileImage(File(data.imageUrl))),
              ),
              // Text(data.imageUrl),
              Text('Giá tiền:' + data.price.toString()),
              Text('Tổng tiền' + data.total.toString()),
            ],
          );
        },
      ),
    );
  }
}
