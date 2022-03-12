import 'package:hive/hive.dart';

import '../models/filters/repertoire_filter.dart';
import 'filters_storage.dart';

class FiltersStorageHive implements FiltersStorage {
  final Box<dynamic> box;

  FiltersStorageHive(this.box);
  
  @override
  List<RepertoireFilter> loadFilters() {
    final filters = box.get('filters') ?? [];
    return [...filters];
  }

  @override
  Future<void> saveFilters(List<RepertoireFilter> filters) async {
    await box.put('filters', filters);
  }
}