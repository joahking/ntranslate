# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ntranslate::Application.initialize!

Mime::Type.register 'text/yaml', :yaml
