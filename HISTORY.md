## Unreleased

### Added

### Fixed

### Breaking Changes

## v0.9.1

### Added
* Add `Configuration#multi_tenant!` for opting into multi-tentant support where configuration/caching is per-thread (#556)

### Fixed
* Avoid Savon version `2.13.0` to prevent generating invalid envelopes. (#558, #563)
* Retry on `HTTPI::SSLError` and `HTTPI::TimeoutError` in backoff (#566)

### Breaking Changes
* Update default API version to 2016_2 from 2015_1 when `api_version` is not explicitly set (#554)

## 0.9.0

### Added

* Update `Customer` record fields/record refs for 2021.2. (#535)
The following were moved from `fields` to `record_refs`: `buying_reason`, `buying_time_frame`, `campaign_category`, `image`, `opening_balance_account`, `pref_cc_processor`, `representing_subsidiary`, `sales_group`, `sales_readiness`
The following were removed as `fields` since their sublist class is not yet implemented: `download_list`, `group_pricing_list`, `item_pricing_list`
* Add search-only fields to `Customer` (#535)
* Add `attach_file` action to `Customer` records (#544)
* Add `update` action to `File` records (#544)
* Expose `errors` after calls to `delete` action (#545)
* Add `update_list` action where missing on supported item records (#546)
* Ignore `after_submit_failed` status details (>= 2018.2) when collating errors in add action (#550)
* Add `NullFieldList` to `SalesOrder` (#552)
* Add thread safety to NetSuite configuration and utilities (#549)

### Breaking Changes
* Rename `CustomerSubscriptionsList` to `SubscriptionsList` and `CustomerSubscription` to `Subscription` to match NetSuite naming (#535)

## 0.8.12

### Added

* Add NullFieldList record (to credit memos and invoices) (#529)
* Add `get_deleted` action to item records (#530)
* Add `get_deleted` action to Employee records (#531)
* Remove monkey patched `lower_camelcase` method on String (#533)

## 0.8.11

### Added

* Update ServiceResaleItem record fields/record refs for 2021.2. `item_options_list`, `presentation_item_list`, `site_category_list`, `translations_list` were all removed as fields as the are not simple fields, they require special classes. (#500)
* Dependabot to CI
* CI run for Ruby 3.0 & 3.1
* Add CI run for an environment with and without `tzinfo` installed
* Update NonInventorySaleItem record fields/record refs for 2021.2. `item_options_list`, `presentation_item_list`, `product_feed_list`, `site_category_list`, `translations_list` were all removed as fields as the are not simple fields, they require special classes. (#503)
* Implement MatrixOptionList#to_record (#504)
* Update ItemVendor record fields/record refs for 2021.1. `vendor` is now a record_ref instead of a field. (#505)
* Update InventoryItem record fields/record refs for 2021.2. `member_list` was removed as a field as it doesn't belong to InventoryItem. (#506)
* Update LotNumberedInventoryItem record fields/record refs for 2021.2. (#507)
* Update NonInventoryResaleItem record fields/record refs for 2021.2. `item_options_list`, `presentation_item_list`, `product_feed_list`, `site_category_list`, `translations_list` were all removed as fields as the are not simple fields, they require special classes. (#508)
* Add `attach_file` action for Invoice and SalesOrder. (#509)
* Add ItemOptionCustomField recrd (#512)
* Add Ship Address to Return Authorization (#525)
* Support translations records (#516)

### Fixed

* Fix "undefined method `[]` for #<Nori::StringIOFile>" when adding File (#495)
* Moved definition of `search_joins` attribute from records to search action. The attribute was removed for AssemblyComponent, SerializedInventoryItemLocation, and WorkOrderItem as they don't offer the search action. (#511)
* Consider externalId in search criteria when using RecordRef as value (#517)
* Retry http client error subclasses
* Add upsert list action for cash sales (#523)

## 0.8.10

### Added

* Update Estimate record fields/record refs for 2021.2. `balance`, `bill_address`, `bill_is_residential`, and `is_multi_ship_to` were all removed as fields as either being incorrect, outdated, or a search-only field. (#496)

### Fixed

* Savon 2.12 supported

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
