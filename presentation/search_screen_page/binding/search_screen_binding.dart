import '../controller/search_screen_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SearchScreenFillScreen.
///
/// This class ensures that the SearchScreenFillController is created when the
/// SearchScreenFillScreen is first loaded.
class SearchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchScreenController());
  }
}
