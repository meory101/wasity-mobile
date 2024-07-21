

abstract class ApiStatusCode{
  static List<int> success()=> [200,201];
  static int invalidSessionToken() => 209;
  static int serverError() => 500;
  static List<int> badRequest() => [400,401];
}