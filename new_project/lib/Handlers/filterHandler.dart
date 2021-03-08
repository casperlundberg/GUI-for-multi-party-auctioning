import 'package:new_project/Entities/materialAuctionListJSON.dart';
import 'package:new_project/Entities/referencetype2AuctionListJSON.dart';

import '../Entities/filtersJSON.dart';
import '../jsonUtilities.dart';

class FilterHandler {
  Function setMainState;
  Filters filters; //NOT STORED LOCALLY
  MaterialReferenceParameters materialFilter; //STORED LOCALLY
  Referencetype2ReferenceParameters referencetype2Filter; //STORED LOCALLY
  List<MaterialReferenceParameters> inactiveMaterialFilters; //STORED LOCALLY
  List<Referencetype2ReferenceParameters> inactiveReferencetype2Filters; //STORED LOCALLY
  int localFilteridCounter; //STORED LOCALLY

  FilterHandler(this.setMainState) {
    filters = filtersFromJson(getFilters());
    inactiveMaterialFilters = [];
    inactiveReferencetype2Filters = [];
    localFilteridCounter = 1;
  }

  void updateFilters({MaterialReferenceParameters materialFilter, Referencetype2ReferenceParameters referencetype2Filter}) {
    if (materialFilter != null) {
      if (materialFilter.localid == null) {
        materialFilter.localid = localFilteridCounter;
        localFilteridCounter++;
        if (this.materialFilter == null) {
          this.materialFilter = materialFilter;
        } else {
          inactiveMaterialFilters.add(this.materialFilter);
          this.materialFilter = materialFilter;
        }
      } else {
        if (this.materialFilter.localid == materialFilter.localid) {
          this.materialFilter = materialFilter;
        } else {
          for (int i = 0; i < inactiveMaterialFilters.length; i++) {
            if (inactiveMaterialFilters[i].localid == materialFilter.localid) {
              inactiveMaterialFilters[i] = materialFilter;
              break;
            }
          }
        }
      }
    }
    if (referencetype2Filter != null) {
      if (referencetype2Filter.localid == null) {
        referencetype2Filter.localid = localFilteridCounter;
        localFilteridCounter++;
        if (this.referencetype2Filter == null) {
          this.referencetype2Filter = referencetype2Filter;
        } else {
          inactiveReferencetype2Filters.add(this.referencetype2Filter);
          this.referencetype2Filter = referencetype2Filter;
        }
      } else {
        if (this.referencetype2Filter.localid == referencetype2Filter.localid) {
          this.referencetype2Filter = referencetype2Filter;
        } else {
          for (int i = 0; i < inactiveReferencetype2Filters.length; i++) {
            if (inactiveReferencetype2Filters[i].localid == referencetype2Filter.localid) {
              inactiveReferencetype2Filters[i] = referencetype2Filter;
              break;
            }
          }
        }
      }
    }
    setMainState();
  }

  void deleteFilter({MaterialReferenceParameters materialFilter, Referencetype2ReferenceParameters referencetype2Filter}) {
    if (materialFilter != null) {
      if (this.materialFilter.localid == materialFilter.localid) {
        this.materialFilter = null;
      } else {
        for (int i = 0; i < inactiveMaterialFilters.length; i++) {
          if (inactiveMaterialFilters[i].localid == materialFilter.localid) {
            inactiveMaterialFilters.removeAt(i);
            break;
          }
        }
      }
    }
    if (referencetype2Filter != null) {
      if (this.referencetype2Filter.localid == referencetype2Filter.localid) {
        this.referencetype2Filter = null;
      } else {
        for (int i = 0; i < inactiveReferencetype2Filters.length; i++) {
          if (inactiveReferencetype2Filters[i].localid == referencetype2Filter.localid) {
            inactiveReferencetype2Filters.removeAt(i);
            break;
          }
        }
      }
    }
    setMainState();
  }

  void activateFilter({MaterialReferenceParameters materialFilter, Referencetype2ReferenceParameters referencetype2Filter}) {
    if (materialFilter != null) {
      for (int i = 0; i < inactiveMaterialFilters.length; i++) {
        if (inactiveMaterialFilters[i].localid == materialFilter.localid) {
          inactiveMaterialFilters.removeAt(i);
          break;
        }
      }
      inactiveMaterialFilters.add(this.materialFilter);
      this.materialFilter = materialFilter;
    }
    if (referencetype2Filter != null) {
      for (int i = 0; i < inactiveReferencetype2Filters.length; i++) {
        if (inactiveReferencetype2Filters[i].localid == referencetype2Filter.localid) {
          inactiveReferencetype2Filters.removeAt(i);
          break;
        }
      }
      inactiveReferencetype2Filters.add(this.referencetype2Filter);
      this.referencetype2Filter = referencetype2Filter;
    }
    setMainState();
  }

  void deactivateFilter({MaterialReferenceParameters materialFilter, Referencetype2ReferenceParameters referencetype2Filter}) {
    if (materialFilter != null) {
      inactiveMaterialFilters.add(this.materialFilter);
      this.materialFilter = null;
    }
    if (referencetype2Filter != null) {
      inactiveReferencetype2Filters.add(this.referencetype2Filter);
      this.referencetype2Filter = null;
    }
    setMainState();
  }

  bool checkFilter({MaterialReferenceParameters materialFilter, Referencetype2ReferenceParameters referencetype2Filter}) {
    if (materialFilter != null) {
      if ((this.materialFilter.additives == "any" || materialFilter.additives == "any" || materialFilter.additives == this.materialFilter.additives) &&
          (this.materialFilter.fibersType == "any" || materialFilter.fibersType == "any" || materialFilter.fibersType == this.materialFilter.fibersType) &&
          (this.materialFilter.recyclingTechnology == "any" ||
              materialFilter.recyclingTechnology == "any" ||
              materialFilter.recyclingTechnology == this.materialFilter.recyclingTechnology) &&
          (this.materialFilter.resinType == "any" || materialFilter.resinType == "any" || materialFilter.resinType == this.materialFilter.resinType) &&
          (this.materialFilter.sizing == "any" || materialFilter.sizing == "any" || materialFilter.sizing == this.materialFilter.sizing) &&
          (this.materialFilter.maxFiberLength == null ||
              materialFilter.minFiberLength == null ||
              materialFilter.minFiberLength <= this.materialFilter.maxFiberLength) &&
          (this.materialFilter.minFiberLength == null ||
              materialFilter.maxFiberLength == null ||
              materialFilter.maxFiberLength >= this.materialFilter.minFiberLength) &&
          (this.materialFilter.maxVolume == null || materialFilter.minVolume == null || materialFilter.minVolume <= this.materialFilter.maxVolume) &&
          (this.materialFilter.minVolume == null || materialFilter.maxVolume == null || materialFilter.maxVolume >= this.materialFilter.minVolume)) {
        return true;
      } else {
        return false;
      }
    }
    if (referencetype2Filter != null) {
      if ((this.referencetype2Filter.parameter1 == "any" ||
              referencetype2Filter.parameter1 == "any" ||
              referencetype2Filter.parameter1 == this.referencetype2Filter.parameter1) &&
          (this.referencetype2Filter.parameter2 == "any" ||
              referencetype2Filter.parameter2 == "any" ||
              referencetype2Filter.parameter2 == this.referencetype2Filter.parameter2) &&
          (this.materialFilter.maxVolume == null || materialFilter.minVolume == null || materialFilter.minVolume <= this.materialFilter.maxVolume) &&
          (this.materialFilter.minVolume == null || materialFilter.maxVolume == null || materialFilter.maxVolume >= this.materialFilter.minVolume)) {
        return true;
      } else {
        return false;
      }
    }
  }

  void retrieveFilters() {
    filters = filtersFromJson(getFilters());
  }
}
