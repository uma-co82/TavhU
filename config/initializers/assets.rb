# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile << 'form/signup.css'
Rails.application.config.assets.precompile << 'nomiya/index'
Rails.application.config.assets.precompile << 'nomiya/show'
Rails.application.config.assets.precompile << 'nomiya/members'
Rails.application.config.assets.precompile << 'users/show'
Rails.application.config.assets.precompile << 'users/quick'
Rails.application.config.assets.precompile << 'users/quick_show'
Rails.application.config.assets.precompile << 'users/chat'
Rails.application.config.assets.precompile << 'users/seat'
Rails.application.config.assets.precompile << 'users/notification'
Rails.application.config.assets.precompile << 'users/author'
Rails.application.config.assets.precompile << 'form/reserve'
Rails.application.config.assets.precompile << 'form/edit'
Rails.application.config.assets.precompile << 'swiper.css'
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
