// ignore_for_file: non_constant_identifier_names

import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/ui/provider/accept_booking_provider.dart';
import 'package:imechano_admin/ui/provider/add_parts_provider.dart';
import 'package:imechano_admin/ui/provider/add_services_provider.dart';
import 'package:imechano_admin/ui/provider/admin_notification_list_provider.dart';
import 'package:imechano_admin/ui/provider/appoiement_list_provider.dart';
import 'package:imechano_admin/ui/provider/appoinment_details_provider.dart';
import 'package:imechano_admin/ui/provider/booking_list_provider.dart';
import 'package:imechano_admin/ui/provider/cancel_car_booking_provider.dart';
import 'package:imechano_admin/ui/provider/cust_job_list_provider.dart';
import 'package:imechano_admin/ui/provider/customer_data_provider.dart';
import 'package:imechano_admin/ui/provider/customer_details_provider.dart';
import 'package:imechano_admin/ui/provider/customer_list_provider.dart';
import 'package:imechano_admin/ui/provider/delete_parts_provider.dart';
import 'package:imechano_admin/ui/provider/garage_details_provider.dart';
import 'package:imechano_admin/ui/provider/garage_profile_provider.dart';
import 'package:imechano_admin/ui/provider/incoming_bookings_details_provider.dart';
import 'package:imechano_admin/ui/provider/incoming_bookings_provider.dart';
import 'package:imechano_admin/ui/provider/jobcard_list_provider.dart';
import 'package:imechano_admin/ui/provider/login_provider_api.dart';
import 'package:imechano_admin/ui/provider/pickup_condition_provider.dart';
import 'package:imechano_admin/ui/provider/pickup_details_Provider.dart';
import 'package:imechano_admin/ui/provider/pickup_req_provider.dart';
import 'package:imechano_admin/ui/provider/pickup_request_provider.dart';
import 'package:imechano_admin/ui/provider/pickup_schedule_list_provider.dart';
import 'package:imechano_admin/ui/provider/reject_booking_provider.dart';
import 'package:imechano_admin/ui/provider/send_notification_customer_provider.dart';
import 'package:imechano_admin/ui/provider/service_delete_provider.dart';
import 'package:imechano_admin/ui/provider/update_job_card_provider.dart';
import 'package:imechano_admin/ui/provider/view_data_provider.dart';
import 'package:imechano_admin/ui/provider/view_services_provider.dart';

import '../provider/pickup_condition_list_provider.dart';
import '../provider/set_jobcard_completed_provider.dart';
import '../provider/update_customer_item_provider.dart';
import '../provider/view_items_provider.dart';

class Repository {
  final LoginApi loginapi = LoginApi();
  final AllCustomerDataApi customerdata = AllCustomerDataApi();
  final AllCustomerDetailsApi customerdetails = AllCustomerDetailsApi();
  final AppoinmentDetailsAPI appoinmentDetailsAPI = AppoinmentDetailsAPI();
  final AppointmentListApi appointmentist = AppointmentListApi();
  final GarageProfileApi garageprofile = GarageProfileApi();
  final CustomerListApi customerlist = CustomerListApi();
  final PickupRequestApi pickuprequest = PickupRequestApi();
  final PickupScheduleListApi pickupschedulelist = PickupScheduleListApi();
  final ConditionListApi conditionlistapi = ConditionListApi();
  final JobcardListApi jobcardListApi = JobcardListApi();
  final GarageDetailsAPI garageDetailsAPI = GarageDetailsAPI();
  final PickupDetailsAPI pickupDetailsAPI = PickupDetailsAPI();
  final UpdateJobCardApi updateJobCardApi = UpdateJobCardApi();
  final CustomerJobListAPI customerJobListAPI = CustomerJobListAPI();
  final PickupConditionApi pickupConditionApi = PickupConditionApi();
  final cancelCarBookingApi = CancelCarBookingApi();
  final SendNotificationCustomerApi sendNotificationCustomerApi =
      SendNotificationCustomerApi();
  final IncomingBookingsApi incomingBook = IncomingBookingsApi();
  final IncomingBookingsDetailsApi incomingDetails =
      IncomingBookingsDetailsApi();
  final AcceptBookingApi acceptbooking = AcceptBookingApi();
  final RejectBookingApi rejectbooking = RejectBookingApi();
  final AdminNotificationListeApi notificationListApi =
      AdminNotificationListeApi();
  final BookingListApi bookingListApi = BookingListApi();

  final PickuprequestadminApi pickuprequestadminApi = PickuprequestadminApi();
  final AddPartsDataAPi addPartsDataAPi = AddPartsDataAPi();
  final ViewPartsDataAPI viewPartsDataAPI = ViewPartsDataAPI();
  final AddServiceDataAPi addServiceDataAPi = AddServiceDataAPi();
  final ViewServicesDataAPI viewServicesDataAPI = ViewServicesDataAPI();
  final ViewItemsDataAPI viewItemsDataAPI = ViewItemsDataAPI();
  final UpdateCustomerItemApi updateCustomerItemAPI = UpdateCustomerItemApi();
  final SetJobCardCompletedApi setJobCardCompletedApi =
      SetJobCardCompletedApi();
  final DeletepartsAPI deletepartsAPI = DeletepartsAPI();
  final DeleteServiceAPI deleteServiceAPI = DeleteServiceAPI();

  Future<dynamic> onLogin(String email, String password, String fcmToken) =>
      loginapi.onLoginApi(email, password, fcmToken);
  Future<dynamic> oncustomerdataAPI(String page) =>
      customerdata.onCustomerDataApi(page);
  Future<dynamic> oncustomerdetailsAPI(String customer_id) =>
      customerdetails.onCustomerDetailsApi(customer_id);
  Future<dynamic> onAppointmentListApi(String fromdate, String todate) =>
      appointmentist.onAppointmentListApi(fromdate, todate);
  Future<dynamic> onGarageProfileApi() => garageprofile.onGarageProfileApi();
  Future<dynamic> onCustomerListApi(String status) =>
      customerlist.onCustomerListApi(status);
  Future<dynamic> onPickupRequestApi(String customer_id) =>
      pickuprequest.onPickupRequestApi(customer_id);
  Future<dynamic> onPickupScheduleListApi(String user_id) =>
      pickupschedulelist.onPickupScheduleListApi(user_id);

  Future<dynamic> onJobcardListAPI({String? garageId}) =>
      jobcardListApi.onJobcardListApi(garageId: garageId);
  Future<dynamic> onCancelBooking(String bookingId) =>
      cancelCarBookingApi.onCancelCarBookingApi(bookingId);
  Future<dynamic> BookingListAPI(String userid, String status, String search,
          String start_date, String end_date, String category) =>
      bookingListApi.onBookingListApi(
          userid, status, search, start_date, end_date, category);

  Future<dynamic> onAppointmentdetailsAPI(String appoiement_id) =>
      appoinmentDetailsAPI.onAppoimentdetailsApi(appoiement_id);
  Future<dynamic> onGaragedetailsAPI(String garage_id) =>
      garageDetailsAPI.onGaragedetailsApi(garage_id);
  Future<dynamic> onPickupdetailsAPI(String pickup_id) =>
      pickupDetailsAPI.onPickupdetailsApi(pickup_id);
  Future<dynamic> onUpdateJobCardApi(
          String job_date,
          String car_reg_number,
          String year,
          String mileage,
          String date_time,
          String car_make,
          String car_model,
          String customer_name,
          String customer_contact_no,
          String vin_number,
          String garage_id,
          String booking_id,
          String job_number,
          List<XFile?> _selectedImages) =>
      updateJobCardApi.onUpdateJobCardApi(
          job_date,
          car_reg_number,
          year,
          mileage,
          date_time,
          car_make,
          car_model,
          customer_name,
          customer_contact_no,
          vin_number,
          garage_id,
          booking_id,
          job_number,
          _selectedImages);
  Future<dynamic> onCustJobListAPI(String job_number) =>
      customerJobListAPI.onCustomerJobListApi(job_number);
  Future<dynamic> onPickupConditionAPI(String label, String carcondition,
          String workneeded, String bookingid, String carimage) =>
      pickupConditionApi.onPickupConditionApi(
          label, carcondition, workneeded, bookingid, carimage);
  // Future<dynamic> onListCondition(String booking_id) => conditionlistapi.onConditionListApi(booking_id);
  Future<dynamic> onListCondition(String booking_id) =>
      conditionlistapi.listPickupConditions(booking_id);

  Future<dynamic> onSendNotificationAPI(
          String booking_id, String title, String message) =>
      sendNotificationCustomerApi.onSendNotificationCustomerApi(
          booking_id, title, message);

  Future<dynamic> onIncomingBookingsAPI(
          String status, String fromdate, String todate) =>
      incomingBook.onIncomingBookingsApi(status, fromdate, todate);
  Future<dynamic> onIncomingBookingsDetailsApi(String id) =>
      incomingDetails.onIncomingBookingsDetailsApi(id);
  Future<dynamic> onAcceptBookingAPI(
          String booking_id, String delievery_charges, String garage_id) =>
      acceptbooking.onAcceptBookingApi(
          booking_id, delievery_charges, garage_id);
  Future<dynamic> onRejectBookingAPI(String booking_id) =>
      rejectbooking.onRejectBookingApi(booking_id);
  Future<dynamic> onUpdateCustomerItemAPI(String item_id) =>
      updateCustomerItemAPI.onUpdateCustomerItemApi(item_id);
  Future<dynamic> onSetJobCardCompletedApi(String job_number) =>
      setJobCardCompletedApi.onSetJobCardCompletedApi(job_number);
  Future<dynamic> onAdminNotificationListApi() =>
      notificationListApi.onAdminNotificationListeApi();
  Future<dynamic> onAdminPickupNotificationApi(String booking_id) =>
      pickuprequestadminApi.onSendNotificationPickuprequestApi(booking_id);

  Future<dynamic> onAddPartsDataAPI(
          String part_number,
          String part_type,
          String part_desc,
          String qty,
          String est_cost,
          String total,
          String job_number) =>
      addPartsDataAPi.onAddPartsDataApi(
          part_number, part_type, part_desc, qty, est_cost, total, job_number);

  Future<dynamic> onViewDataAPI(String job_number) =>
      viewPartsDataAPI.onViewpartsDataApi(job_number);

  Future<dynamic> onAddServicesDataAPI(String serviceName, String service_desc,
          String service_cost, String job_number) =>
      addServiceDataAPi.onAddServicesDataApi(
          serviceName, service_desc, service_cost, job_number);

  Future<dynamic> onViewServicesAPI(String job_number) =>
      viewServicesDataAPI.onServicesDataApi(job_number);

  Future<dynamic> onViewItemsAPI(String job_number) =>
      viewItemsDataAPI.onViewItemsDataApi(job_number);

  Future<dynamic> onDeletepartdata(String id) =>
      deletepartsAPI.onDeletePartsListApi(id);

  Future<dynamic> onDeleteservicedata(String id) =>
      deleteServiceAPI.onDeleteServiceListApi(id);
}
