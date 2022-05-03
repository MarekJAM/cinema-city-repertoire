import 'repositories.dart';
import '../models/filters/filters.dart';

class FiltersRepository {
  final FiltersStorage storage;

  const FiltersRepository(this.storage);

  List<RepertoireFilter> loadFilters() {
    return storage.loadFilters();
  }

  Future<void> saveFilters(List<RepertoireFilter> filters) async {
    storage.saveFilters(filters);
  }
}