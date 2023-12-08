import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => Login(),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
