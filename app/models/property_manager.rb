class PropertyManager < ActiveRecord::Base

  strip_attributes

  has_many :rental_complexes, dependent: :destroy
  has_many :rental_offerings, through: :rental_complexes
  has_many :attachments, dependent: :destroy
  belongs_to :applicant

  validates :customer_contact_email_address,
              :email_format => {
                :allow_nil  => true,
                :check_mx   => true }

  validates :customer_contact_phone_number,
              :length   => {
                is: 10,
                allow_nil: true },
              :numericality => {
                :only_integer => true,
                :allow_nil => true }

  validates :accepts_checks               , :inclusion => { :in => [true, false] }
  validates :accepts_cash                 , :inclusion => { :in => [true, false] }
  validates :accepts_credit_cards_offline , :inclusion => { :in => [true, false] }
  validates :accepts_online_payments      , :inclusion => { :in => [true, false] }
  validates :accepts_money_orders         , :inclusion => { :in => [true, false] }
  validates :name, uniqueness: true 
  validates :url,
              :presence => true,
              :url      => true
end

