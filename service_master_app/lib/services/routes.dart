import 'package:get/get.dart';
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
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
