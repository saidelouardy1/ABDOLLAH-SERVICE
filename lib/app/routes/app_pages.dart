import 'package:get/get.dart';

import '../modules/Authentication/bindings/authentication_binding.dart';
import '../modules/Authentication/views/authentication_view.dart';
import '../modules/Location/bindings/location_binding.dart';
import '../modules/Location/views/location_view.dart';
import '../modules/NavigatorbarBottom/bindings/navigatorbar_bottom_binding.dart';
import '../modules/NavigatorbarBottom/views/navigatorbar_bottom_view.dart';
import '../modules/OnBordining/bindings/on_bordining_binding.dart';
import '../modules/OnBordining/views/on_bordining_view.dart';
import '../modules/SplashScreen/bindings/splash_screen_binding.dart';
import '../modules/SplashScreen/views/splash_screen_view.dart';
import '../modules/Verfication/bindings/verfication_binding.dart';
import '../modules/Verfication/views/verfication_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/discreiption/bindings/discreiption_binding.dart';
import '../modules/discreiption/views/discreiption_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.ON_BORDINING,
      page: () => const OnBordiningView(),
      binding: OnBordiningBinding(),
    ),
    GetPage(
      name: _Paths.VERFICATION,
      page: () => const VerficationView(),
      binding: VerficationBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATORBAR_BOTTOM,
      page: () => const NavigatorbarBottomView(),
      binding: NavigatorbarBottomBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => const LocationView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: _Paths.DISCREIPTION,
      page: () => const DiscreiptionView(),
      binding: DiscreiptionBinding(),
    ),
  ];
}
