window.jQuery = $;
window.$ = $;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "./plugin/bootstrap.bundle"
import $ from 'jquery'
import "./plugin/password.js"
require("bootstrap")
require("@popperjs/core")
Rails.start()
Turbolinks.start()
ActiveStorage.start()
