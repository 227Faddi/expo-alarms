import ExpoModulesCore

public class ExpoAlarmsModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoAlarms")

    Function("getApiKey") { () -> String in
      "api-key"
    }
  }
}
