import 'package:get/get.dart';
import 'package:mobile_app/screens/enrollment_form.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/screens/login.dart';
import 'package:mobile_app/screens/using_smart_contract.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(
        name: '/home',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/enrollment_form',
        page: () => EnrollmentForm(),
      ),
  GetPage(
    name: '/sc',
    page: () => UsingSmartContract(),
  )
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
