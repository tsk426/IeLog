import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import $ from "jquery"
window.$ = $
window.jQuery = $


Rails.start()
Turbolinks.start()
ActiveStorage.start()
