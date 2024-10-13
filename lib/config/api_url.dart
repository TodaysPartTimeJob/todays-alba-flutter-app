class ApiUrl{
  // static var baseUrl = 'http://10.0.2.2:8080' ;
  static var baseUrl = 'http://10.4.5.154:8080' ;

  static var login = "$baseUrl/api/auth/login";
  static var signup = "$baseUrl/api/auth/signup";
  static var nicknameDuplicationCheck = "$baseUrl/api/auth/nickname/duplicationCheck";
  static var userInfoGet = "$baseUrl/api/user";
  static var tokenReissue = "$baseUrl/api/auth/refreshToken";
}