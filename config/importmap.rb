# Pin npm packages by running ./bin/importmap

pin 'application'
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin '@popperjs/core', to: 'popper.js', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@stimulus-components/password-visibility', to: '@stimulus-components--password-visibility.js' # @3.0.0
pin "@stimulus-components/notification", to: "@stimulus-components--notification.js" # @3.0.0
pin "stimulus-use" # @0.52.2
