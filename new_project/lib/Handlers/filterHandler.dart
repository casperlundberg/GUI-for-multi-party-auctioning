import 'package:new_project/Entities/materialAuctionListJSON.dart';
import 'package:new_project/Entities/referencetype2AuctionListJSON.dart';

import '../Entities/filtersJSON.dart';
import '../jsonUtilities.dart';

class FilterHandler {
  Function setMainState;
  Filters filters; //NOT STORED LOCALLY
  MaterialReferenceParameters materialFilter; //STORED LOCALLY
  Referencetype2ReferenceParameters referencetype2Filter; //STORED LOCALLY
  int localFilteridCounter; //STORED LOCALLY

  FilterHandler(this.setMainState) {
    filters = filtersFromJson(getFilters());
  }

  void updateFilter({MaterialReferenceParameters materialFilter, Referencetype2ReferenceParameters referencetype2Filter}) {
    if (materialFilter != null) {
      this.materialFilter = materialFilter;
    }
    if (referencetype2Filter != null) {
      this.referencetype2Filter = referencetype2Filter;
    }
    setMainState();
  }

  void deleteFilter(String referencetype) {
    if (referencetype == "material") {
      materialFilter = null;
    }
    if (referencetype == "referencetype2") {
      referencetype2Filter = null;
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
          (this.referencetype2Filter.maxVolume == null ||
              referencetype2Filter.minVolume == null ||
              referencetype2Filter.minVolume <= this.referencetype2Filter.maxVolume) &&
          (this.referencetype2Filter.minVolume == null ||
              referencetype2Filter.maxVolume == null ||
              referencetype2Filter.maxVolume >= this.referencetype2Filter.minVolume)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void retrieveFilters() {
    filters = filtersFromJson(getFilters());
  }
}
