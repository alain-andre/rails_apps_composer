# Application template recipe for the rails3_devise_wizard. Check for a newer version here:
# https://github.com/fortuity/rails3_devise_wizard/blob/master/recipes/add_user_name.rb

after_bundler do
   
  # Add a 'name' attribute to the User model
  if recipes.include? 'mongoid'
    gsub_file 'app/models/user.rb', /end/ do
  <<-RUBY
  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
RUBY
    end
  elsif recipes.include? 'mongo_mapper'
    # Using MongoMapper? Create an issue, suggest some code, and I'll add it
  elsif recipes.include? 'active_record'
    gsub_file 'app/models/user.rb', /end/ do
  <<-RUBY
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
RUBY
    end
  else
    # Placeholder for some other ORM
  end

  if recipes.include? 'devise'
    # install versions of modified Devise views
    inside 'app/views/devise/registrations' do
      get 'https://github.com/fortuity/rails3-application-templates/raw/master/files/rails3-mongoid-devise/app/views/devise/registrations/edit.html.erb', 'edit.html.erb'
      get 'https://github.com/fortuity/rails3-application-templates/raw/master/files/rails3-mongoid-devise/app/views/devise/registrations/new.html.erb', 'new.html.erb'
    end
  end

end

__END__

name: AddUserName
description: "Modify the default Devise configuration to add a 'name' attribute for all users."
author: fortuity

requires: [devise]
category: other
tags: [utilities, configuration]