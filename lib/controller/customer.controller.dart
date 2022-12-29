import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:yummy_swipe_admin/models/customer/app_user.dart';

class CustomerController extends GetxController {
  CustomerDataGridSource dataSource = CustomerDataGridSource(customers: []);
  bool isDataFecthed = false;
  @override
  void onInit() {
    super.onInit();
    updateDataSource();
  }

  updateDataSource() async {
    final value = await customerRef.get();
    final customers = value.docs.map((e) => e.data).toList();
    dataSource = CustomerDataGridSource(customers: customers);
    isDataFecthed = true;
    update();
  }
}

class CustomerDataGridSource extends DataGridSource {
  CustomerDataGridSource({required List<AppUser> customers}) {
    _customers = customers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phone),
            ]))
        .toList();
  }

  List<DataGridRow> _customers = [];

  @override
  List<DataGridRow> get rows => _customers;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
