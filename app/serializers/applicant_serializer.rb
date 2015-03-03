class ApplicantSerializer < ActiveModel::Serializer

  attribute   :id

  attributes  :full_name,
              :first_name,
              :last_name,
              :email,
              :authentication_token,
              # :avatar,
              :google,
              :facebook,
              :linkedin,
              :payment
  has_many :providers, embed: :ids, include: true
  has_one  :profile, embed: :ids, include: true
  has_one  :property_manager, embed: :ids, include: true
  has_one  :co_signer, embed: :ids, include: true

private

  def full_name
	object.decorate.full_name
  end

  def avatar
    return object.avatar.url(:large)     unless object.avatar.url(:large)=="/avatars/large/missing.png"
    return object.facebook_image         unless object.facebook_image.blank?
    return object.google_image           unless object.google_image.blank?
  end

  def google
    return object.providers.find_by_provider('google').connected ? true : false unless object.providers.find_by_provider('google').blank?
  end
  def facebook
    return object.providers.find_by_provider('facebook').connected ? true : false unless object.providers.find_by_provider('facebook').blank?
  end

  def linkedin
    return object.providers.find_by_provider('linkedin').connected ? true : false  unless object.providers.find_by_provider('linkedin').blank?
  end

end



