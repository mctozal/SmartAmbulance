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


  Authentication({
    this.logoTitle= "SMART AMBULANCE",
    this.logoSubTitle = "SOLUTIONS * FOR * HEALTH",
    this.signInMenuButton= "SIGN IN",
    this.signUpMenuButton= "SIGN UP",
    this.hintTextName ="Name - Surname",
    this.hintTextEmail= "Email",
    this.hintTextPassword= "Password",
    this.hintTextNewEmail= "Enter your Email",
    this.hintTextNewPassword= "Enter a Password",
    this.signUpButtonText = "SIGN UP",
    this.signInWithEmailButtonText= "Sign in with Email",
    this.signInWithAnonymouslyButtonText= "Sign in with Anonymously",
    this.alternativeLogInSeparatorText= "or",
    this.emailLogInFailed= "Email or Password was incorrect. Please try again",
  });

  
}
