import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import $ from "jquery"
import "./address_select"
window.$ = $
window.jQuery = $


Rails.start()
Turbolinks.start()
ActiveStorage.start()