import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

/// A controller class for the SearchScreenPage.
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/data/apiClient/mubicloud_api.dart';
import 'package:mubicloud/presentation/search_screen_page/models/search_screen_model.dart';
import 'package:mubicloud/presentation/tracks_screen/models/track.dart';
import 'package:mubicon/api.dart'
    show CompanyType, Genre, PlaylistGetResponse, TrackPlayListDTO;

import '../../../core/services/auido_handler.dart';
import '../../../core/utils/global_audio_handler.dart';
import '../../playlist_screen/models/playlist_model.dart';
import '../../tracks_screen/filters/search_filter.dart';
import '../models/search_screen_item_model.dart';

///
/// This class manages the state of the SearchScreenPage, including the
/// current searchScreenModelObj
class SearchScreenController extends GetxController {
  final MubicloudApi _mubicloudApi = MubicloudApi();
  TextEditingController searchController = TextEditingController();
  List<SearchScreenItemModel> searchData =
      SearchScreenModel.searchScreenItemList();
  bool searching = false;
  bool edit = false;

  final Rx<PlaylistModel?> playlistModel = Rx(null);
  final Rx<MediaItem?> currentItem = Rx<MediaItem?>(null);
  final RxBool isPlaying = false.obs;
  late StreamSubscription<MediaItem?> mediaStreamSubscription;
  late StreamSubscription<QueueState> queueStateSubscription;

  var genres = <Genre>[].obs;
  var selectedGenres = <Genre>[].obs;

  var companyTypes = <CompanyType>[].obs;
  var selectedCompanyTypes = <CompanyType>[].obs;

  var isGenresExpanded = false.obs;
  var isCompanyTypesExpanded = false.obs;

  var isLoadingPlaylist = true.obs;
  var isLoadingGenres = false.obs;
  var isLoadingCompanyTypes = false.obs;

  final List<String> sortingOptions = [
    'sort_Rating'.tr,
    'sort_CreateDate'.tr,
    'sort_Duration'.tr
  ];
  RxString selectedSortingOption = 'sort_Rating'.tr.obs;

  @override
  void onInit() {
    super.onInit();
    mediaStreamSubscription =
        GlobalAudioHandler.instance.mediaItem.listen((value) {
      currentItem.value = value;
      update();
    });

    queueStateSubscription =
        GlobalAudioHandler.instance.queueState.listen((state) {
      isPlaying.value = state.isPlaying;
      update();
    });
    _loadGenreAndCompanyTypeData();
    loadPlaylist();
  }

  SearchFilter searchParameters() {
    return SearchFilter(
        genreIds: this.selectedGenres.isNotEmpty
            ? this.selectedGenres.map((element) => element.genreId!).toList()
            : null,
        companyTypeIds: this.selectedCompanyTypes.isNotEmpty
            ? this
                .selectedCompanyTypes
                .map((element) => element.companyTypeId!)
                .toList()
            : null,
        sort: _sortOption);
  }

  String? get _sortOption {
    if (selectedSortingOption.value == 'sort_Rating'.tr) {
      return 'Rating~desc';
    } else if (selectedSortingOption.value == 'sort_CreateDate'.tr.tr) {
      return 'CreateDate~asc';
    } else {
      return 'Duration~asc';
    }
  }

  bool isShowAddToPlaylist(int? id) {
    if (playlistModel.value == null) {
      return true;
    }

    return playlistModel.value!.tracksList.value
            .firstWhereOrNull((e) => e.id == id) ==
        null;
  }

  Future<void> addTrackToPlaylist(int id) async {
    if (playlistModel.value == null) return;

    final trackPlaylists = playlistModel.value!.tracksList.value
        .map((e) => TrackPlayListDTO(trackId: e.id, active: true))
        .toList();

    trackPlaylists.add(TrackPlayListDTO(trackId: id, active: true));

    await _mubicloudApi.updatePlaylist(
        id: playlistModel.value!.id!,
        name: playlistModel.value!.title.value,
        timeOfDay: playlistModel.value!.timeOfDay.value,
        trackPlaylists: trackPlaylists);

    loadPlaylist();
    update();
  }

  Future<void> deleteTrackToPlaylist(int id) async {
    if (playlistModel.value == null) return;

    final trackPlaylists = playlistModel.value!.tracksList.value
        .map((e) => TrackPlayListDTO(trackId: e.id, active: true))
        .toList();

    trackPlaylists.remove(TrackPlayListDTO(trackId: id, active: true));

    await _mubicloudApi.updatePlaylist(
        id: playlistModel.value!.id!,
        name: playlistModel.value!.title.value,
        timeOfDay: playlistModel.value!.timeOfDay.value,
        trackPlaylists: trackPlaylists);

    loadPlaylist();
    update();
  }

  Future<void> loadPlaylist() async {
    isLoadingPlaylist.value = true;
    var playlistId = PrefUtils().getPlaylistId();

    if (playlistId == null) {
      playlistModel.value = null;
      isLoadingPlaylist.value = false;
      return;
    }

    final PlaylistGetResponse? playlist =
        await _mubicloudApi.playlist(playlistId);

    if (playlist != null) {
      playlistModel.value = PlaylistModel.fromNonObservable(playlist);
    }

    isLoadingPlaylist.value = false;
    update();
  }

  void _loadGenreAndCompanyTypeData() async {
    isLoadingGenres.value = true;
    isLoadingCompanyTypes.value = true;

    var fetchedGenres = await MubicloudApi().genres();
    if (fetchedGenres != null) {
      genres.value = fetchedGenres;
    }

    var fetchedCompanyTypes = await MubicloudApi().companyTypes();
    if (fetchedCompanyTypes != null) {
      companyTypes.value = fetchedCompanyTypes;
    }

    isLoadingGenres.value = false;
    isLoadingCompanyTypes.value = false;
  }

  @override
  void dispose() {
    mediaStreamSubscription.cancel();
    queueStateSubscription.cancel();
    super.dispose();
  }

  void doUpdate() {
    update();
  }

  bool isCurrentTrack(int trackId) {
    if (currentItem.value == null) return false;

    return currentItem.value!.extras?['id'].toString() == trackId.toString();
  }

  Future<void> play(Track track) async {
    await GlobalAudioHandler.instance
        .setRepeatMode(AudioServiceRepeatMode.none);
    await GlobalAudioHandler.instance.playSingleMediaItem(track.toMediaItem());
  }

  addData(data) {
    searchData.add(SearchScreenItemModel(data));
    update();
  }

  void removedata(int index) {
    searchData.removeAt(index);
    update();
  }

  void setSearching(val) {
    searching = val;
    update();
  }

  void resetController() {
    setSearching(false);
    edit = false;
    selectedGenres.clear();
    selectedCompanyTypes.clear();
    isGenresExpanded.value = false;
    isCompanyTypesExpanded.value = false;
    isLoadingGenres.value = false;
    isLoadingCompanyTypes.value = false;
    selectedSortingOption.value = 'sort_Rating'.tr;
    isLoadingPlaylist.value = true;
    isLoadingPlaylist.value = false;
    loadPlaylist();
    update();
  }
}
