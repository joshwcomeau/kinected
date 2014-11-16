function UserRegistrationController() {
  this.current_step = 1;
  this.num_of_steps = 3;
  this.state_info = {
    step1: {
      required_fields: [
        'user[first_name]', 'birthdate_month',
        'user[last_name]',  'birthdate_day',
        'user[sex]',        'birthdate_year'
      ]
    },
    step2: {
      // There arent any fields, but because we've generalized the method we need
      // to pass in an array, this field can't be undefined or nil.
      required_fields: []   
    },
    step3: {
      required_fields: [
        'user[email]', 'user[password]', 'user[password_confirmation]'
      ]
    }
  };

  this.state_status = {
    step1: {
      submitted:  false,
      valid:      true
    },
    step2: {
      submitted:  false,
      valid:      true
    },
    step3: {
      submitted:  false,
      valid:      true
    }
  };
  
  this.mismatched_passwords = false;
  this.image_src = '';
}

UserRegistrationController.prototype.validateStep = function(step_num, e) {
  var step = "step"+step_num;

  // First, deal with stopping the default form submission if the form isn't valid
  if ( e && this.registration_form.$invalid ) { e.preventDefault(); }


  // Reset our validation flag. We can't use Angular's built-in one, because we're using
  // a multi-stage form. We're not actually submitting the form, just a fieldset.
  this.state_status[step].valid = true;
  this.mismatched_passwords = false;


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
    // Additional things that Angular can't figure out on its own
    // Password confirmation must match
    if ( _.indexOf(fields, "user[password]") !== -1 ) {
      if ( context.registration_form["user[password]"].$viewValue !== context.registration_form["user[password_confirmation]"].$viewValue ) {
        context.state_status[step].valid = false;
        context.mismatched_passwords = true;
      }
    }
  });
}

app.controller('UserRegistrationController', UserRegistrationController);