# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin 'jquery', to: 'jquery.min.js', preload: true
pin "jquery_ujs", to: "jquery_ujs.js", preload: true
pin "jquery-ui", to: "https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"
pin '@fortawesome/fontawesome-free', to: 'https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js'
