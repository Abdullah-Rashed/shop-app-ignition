class EndPoints {
  EndPoints._();

  //? Endpoint URLs
  static const baseUrl = "https://api.escuelajs.co/api/v1";
  static const testingUrl = baseUrl;
  static const prodUrl = baseUrl;
  static const apiUrl = testingUrl;
  static const register = "$apiUrl/users/";
  static const login = "$apiUrl/auth/login";
}
