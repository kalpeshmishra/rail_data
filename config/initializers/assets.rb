# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(bootstrap-datetimepicker.min.js bootstrap-multiselect.js cable.js chartkick.js core.js file-validator.js fullcalendar.js highcharts.js jPushMenu.js jquery-customselect-1.9.1.js jquery-customselect-1.9.1.min.js jquery-customselect.js jquery.easy-pie-chart.js jquery.flot.js jquery.flot.pie.js jquery.gritter.js jquery.nanoscroller.js jquery.numeric.min.js jquery-sortable.js jquery.tablesorter.min.js jquery-ui.js jquery.validate.min.js masonry.js modernizr.js pagination.js regularize_request.js underscore.js zglobal.js)

Rails.application.config.assets.precompile += %w(blue.css bootstrap-datetimepicker.min.css bootstrap-multiselect.css card.css custom_report.css dashboard.css daterangepicker-bs3.css file-validator.css form12ba.css fullcalendar.css home.scss jquery-customselect-1.9.1.css jquery-customselect.css jquery.easy-pie-chart.css jquery.gritter.css nanoscroller.css zglobal.css z-style-orange.css)