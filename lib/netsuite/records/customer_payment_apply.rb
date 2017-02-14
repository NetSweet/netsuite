module NetSuite
  module Records
  	class CustomerPaymentApply
  		include Support::Fields
    	include Support::Records
    	include Namespaces::TranCust

  		fields :amount, :apply, :apply_date, :currency, :disc, :disc_amt, :disc_date,
  				:doc, :due, :job, :line, :ref_num, :total, :type

  		def initialize(attributes = {})
  			initialize_from_attributes_hash(attributes)
  		end

  	end
  end
end
