# Be sure to restart your server when you modify this file.

# https://stackoverflow.com/questions/53772298/devise-session-timeout-even-i-set-the-timeout-in-parameter-to-20-years
Rails.application.config.session_store :cookie_store, key: '_shepic_session', expire_after: 10080.minutes
