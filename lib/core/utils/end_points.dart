abstract class EndPoints {
  //------------------------------------------------------------------------//
  static const String baseUrl = 'https://venusride.technomasrsystems.com/api/';
  //------------------------------------------------------------------------//

  static const String login = 'client/login';
  static const String register = 'client/register';
  static const String deleteAccount = 'client/delete';
  static const String profile = 'client/profile';
  static const String updateProfile = 'client/update';
  static const String resetPass = 'reset/updatePassword';
  static const String faqs = 'settings/faqs';
  static const String contactUS = 'settings/contact/pages';
  static const String privacy = 'settings/static/pages';
  static const String sentMsgContactUs = 'settings/send/message';
  static const String sentMsgComplaints = 'settings/send/complaints';
  static const String sentMsgSupport= 'customer/support';
  static const String checkPhone = 'reset/checkOtp';
  static const String getHistoryRide = 'rides/history/client';
  static const String getHistoryRideDetails = 'rides/history/ride';
  static const String cancelledRide = 'rides/cancelled/ride';
  static const String cancelledSearch = 'client/cancel/search';
  static const String calculateRide = 'rides/calculate/ride';
  static const String rating = 'rides/rating/ride';
  static const String getDriver = 'rides/get/rate/ride';
  static const String promoCode = 'checkCoupon';
}
