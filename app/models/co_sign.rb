class CoSign < ActiveRecord::Base
  belongs_to :co_signer
  belongs_to :apply
end
