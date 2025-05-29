import 'package:conversor_app/views/home_view.dart';
import 'package:conversor_app/views/login_view.dart';
import 'package:conversor_app/views/register_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static final pages = [
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: register, page: () => RegisterView()),
    GetPage(name: home, page: () => HomeView()),
  ];
}
