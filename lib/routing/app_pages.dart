import 'package:get/get.dart';
import '../view/home_view.dart';
import '../view/summer_edit_view.dart';
import '../view/big_deals_view.dart';
import '../view/parenting_guide_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: Routes.SUMMER_EDIT,
      page: () => const SummerEditView(),
    ),
    GetPage(
      name: Routes.BIG_DEALS,
      page: () => const BigDealsView(),
    ),
    GetPage(
      name: Routes.PARENTING_GUIDE,
      page: () => const ParentingGuideView(),
    ),
  ];
}
