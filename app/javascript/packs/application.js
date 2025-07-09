import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import $ from "jquery"
window.$ = $
window.jQuery = $


Rails.start()
Turbolinks.start()
ActiveStorage.start()
