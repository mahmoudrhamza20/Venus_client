// import 'package:go_router/go_router.dart';
//
// import '../../features/auth/presentation/views/forget_password_view.dart';
// import '../../features/auth/presentation/views/login_view.dart';
// import '../../features/auth/presentation/views/register_view.dart';
// import '../../features/auth/presentation/views/reset_password_view.dart';
// import '../../features/auth/presentation/views/verify_code_view.dart';
// import '../../features/home/presentations/views/canceling_reasons_view.dart';
// import '../../features/home/presentations/views/contact_us_view.dart';
// import '../../features/home/presentations/views/edit_profile_view.dart';
// import '../../features/home/presentations/views/faq_view.dart';
// import '../../features/home/presentations/views/home_view.dart';
// import '../../features/home/presentations/views/privacy_policy_view.dart';
// import '../../features/home/presentations/views/support_view.dart';
// import '../../features/home/presentations/views/ride_history_view.dart';
// import '../../features/home/presentations/views/ride_story_item_details_view.dart';
// import '../../features/home/presentations/views/searching_car_view.dart';
// import '../../features/home/presentations/views/receipt_view.dart';
// import '../../features/onBoarding/data/presentation/view/on_boarding_view.dart';
// import '../../features/splash/presentation/views/splash_view.dart';
// import '../../features/unsupported_location/presentations/views/unsupported_ location_view.dart';
//
//
// abstract class AppRouter {
//  static const kOnBoarding = '/OnBoardingView';
//  static const kLoginView = '/loginView';
//  static const kRegisterView = '/registerView';
//  static const kForgetPassView = '/forgetPasswordView';
//  static const kVerifyCodeView = '/verifyCodeView';
//  static const kResetPassView = '/resetPassView';
//  static const kHomeView = '/homeView';
//  static const kPrivacyPolicyView = '/privacyPolicyView';
//  static const kFAQsView = '/fAQsView';
//  static const kContactUsView = '/contactUsView';
//  static const kEditProfileView = '/editProfileView';
//  static const kRideStoryView = '/rideStoryView';
//  static const kSearchingCarView = '/searchingCarView';
//  static const kCancelingReasonsView = '/cancelingReasonsView';
//  static const kReceiptView = '/receiptView';
//  static const kRideStoryItemDetailsView = '/rideStoryItemDetailsView';
//  static const kRaiseIssueView= '/raiseIssueView';
//  static const kUnsupportedLocationView= '/unsupportedLocationView';
//
//   static final router = GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const SplashView(),
//       ),
//       GoRoute(
//         path: kOnBoarding,
//         builder: (context, state) => const OnBoardingView(),
//       ),
//       GoRoute(
//         path: kLoginView,
//         builder: (context, state) => const LoginView(),
//       ),
//       GoRoute(
//         path: kRegisterView,
//         builder: (context, state) => const RegisterView(),
//       ),
//       GoRoute(
//         path: kForgetPassView,
//         builder: (context, state) => const ForgetPasswordView(),
//       ),
//       GoRoute(
//         path: kVerifyCodeView,
//         builder: (context, state) =>   const VerifyCodeView(),
//       ),
//       GoRoute(
//         path: kResetPassView,
//         builder: (context, state) =>  const ResetPasswordView(),
//       ),
//       GoRoute(
//         path: kHomeView,
//         builder: (context, state) =>   const HomeView(),
//       ),
//       GoRoute(
//         path: kPrivacyPolicyView,
//         builder: (context, state) =>  const PrivacyPolicyView(),
//       ),
//       GoRoute(
//         path: kFAQsView,
//         builder: (context, state) =>  const FAQsView(),
//       ),
//       GoRoute(
//         path: kContactUsView,
//         builder: (context, state) =>  const ContactUsView(),
//       ),
//       GoRoute(
//         path: kRideStoryView,
//         builder: (context, state) =>  const RideStoryView(),
//       ),
//       GoRoute(
//         path: kEditProfileView,
//         builder: (context, state) =>  const EditProfileView(),
//       ),
//       GoRoute(
//         path: kSearchingCarView,
//         builder: (context, state) =>  const SearchingCarView(),
//       ),
//       GoRoute(
//         path: kCancelingReasonsView,
//         builder: (context, state) =>  const CancelingReasonsView(),
//       ),
//       GoRoute(
//         path: kReceiptView,
//         builder: (context, state) =>  const ReceiptView(),
//       ),
//       GoRoute(
//         path: kRideStoryItemDetailsView,
//         builder: (context, state) =>  const RideStoryItemDetailsView(),
//       ),
//       GoRoute(
//         path: kRaiseIssueView,
//         builder: (context, state) =>  const RaiseIssueView(),
//       ),
//       GoRoute(
//         path: kUnsupportedLocationView,
//         builder: (context, state) =>  const UnsupportedLocationView(),
//       ),
//
//     ],
//   );
// }
