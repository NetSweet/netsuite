## Unreleased

### Added

* Update Estimate record fields/record refs for 2021.2. `balance`, `bill_address`, `bill_is_residential`, and `is_multi_ship_to` were all removed as fields as either being incorrect, outdated, or a search-only field. (#496)
*

### Fixed

*
*

## 0.8.9

### Fixed

* Fixed issue where search only fields could be specified when an existing field exists. https://github.com/NetSweet/netsuite/pull/488

## 0.8.8

### Added

* Adding serialized assembly item to get_item
* Add CostCategory record (#482)
* Introduce search only fields (#483)

### Fixed

* Fix accessing custom field values returned in advanced search results (#480)
* Fixing bug where single-selection custom multi select fields would incorrectly be parsed 3377c971d0cb727d81f4b4bc6e30edfbdfaccfd1
* Fixed some field definitions on serialized assembly item
* Properly extract external_id from advanced search results (#478)
