import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/utils/pref_utils.dart' as pu;

import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

import 'package:mubicloud/core/utils/progress_dialog_utils.dart';
import 'package:mubicloud/presentation/playlist_screen/controller/playlist_controller.dart';
import 'package:mubicloud/widgets/app_bar/custum_bottom_bar_controller.dart';
import 'package:mubicloud/widgets/custom_bottom_nav_bar.dart';

import '../../core/expantiontile/src/types/expansion_tile_border_item.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/custom_top_bar.dart';
import '../my_libary_playlist_page/controller/my_libary_playlist_controller.dart';
import '../tracks_screen/controller/tracks_controller.dart';
import '../tracks_screen/models/track.dart';
import '../tracks_screen/widgets/tracks_item_widget.dart';
import 'controller/search_screen_controller.dart';

class SearchScreenPage extends StatefulWidget {
  const SearchScreenPage({super.key});

  @override
  State<SearchScreenPage> createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreenPage> {
  final SearchScreenController searchScreenController =
      Get.find<SearchScreenController>();
  final TracksController trackListController = Get.find<TracksController>();
  final MyLibaryPlaylistController playlistsController =
      Get.find<MyLibaryPlaylistController>();
  final ScrollController _playlistsScrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();
  final CustomBottomBarController _bottomController =
      Get.find<CustomBottomBarController>();
  PlaylistController playlistController = Get.find<PlaylistController>();

  late GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    //if (_scrollController.offset < -50 &&
    //    !trackListController.isLoading.value) {
    //  _handleRefresh();
    //}

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !trackListController.isLoading.value) {
      trackListController.fetchTracks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SearchScreenController>(
        init: searchScreenController,
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => buildAppBar(searchScreenController),
            ),
            searchScreenController.searching
                ? _buildSearchForm()
                : _buildTracks(),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    trackListController.refresh();
    playlistsController.load();
    searchScreenController.loadPlaylist();
  }

  Widget _buildTracks() {
    return Obx(
      () {
        List<Widget> rows = [];
        int tracksCountInRow =
            PrefUtils.getDeviceType() == pu.DeviceType.Tablet ? 3 : 2;
        for (var row = 0;
            row < trackListController.tracks.length ~/ tracksCountInRow;
            row++) {
          List<Widget> tracksInRow = [];
          for (var column = 0; column < tracksCountInRow; column++) {
            Track model =
                trackListController.tracks[row * tracksCountInRow + column];
            tracksInRow.add(
              Expanded(
                child: Padding(
                  padding: getPadding(
                    right: column == 1
                        ? (tracksCountInRow == 3 ? 4 : 0)
                        : column == 0
                            ? 8
                            : 0,
                    left: column == 1
                        ? (tracksCountInRow == 3 ? 4 : 8)
                        : column == 2
                            ? 8
                            : 0,
                  ),
                  child: TracksItemWidget(model,
                      tracksCountInRow: tracksCountInRow, onTapAdd: () async {
                    if (playlistsController.myPlayList.length != 0) {
                      await searchScreenController.addTrackToPlaylist(model.id);
                      playlistsController.load();
                      playlistController.load();
                    } else {
                      Get.toNamed(AppRoutes.addPlaylistScreen);
                    }
                  }, onTap: () {
                    searchScreenController.play(model);
                  }, onTapDelete: () async {
                    await searchScreenController
                        .deleteTrackToPlaylist(model.id);
                    playlistsController.load();
                    playlistController.load();
                  },
                      showAddToPlaylist:
                          searchScreenController.isShowAddToPlaylist(model.id),
                      playing: searchScreenController.isPlaying.isTrue,
                      currentTrackId: searchScreenController
                          .currentItem.value?.extras?['id']),
                ),
              ),
            );
          }
          rows.add(
            Column(
              children: [
                Row(
                  children: tracksInRow,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: getPadding(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10.w,
                ),
                Expanded(
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: () async => _handleRefresh(),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      shrinkWrap: false,
                      children: rows,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchForm() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          Expanded(
            child: ListView(
              padding: getPadding(left: 20, right: 20, bottom: 24),
              children: [
                Obx(() => _buildExpansionTileBorderItem(
                      title: "lbl_genres".tr,
                      content: _buildGenreTags(searchScreenController),
                      isLoading: searchScreenController.isLoadingGenres.value,
                    )),
                SizedBox(height: getVerticalSize(16)),
                Obx(() => _buildExpansionTileBorderItem(
                      title: "lbl_company_types".tr,
                      content: _buildCompanyTypeTags(searchScreenController),
                      isLoading:
                          searchScreenController.isLoadingCompanyTypes.value,
                    )),
                SizedBox(height: getVerticalSize(16)),
                Obx(() => _buildSortDropdown()),
                SizedBox(height: getVerticalSize(16)),
                //CustomElevatedButton(
                //    text: "lbl_search".tr,
                //    margin: getMargin(bottom: 32),
                //    buttonStyle: ButtonThemeHelper.fillDeeppurpleA200.copyWith(
                //        fixedSize: MaterialStateProperty.all<Size>(
                //            Size(double.maxFinite, getVerticalSize(60)))),
                //    buttonTextStyle: TextThemeHelper.titleMediumPrimary_1,
                //    onTap: () {
                //      trackListController.updateSearchParameters(
                //          filter: searchScreenController.searchParameters());
                //      searchScreenController.setSearching(false);
                //    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTileBorderItem(
      {required String title,
      required Widget content,
      bool isLoading = false,
      bool isExpanded = false}) {
    return ExpansionTileBorderItem(
      themeData: ThemeData(splashColor: Colors.transparent),
      iconColor: UIConstants().textColor,
      childrenPadding: getPadding(left: 20, right: 20, top: 0, bottom: 18),
      borderRadius: BorderRadius.circular(16.r),
      decoration: AppDecoration.fill2
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: UIConstants()
                  .textStyleMediumBold
                  .copyWith(color: UIConstants().textColor),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
      expendedBorderColor: Colors.blue,
      initiallyExpanded: isExpanded,
      children:
          isLoading ? [Center(child: CircularProgressIndicator())] : [content],
    );
  }

  Widget _buildGenreTags(SearchScreenController controller) {
    return Padding(
      padding: getPadding(top: 2),
      child: Wrap(
        spacing: 8.0.w,
        runSpacing: 8.0.w,
        children: controller.genres.map((genre) {
          bool isSelected = controller.selectedGenres.contains(genre);
          return GestureDetector(
            onTap: () {
              controller.selectedGenres.contains(genre)
                  ? controller.selectedGenres.remove(genre)
                  : controller.selectedGenres.add(genre);
              controller.update();
              search();
            },
            child: Container(
              padding: getPadding(top: 4, bottom: 4, left: 12, right: 12),
              decoration: AppDecoration.fill2.copyWith(
                borderRadius: BorderRadius.circular(
                  24.r,
                ),
                color: isSelected
                    ? appTheme.deepPurpleA200
                    : UIConstants().bgColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Text(
                  genre.name,
                  overflow: TextOverflow.ellipsis,
                  style: UIConstants().textStyleVerySmall.copyWith(
                      color: isSelected
                          ? UIConstants().textDarkMode
                          : UIConstants().textColor,
                      fontSize: 14.sp),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCompanyTypeTags(SearchScreenController controller) {
    return Padding(
      padding: getPadding(top: 2),
      child: Wrap(
        spacing: 8.0.w,
        runSpacing: 8.0.w,
        children: controller.companyTypes.map((type) {
          bool isSelected = controller.selectedCompanyTypes.contains(type);
          return GestureDetector(
            onTap: () {
              controller.selectedCompanyTypes.contains(type)
                  ? controller.selectedCompanyTypes.remove(type)
                  : controller.selectedCompanyTypes.add(type);
              controller.update();
              search();
            },
            child: Container(
              padding: getPadding(top: 4, bottom: 4, left: 12, right: 12),
              decoration: AppDecoration.fill2.copyWith(
                borderRadius: BorderRadius.circular(
                  24.r,
                ),
                color: isSelected
                    ? appTheme.deepPurpleA200
                    : UIConstants().bgColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Text(
                  type.name,
                  overflow: TextOverflow.ellipsis,
                  style: UIConstants().textStyleVerySmall.copyWith(
                      color: isSelected
                          ? UIConstants().textDarkMode
                          : UIConstants().textColor,
                      fontSize: 14.sp),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final double headerHeight = MediaQuery.of(context).padding.top +
        kToolbarHeight.h +
        (Scaffold.of(context).appBarMaxHeight ?? 0) +
        9.h;
    final double menuMarginHorizontal = 20.0.w;

    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                overlayEntry?.remove();
                overlayEntry = null;
              },
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            top: headerHeight,
            left: menuMarginHorizontal,
            right: menuMarginHorizontal,
            child: Container(
              height: 150.h,
              decoration: AppDecoration.fill2.copyWith(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.3),
                    spreadRadius: 0.5.r,
                    blurRadius: 1.r,
                    offset: Offset(0.h, 1.w),
                  ),
                ],
              ),
              child: Container(
                padding: getPadding(left: 25, right: 25, bottom: 15),
                margin: getMargin(top: 15),
                child: RawScrollbar(
                  padding: EdgeInsets.zero,
                  controller: _playlistsScrollController,
                  crossAxisMargin: -3.w,
                  thumbVisibility: true,
                  thumbColor: UIConstants().primaryColor,
                  radius: Radius.circular(24.r),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    controller: _playlistsScrollController,
                    children: [
                      Wrap(
                        spacing: 8.0.w,
                        runSpacing: 8.0.w,
                        children: playlistsController.myPlayList
                            .map(
                              (value) => GestureDetector(
                                onTap: () async {
                                  await PrefUtils.setPlaylistId(value.id!);
                                  playlistController.load();
                                  searchScreenController.loadPlaylist();
                                  overlayEntry?.remove();
                                  overlayEntry = null;
                                },
                                child: Container(
                                  padding: getPadding(
                                      top: 4, bottom: 4, left: 12, right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      30.r,
                                    ),
                                    //boxShadow: [
                                    //  BoxShadow(
                                    //    color: Theme.of(context)
                                    //        .colorScheme
                                    //        .background
                                    //        .withOpacity(0.5),
                                    //    spreadRadius: 1,
                                    //    blurRadius: 1,
                                    //    offset: Offset(0, 1),
                                    //  ),
                                    //],
                                    color: UIConstants().bgColor,
                                    //border: Border.all(
                                    //  color: Theme.of(context)
                                    //      .colorScheme
                                    //      .background
                                    //      .withAlpha(70),
                                    //  width: 1,
                                    //),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      value.title.value,
                                      overflow: TextOverflow.ellipsis,
                                      style: UIConstants()
                                          .textStyleSmall
                                          .copyWith(
                                              color: UIConstants().textColor),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (overlayEntry != null) {
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  Widget _buildPlaylistDropdownTrigger(BuildContext context) {
    final playlistId = PrefUtils().getPlaylistId();
    String? currentValue;

    if (playlistsController.isLoading.value ||
        searchScreenController.isLoadingPlaylist.value ||
        trackListController.isLoading.value) {
      return ProgressBarUtils.showProgressBar(context);
    } else {
      currentValue = playlistsController.myPlayList
              .firstWhereOrNull((element) => element.id == playlistId)
              ?.title
              .value ??
          playlistsController.myPlayList.first.title.value;
    }

    return Container(
      padding: getPadding(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: playlistsController.isLoading.value
          ? ProgressBarUtils.showProgressBar(context)
          : Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: getPadding(right: 20),
                              child: Text(
                                "lbl_add_in".tr,
                                style: UIConstants()
                                    .textStyleSmall
                                    .copyWith(color: UIConstants().textColor),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () =>
                                    playlistsController.myPlayList.length > 1
                                        ? _showDropdownMenu(context)
                                        : null,
                                child: Container(
                                  decoration: AppDecoration.fill2.copyWith(
                                    borderRadius: BorderRadius.circular(
                                      30.r,
                                    ),
                                  ),
                                  padding: getPadding(
                                      top: 4, bottom: 4, left: 20, right: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          currentValue,
                                          style: UIConstants()
                                              .textStyleVerySmall
                                              .copyWith(
                                                color: UIConstants().textColor,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        color: playlistsController
                                                    .myPlayList.length >
                                                1
                                            ? UIConstants().textColor
                                            : Colors.transparent,
                                        size: 24.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: getPadding(left: 20, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Text(
            "prefix_sort".tr,
            style: theme.textTheme.titleMedium?.copyWith(
              color: appTheme.deepPurpleA200,
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: searchScreenController.selectedSortingOption.value,
                icon: Icon(
                  Icons.expand_more,
                  color: UIConstants().textColor,
                  size: 25.w,
                ),
                padding: getPadding(
                  right: 20,
                ),
                elevation: 1,
                style: UIConstants()
                    .textStyleMedium
                    .copyWith(color: UIConstants().textColor),
                dropdownColor: appTheme.gray100,
                borderRadius: BorderRadius.circular(16.r),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    searchScreenController.selectedSortingOption.value =
                        newValue;
                    search();
                  }
                },
                items: searchScreenController.sortingOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: appTheme.gray100,
                      ),
                      child: Text(
                        value,
                        style: UIConstants()
                            .textStyleSmallBold
                            .copyWith(color: UIConstants().textColor),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(SearchScreenController controller) {
    if (playlistsController.myPlayList.length == 0) {
      return CustomTopBar(
        titleWidget: Text(
          overflow: TextOverflow.ellipsis,
          "lbl_tracks".tr,
          style: UIConstants().textStyleMedium.copyWith(
              color: UIConstants().textColor, fontWeight: FontWeight.w700),
        ),
        icon: AppbarImage(
          //height: (MediaQuery.of(context).padding.top * 1.5).w,
          width: AppBar().preferredSize.height * 0.8.h,
          imagePath: PrefUtils().getThemeData() == "primary"
              ? ImageConstant.imageTracksLight
              : ImageConstant.imageTracksDark,
          margin: getMargin(left: 25),
        ),
        actions: [
          AppbarImage(
            onTap: () {
              controller.setSearching(!controller.searching);
            },
            height: getHorizontalSize(24),
            width: getHorizontalSize(24),
            iconWidget: Icon(
              Icons.sort,
              size: getHorizontalSize(24),
              color: searchScreenController.selectedCompanyTypes.isNotEmpty ||
                      searchScreenController.selectedGenres.isNotEmpty ||
                      searchScreenController.selectedSortingOption.value !=
                          'sort_Rating'.tr
                  ? UIConstants().primaryColor
                  : UIConstants().textColor,
            ),
            margin: getMargin(
              left: 20,
              right: 20,
            ),
          ),
        ],
      );
    } else {
      return CustomTopBar(
        titleWidget: _buildPlaylistDropdownTrigger(context),
        icon: !searchScreenController.searching
            ? AppbarImage(
                onTap: () {
                  if (PrefUtils().getPlaylistId() != null) {
                    _bottomController.goToTab(
                      BottomBarTab.playlists,
                      route: AppRoutes.playlistScreen,
                      cb: (id, route) {
                        Get.toNamed(
                          route,
                          id: id,
                          arguments: {
                            'playlistId': PrefUtils().getPlaylistId()
                          },
                        );
                      },
                    );
                  } else {
                    _bottomController.goToTab(BottomBarTab.playlists);
                  }
                },
                height: getHorizontalSize(24),
                width: getHorizontalSize(24),
                svgPath: PrefUtils().getThemeData() == "primary"
                    ? ImageConstant.imgArrowleft
                    : ImageConstant.imgArrowleftWhite,
                margin: getMargin(left: 20),
              )
            : Container(
                color: Colors.amber,
                margin: getMargin(left: 20),
              ),
        actions: [
          AppbarImage(
            onTap: () {
              controller.setSearching(!controller.searching);
            },
            height: getHorizontalSize(24),
            width: getHorizontalSize(24),
            iconWidget: Icon(
              Icons.sort,
              size: getHorizontalSize(24),
              color: searchScreenController.selectedCompanyTypes.isNotEmpty ||
                      searchScreenController.selectedGenres.isNotEmpty ||
                      searchScreenController.selectedSortingOption.value !=
                          'sort_Rating'.tr
                  ? UIConstants().primaryColor
                  : UIConstants().textColor,
            ),
            margin: getMargin(
              left: 20,
              right: 20,
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _playlistsScrollController.dispose();
    super.dispose();
  }

  void search() {
    trackListController.updateSearchParameters(
        filter: searchScreenController.searchParameters());
  }
}
