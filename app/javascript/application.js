import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

// Configure Bootstrap
import 'bootstrap'
import './custom/bootstrap'
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
