import '../Entities/filtersJSON.dart';
import '../jsonUtilities.dart';

class FilterHandler {
  Filters filters;
  List<Filter> availableFilters;
  List<Filter> activeFilters;
  List<Filter> inactiveFilters;
  int localFilteridCounter;

  FilterHandler(this.filters, this.availableFilters, this.activeFilters, this.inactiveFilters, this.localFilteridCounter);

  void updateFilters(Filter filter) {
    if (filter.localid == null) {
      filter.localid = localFilteridCounter++;
    }
    for (int i = 0; i < inactiveFilters.length; i++) {
      if (inactiveFilters[i].localid == filter.localid) {
        inactiveFilters[i] = filter;
        return;
      }
    }
    for (int i = 0; i < activeFilters.length; i++) {
      if (activeFilters[i].localid == filter.localid) {
        activeFilters[i] = filter;
        return;
      }
      if (activeFilters[i].id == filter.id) {
        inactiveFilters.add(activeFilters[i]);
        activeFilters.removeAt(i);
        break;
      }
    }
    activeFilters.add(filter);
  }

  void deleteFilter(Filter filter) {
    for (int i = 0; i < activeFilters.length; i++) {
      if (activeFilters[i].localid == filter.localid) {
        for (int y = 0; y < inactiveFilters.length; y++) {
          if (inactiveFilters[y].id == activeFilters[i].id) {
            activeFilters.add(inactiveFilters[y]);
            inactiveFilters.removeAt(y);
            break;
          }
        }
        activeFilters.removeAt(i);
        return;
      }
    }
    for (int i = 0; i < inactiveFilters.length; i++) {
      if (inactiveFilters[i].localid == filter.localid) {
        inactiveFilters.removeAt(i);
        return;
      }
    }
  }

  void activateFilter(Filter filter) {
    for (int i = 0; i < activeFilters.length; i++) {
      if (activeFilters[i].id == filter.id) {
        inactiveFilters.add(activeFilters[i]);
        activeFilters.removeAt(i);
        break;
      }
    }
    activeFilters.add(filter);
    for (int i = 0; i < inactiveFilters.length; i++) {
      if (inactiveFilters[i].localid == filter.localid) {
        inactiveFilters.removeAt(i);
        return;
      }
    }
  }

  void deactivateFilter(Filter filter) {
    for (int i = 0; i < activeFilters.length; i++) {
      if (activeFilters[i].localid == filter.localid) {
        inactiveFilters.add(activeFilters[i]);
        activeFilters.removeAt(i);
        return;
      }
    }
  }

  void retrieveFilters() {
    filters = filtersFromJson(getFilterListString());
    availableFilters = filters.filters;
  }
}
