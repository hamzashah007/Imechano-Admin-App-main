// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:imechano_admin/ui/bloc/view_data_bloc.dart';
// import 'package:imechano_admin/ui/bloc/view_services_bloc.dart';
// import 'package:imechano_admin/ui/model/view_parts_model.dart';
// import 'package:imechano_admin/ui/model/view_service_model.dart';
// import 'package:imechano_admin/ui/repository/repository.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// class Serviced extends StatefulWidget {
//   Serviced({Key? key}) : super(key: key);

//   @override
//   _ServicedState createState() => _ServicedState();
// }

// class _ServicedState extends State<Serviced> {
//   List<ServicesData> servicess = <ServicesData>[];
//   late ServicesDataSource servicesDataSource;

//   @override
//   void initState() {
//     super.initState();
//     // viewPartsDataBloc.onViewPartsDataSink();
//     viewServicesDataBloc.onViewServicesDataSink();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Syncfusion Flutter DataGrid'),
//         ),
//         body: StreamBuilder<ViewServiceModel>(
//             stream: viewServicesDataBloc.ViewServicesStream,
//             builder: (context,
//                 AsyncSnapshot<ViewServiceModel> ViewServicesDataSnapshot) {
//               if (!ViewServicesDataSnapshot.hasData) {
//                 return CircularProgressIndicator();
//               }
//               for (var i = 0;
//                   i < ViewServicesDataSnapshot.data!.data!.length;
//                   i++) {
//                 servicess.add(
//                   ServicesData(
//                       // ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
//                       ViewServicesDataSnapshot.data!.data![i].serviceDesc
//                           .toString(),
//                       ViewServicesDataSnapshot.data!.data![i].serviceCost
//                           .toString(),
//                       // ViewpartsDataSnapshot.data!.data![i].total.toString(),
//                       ''),
//                 );
//               }
//               servicesDataSource = ServicesDataSource(servicesdata: servicess);
//               var data1 = ViewServicesDataSnapshot.data!.data;
//               return Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Text(
//                         "Services Estimate:",
//                         style:
//                             TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.only(
//                         left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.all(Radius.circular(2))),
//                     height: 350.h,
//                     child: SfDataGridTheme(
//                       data: SfDataGridThemeData(
//                           headerColor: const Color(0xff162e3f)),
//                       child: SfDataGrid(
//                         source: servicesDataSource,
//                         showCheckboxColumn: true,
//                         selectionMode: SelectionMode.multiple,
//                         checkboxColumnSettings: DataGridCheckboxColumnSettings(
//                           showCheckboxOnHeader: true,
//                           width: 50,
//                         ),
//                         columnWidthMode: ColumnWidthMode.none,
//                         defaultColumnWidth: 115,
//                         gridLinesVisibility: GridLinesVisibility.horizontal,
//                         columns: <GridColumn>[
//                           GridColumn(
//                               columnName: 'Remove',
//                               label: Container(
//                                   decoration: BoxDecoration(),
//                                   padding: EdgeInsets.all(8.0),
//                                   alignment: Alignment.center,
//                                   child: Text('',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 11,
//                                           color: Colors.white)))),
//                           GridColumn(
//                               columnName: 'serviceDec',
//                               label: Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     'ServiceDec',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                         color: Colors.white),
//                                   ))),
//                           GridColumn(
//                               columnName: 'servicecharge',
//                               label: Container(
//                                   decoration: BoxDecoration(),
//                                   padding: EdgeInsets.all(8.0),
//                                   alignment: Alignment.center,
//                                   child: Text('Servicecharge',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 11,
//                                           color: Colors.white)))),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 10),
//                       child: Container(
//                         height: 40.h,
//                         width: 150.w,
//                         alignment: Alignment.center,
//                         color: Colors.grey[200],
//                         child: Text(
//                           "Est Balance: KWD 10.000",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontFamily: "Poppins4", fontSize: 11.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }));
//   }
// }

// class ServicesData {
//   ServicesData(this.serviceDec, this.servicecharge, this.remove);

//   final String serviceDec;

//   final String servicecharge;

//   final String remove;
// }

// class ServicesDataSource extends DataGridSource {
//   ServicesDataSource({required List<ServicesData> servicesdata}) {
//     _ServicesData = servicesdata
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<String>(columnName: 'Remove', value: e.remove),
//               DataGridCell<String>(
//                   columnName: 'servicecharge', value: e.servicecharge),
//               DataGridCell<String>(
//                   columnName: 'serviceDec', value: e.serviceDec),
//               // DataGridCell<String>(columnName: 'total', value: e.total),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _ServicesData = [];
//   final _repository = Repository();

//   @override
//   List<DataGridRow> get rows => _ServicesData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         // color: getRowBackgroundColor(),
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       if (dataGridCell.columnName == 'Remove') {
//         final int index = effectiveRows.indexOf(row);
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: GestureDetector(
//             onTap: () {
//               print('object');
//             },
//             child: Container(
//               child: Icon(
//                 Icons.restore_from_trash_rounded,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//         );
//       }

//       return Container(
//           alignment: Alignment.center,
//           child: Text(dataGridCell.value.toString(),
//               style: TextStyle(fontSize: 11)));
//     }).toList());
//   }
// }
