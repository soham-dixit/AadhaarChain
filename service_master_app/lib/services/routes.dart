import 'package:get/get.dart';
import 'package:service_master_app/screens/customer_list.dart';
import 'package:service_master_app/screens/login.dart';
import 'package:service_master_app/screens/register.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(
        name: '/register',
        page: () => RegisterPage(),
      ),
      GetPage(
        name: '/customer_list',
        page: () => Apointments(),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
