import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomReorderableListView extends ReorderableListView {
  CustomReorderableListView.separated({
    Key? key,
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
    required ReorderCallback onReorder,
    VoidCallback? onReorderStarted,
    Function(int)? onReorderEnded,
    double? itemExtent,
    Widget? prototypeItem,
    ReorderItemProxyDecorator? proxyDecorator,
    bool buildDefaultDragHandles = true,
    EdgeInsets? padding,
    Widget? header,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? scrollController,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double anchor = 0.0,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) : super.builder(
          key: key,
          itemCount: max(0, itemCount * 2 - 1),
          itemBuilder: (BuildContext context, int index) {
            final isSeparator = index.isOdd;
            final itemIndex = index ~/ 2;
            final Widget item;

            if (isSeparator) {
              // Separator
              item = separatorBuilder.call(context, itemIndex);
              // Ensure the separator has a unique key
              if (item.key == null) {
                return KeyedSubtree(
                  key: ValueKey('ReorderableSeparator${index}Key'),
                  child: IgnorePointer(child: item),
                );
              }
              // No drag handles for separators
              return item;
            } else {
              // Actual list item
              item = itemBuilder.call(context, itemIndex);
              // Wrap with ReorderableDragStartListener if drag handles are needed
              return buildDefaultDragHandles
                  ? KeyedSubtree(
                      key: ValueKey('ReorderableItem${index}Key'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: item),
                          buildDefaultDragHandles
                              ? ReorderableDragStartListener(
                                  index: index,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0.w),
                                    child: Icon(Icons.drag_handle),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ))
                  : item;
            }
          },
          onReorderStart: (index) {
            // Find the Separator widgets and hide them
            // Call onReorderStarted callback when the reorder starts
            onReorderStarted?.call();
          },
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            if (oldIndex % 2 == 1) {
              //separator - should never happen
              return;
            }

            if ((oldIndex - newIndex).abs() == 1) {
              //moved behind the top/bottom separator
              return;
            }

            newIndex = oldIndex > newIndex && newIndex % 2 == 1
                ? (newIndex + 1) ~/ 2
                : newIndex ~/ 2;
            oldIndex = oldIndex ~/ 2;
            onReorder.call(oldIndex, newIndex);
          },
          onReorderEnd: (index) {
            onReorderEnded?.call(index);
          },
          itemExtent: itemExtent,
          prototypeItem: prototypeItem,
          proxyDecorator: proxyDecorator,
          buildDefaultDragHandles: false,
          padding: padding,
          header: header,
          scrollDirection: scrollDirection,
          reverse: reverse,
          scrollController: scrollController,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          anchor: anchor,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
        );
}
