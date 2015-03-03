class PropertyManagerSerializer < ActiveModel::Serializer

  attribute   :id

  attributes  :name,
              :customer_contact_email_address,
              :customer_contact_phone_number,
              :accepts_cash,
              :accepts_checks,
              :accepts_credit_cards_offline,
              :accepts_online_payments,
              :accepts_money_orders,
              :url
end



