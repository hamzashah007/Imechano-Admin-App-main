// ignore_for_file: non_constant_identifier_names


// class UpdateJobCardBloc {
//   final updateJobCard = PublishSubject<UpdateJobCardModel>();
//   final _repository = Repository();

//   Stream<UpdateJobCardModel> get updateJobCardStream => updateJobCard.stream;

//   Future updateJobCardSinck(
//       String job_date,
//       String car_reg_number,
//       String year,
//       String mileage,
//       String date_time,
//       String car_make,
//       String car_model,
//       String customer_name,
//       String customer_contact_no,
//       String vin_number,
//       String garage_id,
//       String booking_id,
//       String job_number) async {
//     print("123123123");

//     final UpdateJobCardModel? model = await _repository.onUpdateJobCardApi(
//         job_date,
//         car_reg_number,
//         year,
//         mileage,
//         date_time,
//         car_make,
//         car_model,
//         customer_name,
//         customer_contact_no,
//         vin_number,
//         garage_id,
//         booking_id,
//         job_number);
//     updateJobCard.sink.add(model!);
//   }

//   void dispose() {
//     updateJobCard.close();
//   }
// }

// final updateJobCardBloc = UpdateJobCardBloc();
