import 'package:mubicon/api.dart' show SelectionIndexResponse, TimeOfDay;
import '../../../core/app_export.dart';

class SelectionModel {
  int? selectionId;
  String? name;
  int? count;
  Duration? duration;
  TimeOfDay? timeOfDay;
  DateTime? createDate;
  List<String>? companyTypeSelections;
  List<String>? genreSelections;
  double? rating;
  String? imageFile;
  int? views;

  SelectionModel.fromNonObservable(SelectionIndexResponse response) {
    this.selectionId = response.selectionId;
    this.name = response.name ?? 'No name';
    this.count = response.count ?? 0;
    this.duration = parseDuration(response.duration ?? '00:00:00.0000000');
    this.timeOfDay = response.timeOfDay;
    this.createDate = response.createDate;
    this.companyTypeSelections = response.companyTypeSelections ?? [];
    this.genreSelections = response.genreSelections ?? [];
    this.rating = response.rating ?? 5.0;
    this.imageFile = "https://mubi.cloud/content/${response.imageFile}";
    this.views = response.views ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'selectionId': selectionId,
      'name': name,
      'count': count,
      'duration': duration?.inMilliseconds,
      'timeOfDay': timeOfDayString,
      'createDate': createDate?.toIso8601String(),
      'companyTypeSelections': companyTypeSelections,
      'genreSelections': companyTypeSelections,
      'rating': rating,
      'imageFile': imageFile,
      'views': views,
    };
  }

  String get timeOfDayString {
    switch (timeOfDay) {
      case TimeOfDay.none:
        return 'none';
      case TimeOfDay.morning:
        return 'morning';
      case TimeOfDay.day:
        return 'day';
      case TimeOfDay.evening:
        return 'evening';
      case TimeOfDay.night:
        return 'night';
      default:
        return 'none';
    }
  }
}
