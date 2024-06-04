class Validators{


  String? validateName(String value){
    if (value.isEmpty|| !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
      return 'Please enter correct name';
    }else{
      return null;
    }
  }

  String? validateEmail(String value){
    if (value.isEmpty|| !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
      return 'Please enter correct email';
    }else{
    return null;
  }
  }

  static validateMobile(String value) {
    String patternForBD =
        r'^(\+88|0088)?(01){1}[3456789]{1}(\d){8}$'; //with and without country code
    String pattern = r'^(01){1}[3456789]{1}(\d){8}$'; //without country code
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required'.toString();
    } else if (value.length < 5) {
      return 'Password must be at least 8 characters'.toString();
    }
    return null;
  }
}
