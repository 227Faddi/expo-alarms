import ExpoModulesCore
import AlarmKit

public class ExpoAlarmsModule: Module {
    public func definition() -> ModuleDefinition {
    Name("ExpoAlarms")
        


    Function("getApiKey") {
return Bundle.main.object(forInfoDictionaryKey: "NSAlarmKitUsageDescription") as? String ?? "Still Missing"
    }

    AsyncFunction("askPermission") { () async throws -> String in
        if #available(iOS 26.0, *) {
            do {
                let state = try await AlarmManager.shared.requestAuthorization()
                return state == .authorized ? "auth" : "no"
            } catch {
                print("Error occurred while requesting authorization: \(error)")
                return "no"
            }
        } else {
            return "ios 18"
        }
    }

  }
}
