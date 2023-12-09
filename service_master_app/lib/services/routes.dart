import 'package:get/get.dart';
import 'package:service_master_app/screens/login.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
