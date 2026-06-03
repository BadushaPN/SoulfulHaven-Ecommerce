import 'package:get/get.dart';
import '../model/product_model.dart';
import '../view/widgets/login_popup.dart';

class HomeController extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 4), () {
      if (Get.isDialogOpen != true) {
        Get.dialog(const LoginPopup(), barrierDismissible: false);
      }
    });
  }

  void fetchProducts() {
    isLoading.value = true;
    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      products.value = [
        Product(
          id: '1',
          title: 'Mantra Chanting Gautam Buddha (Small - 25 cms)',
          description: '',
          price: 769,
          originalPrice: 1099,
          discountPercentage: '30%',
          rating: 4.64,
          imageUrl: 'https://images.unsplash.com/photo-1599839619722-39751411ea63?auto=format&fit=crop&q=80&w=600', // Buddha
        ),
        Product(
          id: '2',
          title: 'Mantra Chanting Devi Lakshmi (Small - 22 cms)',
          description: '',
          price: 799,
          originalPrice: 1399,
          discountPercentage: '42%',
          rating: 4.67,
          imageUrl: 'https://images.unsplash.com/photo-1604502844222-1f4a478c9ed3?auto=format&fit=crop&q=80&w=600', // Lakshmi / Gold tone
        ),
        Product(
          id: '3',
          title: 'Mantra Chanting Baby Ganesha (Medium - 28 cms)',
          description: '',
          price: 969,
          originalPrice: 1499,
          discountPercentage: '35%',
          rating: 4.84,
          imageUrl: 'https://images.unsplash.com/photo-1582506307185-1d48c909e701?auto=format&fit=crop&q=80&w=600', // Ganesha
        ),
         Product(
          id: '4',
          title: 'Mantra Chanting Baby Hanuman (Medium - 28 cms)',
          description: '',
          price: 969,
          originalPrice: 1499,
          discountPercentage: '35%',
          rating: 4.79,
          imageUrl: 'https://images.unsplash.com/photo-1634887361661-bc579a3fa27d?auto=format&fit=crop&q=80&w=600', // Hanuman
        ),
      ];
      isLoading.value = false;
    });
  }
}
