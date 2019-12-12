class Authentication {
  String logoTitle ;
  String logoSubTitle;
  String signInMenuButton ;
  String signUpMenuButton ;
  String hintTextName;
  String hintTextEmail  ;
  String hintTextPassword ;
  String hintTextNewEmail ;
  String hintTextNewPassword ;
  String signUpButtonText;
  String signInWithEmailButtonText ;
  String signInWithAnonymouslyButtonText ;
  String alternativeLogInSeparatorText ;
  String emailLogInFailed ;
  String hintTextPhone;
  String hintTextTc;
  String hintTextAmbulancePlate;
  String hintTextVehicleLicence;
  String hintTextVehicleLicenceDate;


  Authentication({
    this.logoTitle= "SMART AMBULANCE",
    this.logoSubTitle = "SOLUTIONS * FOR * HEALTH",
    this.signInMenuButton= "SIGN IN",
    this.signUpMenuButton= "SIGN UP",
    this.hintTextName ="Name - Surname",
    this.hintTextEmail= "Email",
    this.hintTextPhone= "Enter Your Phone",
    this.hintTextTc= "Enter Your TC",
    this.hintTextPassword= "Password",
    this.hintTextNewEmail= "Enter your Mail Adress ",
    this.hintTextNewPassword= "Enter a Password",
    this.signUpButtonText = "SIGN UP",
    this.signInWithEmailButtonText= "Sign in with Email",
    this.signInWithAnonymouslyButtonText= "Sign in with Anonymously",
    this.alternativeLogInSeparatorText= "or",
    this.emailLogInFailed= "Email or Password was incorrect. Please try again",
    this.hintTextAmbulancePlate="Enter Your Ambulance Plate Number",
    this.hintTextVehicleLicence="Enter Your Vehicle Licence ",
    this.hintTextVehicleLicenceDate="Enter Your Vehicle Licence Date"
    
    
  });

  
}
