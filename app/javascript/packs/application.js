window.jQuery = $;
window.$ = $;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "./plugin/bootstrap.bundle"
import $ from 'jquery'
import "./plugin/password.js"
require("bootstrap")
require("@popperjs/core")
Rails.start()
Turbolinks.start()
ActiveStorage.start()



document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    altInputClass: "form-control input flat",
  }),
  setTimeout(function() {
    $('.success, .alert').fadeOut();
  }, 10000);
})