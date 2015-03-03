Fonda::Application.routes.draw do

  devise_for :applicants, controllers: {:sessions => "v2/sessions", :registrations => "v2/registrations", :passwords => "v2/passwords"}, :defaults => { :format => 'json' }


  if true # Rails.env.development?
    mount RailsAdmin::Engine => '/war-room', :as => 'rails_admin'
    resources :applies, only: [:show]
  end

  get "application/set_current_applicant"
  post "application/file_upload"
  post "application/update_property_photo"
  delete "application/delete_property_photo"
  put "application/update_rental"
  put "application/uplode_property_photo"
  root 'v2/applies#home'
  get 'v2/applies/local_ip'
  get 'v2/applies/ip'

  namespace :v2, defaults: {format: 'json'} do
    namespace :landlord do
      resources :rental_offerings do
        collection do
          post :upload_csv_file
        end
      end
      resources :rental_complexes
    end

    devise_scope :applicant do
      post "sessions/add_providers", defaults: {format: 'json'}
    end

    post "rental_offerings/exportCsv"
    get "rental_offerings/exportCsv"
    resources :rental_offerings do
      get 'applicants'
    end
    resources :rental_complexes do
      collection do
        post 'create_property'
      end
    end
    resources :property_managers
    resources :applicants do
      collection do
        put 'update_password'
      end
    end
    resources :applies do
      post 'approve'
      post 'dis_approve'
      post 'deny'
      post 'send_agreement'
      collection do
        post 'right_signature_callback', defaults: {format: 'xml'}
      end
    end
    resources :providers
    resources :transactions
    resources :starred_properties do
      collection do
        post 'remove_star'
      end
    end
    resources :profiles do
      collection do
        post 'victig_callback'
      end
    end
    resources :attachments

    resources :roommate_groups do
      post 'invite_roommates'
      post 'remove_member'

      collection do
        get 'member_groups'
        post 'left_group'
        post 'apply_roommates'
      end
    end
    resources :invitations do
      post 'accept'
      post 'deny'
    end
    resources :co_signers do
      collection do
        post 'invite_cosigner'
      end
    end
    resources :co_signs
    resources :property_photos do
      collection do
        post :uplode_property_photo
        post :update_property_photo
        post :delete_property_photo
      end
    end
  end

end
