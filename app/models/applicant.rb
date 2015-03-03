class Applicant < ActiveRecord::Base

  strip_attributes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :ensure_authentication_token

  paperclip_opts = {
    :styles => { :thumb => '40x40#', :large => '300x300>' },
    :convert_options => { :all => '-quality 92' },
    :processor       => [ :cropper ],
    :path => Rails.env.production? ? "avatars/:id_:style_:basename.:extension" : "avatars_staging/:id_:style_:basename.:extension",
    :url => Rails.env.production? ? "avatars/:id_:style_:basename.:extension"  : "avatars_staging/:id_:style_:basename.:extension",
    :storage => :fog,
    :fog_credentials => "#{Rails.root}/config/gce.yml",
    :fog_directory=>"rentalgeek"
  }
  has_attached_file :avatar, paperclip_opts
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many  :applies,  as: :applicable, dependent: :destroy
  has_many  :transactions, dependent: :destroy
  has_many  :starred_properties, dependent: :destroy
  has_and_belongs_to_many :roommate_groups
  has_many :owned_roommate_groups, class_name: 'RoommateGroup', foreign_key: 'applicant_id', dependent: :destroy
  has_many :providers, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :property_manager, dependent: :destroy
  has_one :co_signer, dependent: :destroy

  accepts_nested_attributes_for :profile, :reject_if => :all_blank
  accepts_nested_attributes_for :property_manager, :reject_if => :all_blank

  def property_manager?
    !self.property_manager.nil?
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless Applicant.where(authentication_token: token).first
      end
  end
end
