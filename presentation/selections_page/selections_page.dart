import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/core/utils/progress_dialog_utils.dart';
import 'package:mubicloud/presentation/selections_page/controller/selections_controller.dart';
import 'package:mubicloud/presentation/selections_page/models/selection_model.dart';
import 'package:mubicloud/presentation/selections_page/widgets/selections_horizontal_list.dart';
import 'package:mubicloud/presentation/selections_page/widgets/selections_vertical_list.dart';
import 'package:mubicloud/widgets/app_bar/appbar_image.dart';
import 'package:mubicloud/widgets/custom_bottom_nav_bar.dart';

import '../../widgets/custom_top_bar.dart';

// ignore_for_file: must_be_immutable
class SelectionsPage extends StatelessWidget {
  SelectionsPage({Key? key}) : super(key: key);

  SelectionsController selectionsController = Get.find<SelectionsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SelectionsController>(
        init: selectionsController,
        builder: (controller) => Scaffold(
          backgroundColor: UIConstants().bgColor,
          appBar: CustomTopBar(
            titleWidget: Text(
              overflow: TextOverflow.ellipsis,
              "lbl_selections".tr,
              style: UIConstants().textStyleMedium.copyWith(
                  color: UIConstants().textColor, fontWeight: FontWeight.w700),
            ),
            icon: AppbarImage(
              width: AppBar().preferredSize.height * 0.8.h,
              imagePath: PrefUtils().getThemeData() == "primary"
                  ? ImageConstant.imageSelectionsLight
                  : ImageConstant.imageSelectionsDark,
              margin: getMargin(left: 25),
            ),
            actions: [],
          ),
          body: Obx(
            () {
              if (selectionsController.isLoading.value) {
                return Center(
                    child: ProgressBarUtils.showProgressBar(context,
                        isFullSize: true));
              }
              List<SelectionModel> popularitySelections =
                  selectionsController.mySelections.sublist(0, 18);
              List<SelectionModel> interestingSelections =
                  selectionsController.mySelections.sublist(18, 27);
              List<SelectionModel> allSelections = selectionsController
                  .mySelections
                  .sublist(27, selectionsController.mySelections.length);
              return Padding(
                padding: getPadding(top: 10),
                child: ListView(
                  padding: getPadding(bottom: 24),
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  shrinkWrap: false,
                  children: [
                    SelectionsHorizontalList(
                      title:
                          '${'lbl_popularity_selections'.tr} (${popularitySelections.length})',
                      selections: popularitySelections,
                      selectionGroupTitle: 'lbl_popularity_selections'.tr,
                      selectionGroupTap: onTapSelectionGroup,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SelectionsVerticalList(
                      title:
                          '${'lbl_interesting_selections'.tr} (${interestingSelections.length})',
                      selections: interestingSelections,
                      selectionGroupTitle: 'lbl_interesting_selections'.tr,
                      selectionGroupTap: onTapSelectionGroup,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SelectionsHorizontalList(
                      title:
                          '${'lbl_all_selections'.tr} (${allSelections.length})',
                      selections: allSelections,
                      selectionGroupTitle: 'lbl_all_selections'.tr,
                      selectionGroupTap: onTapSelectionGroup,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  RxList<SelectionModel> shuffle(RxList<SelectionModel> selections) {
    RxList<SelectionModel> shuffleSelections =
        RxList<SelectionModel>.from(selections.toList());
    shuffleSelections.shuffle();
    return shuffleSelections;
  }

  onTapSelectionGroup(int selectionId, String selectionGroupTitle) {
    selectionsController.currentSelectionId = selectionId;
    selectionsController.currentSelectionGroupTitle = selectionGroupTitle;
    selectionsController.putViewsSelections(selectionId);
    Get.toNamed(AppRoutes.selectionScreen,
        arguments: {
          'selectionId': selectionId,
          'selectionGroupTitle': selectionGroupTitle,
        },
        id: BottomBarTab.selections);
  }
}
