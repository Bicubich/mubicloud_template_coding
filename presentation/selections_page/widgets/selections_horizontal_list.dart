import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/core/utils/size_utils.dart';
import 'package:mubicloud/presentation/selections_page/models/selection_model.dart';
import 'package:mubicloud/presentation/selections_page/widgets/selection_item.dart';

class SelectionsHorizontalList extends StatelessWidget {
  SelectionsHorizontalList(
      {super.key,
      required this.title,
      required this.selections,
      required this.selectionGroupTitle,
      required this.selectionGroupTap});

  final String title;
  final List<SelectionModel> selections;
  final String selectionGroupTitle;
  final Function(int id, String selectionGroupTitle) selectionGroupTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(left: 40),
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
        SizedBox(
          height: 285.w,
          child: ListView.separated(
            padding: getPadding(left: 20, right: 20, bottom: 15),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SelectionItem(
              selection: selections[index],
              isItemForHorizontalList: true,
              selectionGroupTitle: selectionGroupTitle,
            ),
            itemCount: selections.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 15.w,
            ),
          ),
        ),
      ],
    );
  }
}
