enum Environment {
  local,
  heroku,
}

class AppConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.local:
        _config = _Config.localConfig;
        break;
      case Environment.heroku:
        _config = _Config.herokuConfig;
        break;
    }
  }

  static get baseUrl {
    return _config["baseUrl"];
  }

  static get whereAmI {
    return _config["whereAmI"];
  }
}

class _Config {
  static Map<String, dynamic> localConfig = {
    // "baseUrl": "https://localhost:5001/api",
    "whereAmI": "local"
  };

  static Map<String, dynamic> herokuConfig = {
    "baseUrl": "https://api-agente-parceiro-magalu.herokuapp.com/",
    "whereAmI": "dev"
  };
}
