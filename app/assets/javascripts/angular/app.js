var app = angular.module('kinected', []);

app.controller('UserRegistrationController', UserRegistrationController);

function UserRegistrationController() {
  this.current_step = 1;
  this.num_of_steps = 2;
  this.state_info = {
    step1: {
      index: 1,
      required_fields: [
        'user[first_name]', 'birthdate_month',
        'user[last_name]',  'birthdate_day',
        'user[sex]',        'birthdate_year'
      ]
    },
    step2: {
      index: 2,
      required_fields: [
        'user[email]', 'user[password]', 'user[password_confirmation]'
      ]
    }
  }
  this.state_status = {
    step1: {
      submitted:  false,
      valid:      true
    },
    step2: {
      submitted:  false,
      valid:      true
    }
  }
}

UserRegistrationController.prototype.validateStep = function(step_num, e) {
  var step = "step"+step_num;

  // First, deal with stopping the default form submission if the form isn't valid
  if ( e && this.registration_form.$invalid ) { e.preventDefault(); }


  // Reset our validation flag. We can't use Angular's built-in one, because we're using
  // a multi-stage form. We're not actually submitting the form, just a fieldset.
  this.state_status[step].valid = true;


  // In the HTML, error messages are shown if step_1_submitted is true, and step_1_valid is false.
  checkRequiredFields(this.state_info[step].required_fields, step, this);

  // Mark this form as having been submitted
  this.state_status[step].submitted = true;



  if ( this.current_step !== this.num_of_steps ) {
    // If this step is valid, let's progress to the next.
    if ( this.state_status[step].valid ) {
      this.current_step++;
    }
  }

};

function checkRequiredFields(fields, step, context) {
  _.each(fields, function(element, index, list) {
    if ( context.registration_form[element].$invalid ) {
      context.state_status[step].valid = false;
    }
  });

}