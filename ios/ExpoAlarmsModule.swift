import ExpoModulesCore
import AlarmKit

public class ExpoAlarmsModule: Module {
    public func definition() -> ModuleDefinition {
        Name("ExpoAlarms")

        AsyncFunction("setAlarm") { () async throws -> String in
            if #available(iOS 26.0, *) {
                do {
                    let now = Date()
                                let localAlarmDate = now.addingTimeInterval(10)
                                
                                // Print both times for debugging
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                formatter.timeZone = TimeZone.current // Local timezone
                                
                                print("🕐 Current local time: \(formatter.string(from: now))")
                                print("⏰ Alarm will trigger at: \(formatter.string(from: localAlarmDate))")
                    
                    // Alert
                    let alert = AlarmPresentation.Alert(
                        title: "FixSleep",
                        stopButton: AlarmButton(text: "Stop", textColor: .white, systemImageName: "xmark"),
                    )
                    
                    // Presentation
                    let presentation = AlarmPresentation(alert: alert)
                    
                    nonisolated struct metadata: AlarmMetadata {
                    }
                    
                    let attributes = AlarmAttributes<metadata>(
                        presentation: presentation,
                        metadata: .init(),
                        tintColor: .purple
                    )
                    
                    // Schedule
                    let schedule = Alarm.Schedule.fixed(localAlarmDate)
                    let id = UUID()

                    let configuration = AlarmManager.AlarmConfiguration(
                        schedule: schedule,
                        attributes: attributes,
                        sound: .default
                    )

                    let alarm = try await AlarmManager.shared.schedule(id: id, configuration: configuration)
                    
                    print("✅ Alarm scheduled successfully:")
                    print("ID: \(alarm.id)")
                    print("Schedule: \(String(describing: alarm.schedule))")
                    print("State: \(alarm.state)")
                    
                    return "Alarm scheduled with ID: \(alarm.id)"
                    
                } catch {
                    print("❌ Failed to schedule alarm: \(error)")
                    throw Exception(
                        name: "AlarmScheduleError",
                        description: "Failed to schedule alarm: \(error.localizedDescription)"
                    )
                }
            } else {
                throw Exception(
                    name: "UnsupportedVersion",
                    description: "AlarmKit requires iOS 26.0 or later"
                )
            }
        }
        
        AsyncFunction("checkPermission") { () async throws -> Bool in
            if #available(iOS 26.0, *) {
                switch AlarmManager.shared.authorizationState {
                case .notDetermined:
                    let state = try await AlarmManager.shared.requestAuthorization()
                    return state == .authorized
                case .denied:
                    return false
                case .authorized:
                    return true
                @unknown default:
                    return false
                }
            } else {
                throw NSError(
                    domain: "ExpoAlarms",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "AlarmKit is only available on iOS 26.0 and later."]
                )
            }
        }
    }
}
