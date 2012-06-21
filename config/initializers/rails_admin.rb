# RailsAdmin config file. Generated on June 20, 2012 19:29
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.authorize_with :cancan

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Flash Volunteer', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Event, Neighborhood, Notification, Org, Participation, Privacy, Prop, Role, Skill, User, UserNotification]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Event, Neighborhood, Notification, Org, Participation, Privacy, Prop, Role, Skill, User, UserNotification]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Event do
  #   # Found associations:
  #     configure :neighborhood, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :participations, :has_many_association 
  #     configure :participants, :has_many_association 
  #     configure :skills, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :created, :date 
  #     configure :start, :datetime 
  #     configure :end, :datetime 
  #     configure :neighborhood_id, :integer         # Hidden 
  #     configure :creator_id, :integer         # Hidden 
  #     configure :User_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :street, :string 
  #     configure :city, :string 
  #     configure :zip, :integer 
  #     configure :latitude, :float 
  #     configure :longitude, :float 
  #     configure :state, :string 
  #     configure :website, :string 
  #     configure :special_instructions, :text 
  #     configure :twitter_hashtags, :string 
  #     configure :hosted_by, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Neighborhood do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :latitude, :float 
  #     configure :longitude, :float 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Notification do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :description, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Org do
  #   # Found associations:
  #     configure :neighborhood, :belongs_to_association 
  #     configure :followers, :has_and_belongs_to_many_association 
  #     configure :roles, :has_and_belongs_to_many_association 
  #     configure :skills, :has_and_belongs_to_many_association 
  #     configure :admin_of, :has_and_belongs_to_many_association 
  #     configure :participations, :has_many_association 
  #     configure :events_participated, :has_many_association 
  #     configure :user_notifications, :has_many_association 
  #     configure :notification_preferences, :has_many_association 
  #     configure :admins, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :username, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :confirmation_token, :string 
  #     configure :confirmed_at, :datetime 
  #     configure :confirmation_sent_at, :datetime 
  #     configure :unconfirmed_email, :string 
  #     configure :name, :string 
  #     configure :avatar_file_name, :string         # Hidden 
  #     configure :avatar_content_type, :string         # Hidden 
  #     configure :avatar_file_size, :integer         # Hidden 
  #     configure :avatar_updated_at, :datetime         # Hidden 
  #     configure :avatar, :paperclip 
  #     configure :neighborhood_id, :integer         # Hidden 
  #     configure :birthday, :date 
  #     configure :org_id, :integer         # Hidden 
  #     configure :type, :string 
  #     configure :mission, :string 
  #     configure :vision, :string 
  #     configure :description, :text 
  #     configure :website, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Participation do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :event, :belongs_to_association   #   # Found columns:
  #     configure :user_id, :integer         # Hidden 
  #     configure :event_id, :integer         # Hidden 
  #     configure :hours_volunteered, :integer 
  #     configure :id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Privacy do
  #   # Found associations:
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :upcoming_events, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Prop do
  #   # Found associations:
  #     configure :giver, :belongs_to_association 
  #     configure :receiver, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :giver_id, :integer         # Hidden 
  #     configure :receiver_id, :integer         # Hidden 
  #     configure :message, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Role do
  #   # Found associations:
  #     configure :users, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Skill do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :offset, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :neighborhood, :belongs_to_association 
  #     configure :roles, :has_and_belongs_to_many_association 
  #     configure :skills, :has_and_belongs_to_many_association 
  #     configure :admin_of, :has_and_belongs_to_many_association 
  #     configure :followers, :has_and_belongs_to_many_association 
  #     configure :participations, :has_many_association 
  #     configure :events_participated, :has_many_association 
  #     configure :user_notifications, :has_many_association 
  #     configure :notification_preferences, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :username, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :confirmation_token, :string 
  #     configure :confirmed_at, :datetime 
  #     configure :confirmation_sent_at, :datetime 
  #     configure :unconfirmed_email, :string 
  #     configure :name, :string 
  #     configure :avatar_file_name, :string         # Hidden 
  #     configure :avatar_content_type, :string         # Hidden 
  #     configure :avatar_file_size, :integer         # Hidden 
  #     configure :avatar_updated_at, :datetime         # Hidden 
  #     configure :avatar, :paperclip 
  #     configure :neighborhood_id, :integer         # Hidden 
  #     configure :birthday, :date 
  #     configure :org_id, :integer 
  #     configure :type, :string 
  #     configure :mission, :string 
  #     configure :vision, :string 
  #     configure :description, :text 
  #     configure :website, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model UserNotification do
  #   # Found associations:
  #     configure :notification, :belongs_to_association 
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :notification_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
