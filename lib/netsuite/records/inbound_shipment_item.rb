module NetSuite
  module Records
    class InboundShipmentItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields  :vendorname, :olditemid, :quantityreceived, :quantitybilled, :quantity, :inventorydetail, :inventorydetailavail,
      :binitem, :isserial, :isnumbered, :isinvdetaildirty, :inventorydetailset, :description, :purchasecontract, :previouspurchasecontract,
      :effectivitybasedon, :contractstartdate, :contractenddate, :rate, :origrate, :rateschedule, :marginal, :oqpbucket, :netamount, :options,
      :class, :landedcostcategory, :isbillable, :matchbilltoreceipt, :expectedreceiptdate, :isclosed, :createdfrom, :isopen,
      :line, :lineuniquekey, :linked, :discline, :printitems, :ingroup, :includegroupwrapper, :groupclosed, :groupsetup, :itemtype, :itemsubtype,
      :isnoninventory, :fulfillable, :id, :matrixtype, :leadtime, :linenumber, :pricefromcontract, :historyurl, :history

      field :custom_field_list,   CustomFieldList

      read_only_fields :amount

      record_refs  :customer, :department, :item, :landed_cost_category, :location

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

    end
  end
end
