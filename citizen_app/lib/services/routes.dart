import 'package:get/get.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/screens/login.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(
        name: '/home',
        page: () => HomePage(),
      )
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
