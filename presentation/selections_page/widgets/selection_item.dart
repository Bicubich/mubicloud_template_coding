import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/core/utils/app_config.dart';
import 'package:mubicloud/core/utils/image_constant.dart';
import 'package:mubicloud/core/utils/pref_utils.dart';
import 'package:mubicloud/core/utils/size_utils.dart';
import 'package:mubicloud/core/utils/track_utils.dart';
import 'package:mubicloud/presentation/selection_screen/models/selection_index_model.dart';
import 'package:mubicloud/presentation/selection_screen/widgets/info_selection_dialog.dart';
import 'package:mubicloud/presentation/selections_page/controller/selections_controller.dart';
import 'package:mubicloud/presentation/selections_page/models/selection_model.dart';
import 'package:mubicloud/theme/theme_helper.dart';
import 'package:mubicloud/widgets/custom_bottom_nav_bar.dart';

import '../../../routes/app_routes.dart';

// ignore: must_be_immutable
class SelectionItem extends StatelessWidget {
  SelectionItem({
    super.key,
    required this.selection,
    required this.isItemForHorizontalList,
    this.isOnlyItemInVerticalList,
    required this.selectionGroupTitle,
  });

  final SelectionModel selection;
  final String selectionGroupTitle;
  final bool isItemForHorizontalList;
  final bool? isOnlyItemInVerticalList;

  double ratingPadding = 15;

  double ratingPaddingPosition = 10;

  double ratingStarSize = 20;

  late double imageHeight;

  SelectionsController selectionsController = Get.find<SelectionsController>();

  @override
  Widget build(BuildContext context) {
    imageHeight = isItemForHorizontalList || isOnlyItemInVerticalList == true
        ? 285.w
        : 140.w;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onTapSelection(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12.r),
            top: Radius.circular(24.r),
          ),
          color: appTheme.gray100,
          boxShadow: [
            if (PrefUtils().getThemeData() == 'primary')
              BoxShadow(
                color: UIConstants()
                    .backgroundDark
                    .withOpacity(0.12), // Прозрачность тени
                //spreadRadius: 2, // Распределение тени
                blurRadius: 12, // Радиус размытия тени
                offset: Offset(0, 5), // Смещение тени
              ),
          ],
        ),
        child: Column(
          children: [
            isItemForHorizontalList
                ? Expanded(
                    child: topSectorSelection(context),
                  )
                : SizedBox(
                    height:
                        isOnlyItemInVerticalList == true ? null : null, // 203.w
                    child: topSectorSelection(context),
                  ),
            bottomSectorSelection(),
          ],
        ),
      ),
    );
  }

  Widget topSectorSelection(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            height: imageHeight,
            child: selection.imageFile != null
                ? CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: selection.imageFile!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: appTheme.deepPurpleA200Opacity02,
                      child: LottieBuilder.asset(
                        'assets/images/lottie/circle_loader.json',
                        height: imageHeight,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AppConfig().getDefaultTrackImageAsset(),
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    AppConfig().getDefaultTrackImageAsset(),
                    fit: BoxFit.cover,
                  ),
            color: appTheme.gray100,
            width: isItemForHorizontalList ? 350.w : null,
          ),
        ),
        Positioned(
          top: ratingPaddingPosition.h,
          left: ratingPaddingPosition.w,
          child: GestureDetector(
            onTap: () async => await onTapSelectionRating(context,
                selectionId: selection.selectionId),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: UIConstants().primaryColor.withOpacity(0.7),
              ),
              child: Padding(
                padding: getPadding(
                    all: isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? ratingPadding
                        : 8),
                child: Column(
                  children: [
                    Icon(
                      Icons.star,
                      size: isItemForHorizontalList ||
                              isOnlyItemInVerticalList == true
                          ? ratingStarSize.w
                          : 12.w,
                      color: Colors.white,
                    ),
                    Text(
                      selection.rating!.toStringAsFixed(1),
                      style: UIConstants().textStyleVerySmallBold.copyWith(
                          color: Colors.white,
                          fontSize: isItemForHorizontalList ||
                                  isOnlyItemInVerticalList == true
                              ? 14.sp
                              : 10.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container bottomSectorSelection() {
    double verticalPadding =
        isItemForHorizontalList || isOnlyItemInVerticalList == true
            ? 10.h
            : 7.h;
    double horizontalPadding = 12;
    EdgeInsets padding = getPadding(
        left: horizontalPadding,
        right: horizontalPadding,
        top: verticalPadding,
        bottom: verticalPadding);
    return Container(
      width: isItemForHorizontalList ? 350.w : null,
      child: Padding(
        padding: padding,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        selection.name!,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: isItemForHorizontalList ||
                                isOnlyItemInVerticalList == true
                            ? UIConstants()
                                .textStyleMedium
                                .copyWith(color: UIConstants().textColor)
                            : UIConstants().textStyleVerySmall.copyWith(
                                color: UIConstants().textColor,
                                fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    isItemForHorizontalList || isOnlyItemInVerticalList == true
                        ? 7.h
                        : 4.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.imageTracksDuration,
                    width: getHorizontalSize(isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 24
                        : 16),
                    color: UIConstants().textColor.withAlpha(50),
                  ),
                  SizedBox(
                    width: isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 7.w
                        : 4.w,
                  ),
                  Padding(
                    padding: getPadding(
                        bottom: isItemForHorizontalList ||
                                isOnlyItemInVerticalList == true
                            ? 2
                            : 0),
                    child: Text(
                      isItemForHorizontalList ||
                              isOnlyItemInVerticalList == true
                          ? formatDuration(
                              selection.duration!,
                            )
                          : trimMilliseconds(formatDuration(
                              selection.duration!,
                            )),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: UIConstants().textStyleVerySmall.copyWith(
                            color: UIConstants().textColor.withAlpha(50),
                            fontSize: isItemForHorizontalList ||
                                    isOnlyItemInVerticalList == true
                                ? null
                                : 11.sp,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 25.w
                        : 12.w,
                  ),
                  Image.asset(
                    ImageConstant.imageTracksCount2,
                    width: getHorizontalSize(isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 23
                        : 15),
                    color: UIConstants().textColor.withAlpha(50),
                  ),
                  SizedBox(
                    width: isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 7.w
                        : 4.w,
                  ),
                  Padding(
                    padding: getPadding(
                        bottom: isItemForHorizontalList ||
                                isOnlyItemInVerticalList == true
                            ? 2
                            : 0),
                    child: Text(
                      selection.count.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: UIConstants().textStyleVerySmall.copyWith(
                            color: UIConstants().textColor.withAlpha(50),
                            fontSize: isItemForHorizontalList ||
                                    isOnlyItemInVerticalList == true
                                ? null
                                : 11.sp,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 25.w
                        : 12.w,
                  ),
                  Image.asset(
                    ImageConstant.imageTracksViews,
                    width: getHorizontalSize(isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 22
                        : 14),
                    color: UIConstants().textColor.withAlpha(50),
                  ),
                  SizedBox(
                    width: isItemForHorizontalList ||
                            isOnlyItemInVerticalList == true
                        ? 7.w
                        : 4.w,
                  ),
                  Padding(
                    padding: getPadding(
                        bottom: isItemForHorizontalList ||
                                isOnlyItemInVerticalList == true
                            ? 2
                            : 0),
                    child: Text(
                      selection.views.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: UIConstants().textStyleVerySmall.copyWith(
                            color: UIConstants().textColor.withAlpha(50),
                            fontSize: isItemForHorizontalList ||
                                    isOnlyItemInVerticalList == true
                                ? null
                                : 11.sp,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapSelection() {
    selectionsController.currentSelectionId = selection.selectionId!;
    selectionsController.currentSelectionGroupTitle = selectionGroupTitle;
    selectionsController.putViewsSelections(selection.selectionId);
    Get.toNamed(AppRoutes.selectionScreen,
        arguments: {
          'selectionId': selection.selectionId,
          'selectionGroupTitle': selectionGroupTitle,
        },
        id: BottomBarTab.selections);
  }

  onTapSelectionRating(BuildContext context, {int? selectionId}) async {
    SelectionIndexModel? selectionIndexModel;
    if (selectionId != null)
      selectionIndexModel =
          await selectionsController.getSelectionModel(selectionId);

    if (selectionIndexModel != null)
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            contentPadding: EdgeInsets.zero,
            content: InfoSelectionDialog(
              selectionsController: selectionsController,
              selectionModel: selectionIndexModel!,
            ),
          );
        },
      );
  }
}
