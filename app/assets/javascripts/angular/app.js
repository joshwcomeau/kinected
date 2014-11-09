var app = angular.module('kinected', []);

app.controller('UserRegistrationController', UserRegistrationController);

function UserRegistrationController() {
  this.current_step = 1;
  this.step_1_submitted = false;
}

UserRegistrationController.prototype.goToStep2 = function() {
  // Fields to check are first_name, last_name, birthdate fields and sex.
  console.log(this.myForm['user[first_name]'].$pristine);
}

UserRegistrationController.prototype.setForm = function(form) {
  this.myForm = form
}