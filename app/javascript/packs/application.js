import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import $ from "jquery"
import "./address_select"
import "./building_price"
window.$ = $
window.jQuery = $


Rails.start()
Turbolinks.start()
ActiveStorage.start()