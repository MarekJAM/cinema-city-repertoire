import '../models/filters/filters.dart';

abstract class FiltersStorage {
  List<RepertoireFilter> loadFilters();

  void saveFilters(List<RepertoireFilter> filters);
}