import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/core/utils/size_utils.dart';
import 'package:mubicloud/presentation/selections_page/models/selection_model.dart';
import 'package:mubicloud/presentation/selections_page/widgets/selection_item.dart';

// ignore: must_be_immutable
class SelectionsVerticalList extends StatelessWidget {
  SelectionsVerticalList(
      {super.key,
      required this.title,
      required this.selections,
      required this.selectionGroupTitle,
      required this.selectionGroupTap});

  final String title;
  final List<SelectionModel> selections;
  final String selectionGroupTitle;
  final Function(int id, String selectionGroupTitle) selectionGroupTap;

  double ratingPadding = 5;
  double ratingPaddingPosition = 10;
  double ratingStarSize = 12;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    //List<Widget> tracksInRow = [];
    rows.addAll([
      getTwoSelectionInRow(
        [0, 1],
      ),
      getTwoSelectionInRow(
        [2, 3],
      ),
      getOneBigSelectionInRow(4),
      getOneBigSelectionInRow(5),
      getTwoSelectionInRow(
        [6, 7],
      ),
      getOneBigSelectionInRow(8),
    ]);
    //for (var item = 0; item < selections.length; item++) {
    //  SelectionModel selection = selections[item];
    //  if (item % 3 == 0) {
    //    tracksInRow.add(
    //      Expanded(
    //        child: SelectionItem(
    //          selection: selection,
    //          isItemForHorizontalList: false,
    //          isOnlyItemInVerticalList: true,
    //          selectionGroupTitle: selectionGroupTitle,
    //        ),
    //      ),
    //    );
    //  } else {
    //    tracksInRow.add(
    //      Expanded(
    //        child: Padding(
    //          padding: getPadding(
    //            right: (item - 1) % 3 == 0 ? 8 : 0,
    //            left: (item - 1) % 3 != 0 ? 8 : 0,
    //          ),
    //          child: SelectionItem(
    //            selection: selection,
    //            isItemForHorizontalList: false,
    //            selectionGroupTitle: selectionGroupTitle,
    //          ),
    //        ),
    //      ),
    //    );
    //  }
    //  if (item % 3 == 0 || (item - 1) % 3 != 0) {
    //    rows.add(
    //      Column(
    //        children: [
    //          Row(
    //            children: tracksInRow,
    //          ),
    //          SizedBox(
    //            height: 16.w,
    //          ),
    //        ],
    //      ),
    //    );
    //    tracksInRow = [];
    //  }
    //}

    return Padding(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: getPadding(left: 20),
            child: InkWell(
              onTap: () =>
                  selectionGroupTap(selections.first.selectionId!, title),
              child: Text(
                title,
                style: UIConstants()
                    .textStyleVerySmall
                    .copyWith(color: UIConstants().textColor),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          ...rows
        ],
      ),
    );
  }

  Widget getTwoSelectionInRow(List<int> selectionIndexes) {
    return Column(
      children: [
        Row(
          children: [
            getSelectionInRow(selectionIndexes[0], isFirst: true),
            getSelectionInRow(selectionIndexes[1], isFirst: false),
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }

  Widget getOneBigSelectionInRow(int selectionIndex) {
    return Column(
      children: [
        Row(
          children: [
            getSelectionInRow(selectionIndex, isBigSelection: true),
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
      ],
    );
  }

  Widget getSelectionInRow(int selectionIndex,
      {bool isBigSelection = false, bool? isFirst}) {
    return Expanded(
      child: Padding(
        padding: isBigSelection
            ? EdgeInsets.zero
            : getPadding(
                right: isFirst! ? 8 : 0,
                left: !isFirst ? 8 : 0,
              ),
        child: SelectionItem(
          selection: selections[selectionIndex],
          isItemForHorizontalList: false,
          selectionGroupTitle: selectionGroupTitle,
          isOnlyItemInVerticalList: isBigSelection,
        ),
      ),
    );
  }
}
