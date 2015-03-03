class ProviderSerializer < ActiveModel::Serializer
  attributes  :id, :provider, :email, :name, :connected
end