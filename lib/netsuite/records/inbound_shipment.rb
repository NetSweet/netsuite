module NetSuite
  module Records
    class InboundShipment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :upsert_list, :search

      fields :_eml_nkey_, :_multibtnstate_, :selectedtab, :nsapiPI, :nsapiSR, :nsapiVF, :nsapiFC, :nsapiPS, :nsapiVI, :nsapiVD, :nsapiPD, :nsapiVL,
      :nsapiRC, :nsapiLI, :nsapiLC, :nsapiCT, :nsbrowserenv, :wfPI, :wfSR, :wfVF, :wfFC, :wfPS, :type, :whence, :customwhence,
      :entryformquerystring, :rejected, :wfinstances, :dbstrantype, :bulk, :createddate, :lastmodifieddate, :version, :voided, :cleared, :cleareddate,
      :linked, :linkedrevrecje, :linkedclosedperioddiscounts, :entityname, :trantypepermcheck, :ebaylistingnum, :ebaydocnum, :ntype, :nluser, :nlrole,
      :nldept, :nlloc, :nlsub, :baserecordtype, :nlapiCC, :nexus, :warnnexuschange, :nexus_country, :entitynexus, :extraurlparams, :taxamountoverride,
      :taxamount2override, :companyid, :partnerid, :source, :synceventfield, :originator, :website, :oldrevenuecommitment, :entityfieldname, :updatecurrency,
      :currencyname, :currencysymbol, :currencyprecision, :isbasecurrency, :exchangerate, :origexchangerate, :origcurrency, :edition, :tobeprinted, :tobeemailed,
      :email, :tobefaxed, :fax, :message, :billaddress, :terms, :incoterm, :billattention, :billaddressee, :billphone, :billaddr1, :billaddr2, :billaddr3, :billcity,
      :billstate, :billzip, :billcountry, :billoverride, :billingaddress_key, :billingaddress, :billisresidential, :shipisresidential, :shipattention, :shipaddressee,
      :shipphone, :shipaddr1, :shipaddr2, :shipaddr3, :shipcity, :shipstate, :shipzip, :shipcountry, :shipoverride, :shippingaddress_key, :shippingaddress, :recordcreatedby,
      :recordcreateddate, :prevdate, :balance, :unbilledorders, :creditlimit_origtotal, :weekendpreference, :persistedterms, :duedays, :mindays, :datedriven, :discdays,
      :discpct, :otherrefnum, :entity, :purchasecontract, :employee, :supervisorapproval, :createdfrom, :shipdate, :duedate, :trandate, :tranid,
      :memo, :transactionnumber, :availablevendorcredit, :subsidiary, :department, :class, :location, :currency, :origtotal2, :origtotal, :balreadyrefunded,
      :emailaddr, :inventorydetailuitype, :expacct, :expacctname, :shipmethod, :fob, :trackingnumbers, :linkedtrackingnumbers, :returntrackingnumbers,
      :shipto, :shipaddress, :specord, :orderstatus, :status, :statusRef, :ordrecvd, :ordpartrecvd, :ordbilled, :dropshipso, :transhippinggroup, :needsshiprecv, :needsbill,
      :bulktype, :effectivitybasedon, :contractstartdate, :contractenddate, :department_hidden, :class_hidden, :location_hidden, :workflowbuttonclicked, :workflowbuttons

      field :item_list,                   InboundShipmentItemList
      field :custom_field_list,           CustomFieldList

      read_only_fields :total, :unapplied

      record_refs :custom_form

      attr_reader :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
