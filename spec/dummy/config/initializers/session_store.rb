# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dummy_session',
  :secret      => 'e23cd329fe8005a9b4f0d707c4b411f67ff04c6de94eb7b50479f625de75327813e2118d742d4c1b7c15bab7691013eeeebe5c4e45c06118603fc34013c46c29'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
