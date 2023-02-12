import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/models.dart';
import 'filters_storage.dart';

@Injectable(as: FiltersStorage)
class FiltersStorageHive implements FiltersStorage {
  final Box<dynamic> box;

  FiltersStorageHive(@Named('filtersBox') this.box);

  @override
  List<RepertoireFilter> loadFilters() {
    final filters = box.get('filters', defaultValue: [
      GenreFilter([...genreMap.values, noGenresData]),
      EventTypeFilter(allEventTypes),
      ScoreFilter(0, true),
    ]);
    return [...filters];
  }

  @override
  Future<void> saveFilters(List<RepertoireFilter> filters) async {
    await box.put('filters', filters);
  }
}
