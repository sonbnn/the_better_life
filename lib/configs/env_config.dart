// ignore: constant_identifier_names
enum Environment { DEV, TEST, PROD }

class EnvConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.TEST:
        _config = _Config.testConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
      default:
        _config = _Config.debugConstants;
    }
  }

  static get apiUrl {
    return _config[_Config.API_URL];
  }

}

class _Config {
  // ignore: constant_identifier_names
  static const API_URL = 'API_URL';

  static Map<String, dynamic> debugConstants = {
    API_URL: 'https://saas-api-dev.saworld.io/saas/api/v1',
  };

  static Map<String, dynamic> testConstants = {
    API_URL: 'https://saas-api-dev.saworld.io/saas/api/v1',
  };

  static Map<String, dynamic> prodConstants = {
    API_URL: 'https://saas-api-dev.saworld.io/saas/api/v1',
  };
}
