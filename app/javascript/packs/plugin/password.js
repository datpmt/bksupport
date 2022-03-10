window.addEventListener('DOMContentLoaded', () => {
	window.showHidePass = function(e, page) {
		if ( page == 'sign_in_cms' ) {
			input_pass = $(e).parent().parent().find("input.password")
		}
		type_input = input_pass.attr('type')
		parent 		 = input_pass.closest('.position-relative')

		if ( type_input == "password" ) {
			input_pass.attr('type', 'text')
			if (page == 'sign_in_cms') {
				parent_devise = input_pass.parent().parent().find('.position-relative')
				parent_devise.find('.eye-position').addClass('d-none')
				parent_devise.find('.hide-position').removeClass('d-none')
			}
		} else {
			input_pass.attr('type', 'password')
      if ( page == 'sign_in_cms' ) {
				parent_devise = input_pass.parent().parent().find('.position-relative')
				parent_devise.find('.hide-position').addClass('d-none')
				parent_devise.find('.eye-position').removeClass('d-none')
			}
		}
	}
});
