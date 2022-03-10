window.jQuery = $;
window.$ = $;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "./plugin/bootstrap.bundle"
import $ from 'jquery'

import "./plugin/password.js"
import "./plugin/bootstrap.bundle"
require("bootstrap")
require("@popperjs/core")
Rails.start()
Turbolinks.start()
ActiveStorage.start()



document.addEventListener("turbolinks:load", () => {
  setTimeout(function() {
    $('.success, .alert').fadeOut();
  }, 10000);
})