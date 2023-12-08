import 'package:get/get.dart';
import 'package:mobile_app/screens/login.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => const LoginPage(),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
