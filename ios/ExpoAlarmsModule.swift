import ExpoModulesCore

public class ExpoAlarmsModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoAlarms")

    Function("getApiKey") {
     return Bundle.main.object(forInfoDictionaryKey: "MY_CUSTOM_API_KEY") as? String
    }
  }
}
