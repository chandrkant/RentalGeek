class TransactionSerializer < ActiveModel::Serializer

  attributes  :id, :transaction_id,:applicant_id,:created_at,:amount, :card_type,:cardholder_name,:purchased_type
 
end

  
 
  
  
  
 