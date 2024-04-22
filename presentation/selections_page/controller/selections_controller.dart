import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/data/apiClient/mubicloud_api.dart';
import 'package:mubicloud/presentation/selection_screen/models/selection_index_model.dart';
import 'package:mubicloud/presentation/selections_page/models/selection_model.dart';
import 'package:mubicon/api.dart';

/// A controller class for the MyLibaryAddPage.
///
/// This class manages the state of the MyLibaryAddPage, including the
/// current myLibaryAddModelObj
class SelectionsController extends GetxController {
  final MubicloudApi _mubicloudApi = MubicloudApi();
  final RxList<SelectionModel> mySelections = RxList<SelectionModel>();
  Map<int, Widget> userRating = {};
  var isLoading = true.obs;
  int currentSelectionId = 0;
  String currentSelectionGroupTitle = '';

  @override
  void onInit() {
    super.onInit();
    _loadSelections();
  }

  Future<void> load() async {
    await _loadSelections();
  }

  Future<void> _loadSelections() async {
    final List<SelectionIndexResponse>? selections =
        await _mubicloudApi.selections();

    if (selections != null && selections.isNotEmpty) {
      final List<SelectionModel> loadedPlaylists = selections
          .map((playlist) => SelectionModel.fromNonObservable(playlist))
          .toList();

      mySelections.assignAll(loadedPlaylists);
    }
    initUserRatingForSelections();
    isLoading.value = true;
    isLoading.value = false;
    update();
  }

  Future<void> putViewsSelections(int? selectionId) async {
    if (selectionId == null) return;
    await _mubicloudApi.putViewsSelections(selectionId);
  }

  Future<SelectionIndexModel?> getSelectionModel(int selectionId) async {
    final SelectionGetResponse? selection =
        await _mubicloudApi.getSelection(selectionId);

    if (selection != null) {
      SelectionIndexModel selectionIndexModel =
          SelectionIndexModel.fromNonObservable(selection);
      return selectionIndexModel;
    }
    return null;
  }

  Future initUserRatingForSelections() async {
    userRating.addEntries(
      mySelections.map(
        (element) => MapEntry(
          element.selectionId!,
          getRatingBar(0, element.selectionId!),
        ),
      ),
    );
  }

  Future countingRatingStars(int? selectionId, double newRating) async {
    if (selectionId == null) return;
    var newRatingBar = getRatingBar(newRating, selectionId);
    userRating[selectionId] = newRatingBar;
    isLoading.value = true;
    isLoading.value = false;
    _mubicloudApi.putRatingSelections(selectionId, newRating);
  }

  Widget getRatingBar(double rating, int selectionId) {
    return RatingBar(
      initialRating: rating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 30.h,
      glow: false,
      ratingWidget: RatingWidget(
        full: CustomImageView(
          svgPath: ImageConstant.imgRatingFill,
          color: UIConstants().primaryColor,
        ),
        half: CustomImageView(
          svgPath: ImageConstant.imgRatingEmpty,
          color: UIConstants().textColor,
        ),
        empty: CustomImageView(
          svgPath: ImageConstant.imgRatingEmpty,
          color: UIConstants().textColor,
        ),
      ),
      itemPadding: getPadding(left: 3, right: 3),
      onRatingUpdate: (rating) {
        putRatingSelections(selectionId, rating);
      },
    );
  }

  Future<void> putRatingSelections(int? selectionId, double newRating) async {
    if (selectionId == null) return;
    await _mubicloudApi.putRatingSelections(selectionId, newRating);
  }
}
