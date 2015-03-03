class CoSignSerializer < ActiveModel::Serializer
  attributes  :id, :co_signer_id, :apply_id, :cosigning_for, :relationship, :signature_date
end
