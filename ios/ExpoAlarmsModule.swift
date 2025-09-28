import ExpoModulesCore
import AlarmKit
import AppIntents

public class ExpoAlarmsModule: Module {
    public func definition() -> ModuleDefinition {
        Name("ExpoAlarms")
        
        Events("onAppOpen")
        
        AsyncFunction("setAlarm") { (hour: Int, minute: Int, label: String, weekdays: [Int]?) async throws -> String in
            if #available(iOS 26.0, *) {
                do {
                    // Alert
                    let alert = AlarmPresentation.Alert(
                        title: LocalizedStringResource(stringLiteral: label),
                        stopButton: AlarmButton(
                            text: "Stop",
                            textColor: .red,
                            systemImageName: "xmark"
                        ),
                        secondaryButton: AlarmButton(
                            text: "Open App",
                            textColor: .red,
                            systemImageName: "xmark"
                        ),
                        secondaryButtonBehavior: .custom
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
                    
                    // 1. Time is correct
                    let time = Alarm.Schedule.Relative.Time(hour: hour, minute: minute)
                    
                    // 2. Conversion and Recurrence logic (The main fix)
                    // a. Map the array of Int (e.g., [1, 2, 3]) to [Locale.Weekday]
                    let convertedWeekdays: [Locale.Weekday]? = weekdays?.compactMap { intValue in
                        switch intValue {
                        case 0: return .sunday
                        case 1: return .monday
                        case 2: return .tuesday
                        case 3: return .wednesday
                        case 4: return .thursday
                        case 5: return .friday
                        case 6: return .saturday
                        default: return nil
                        }
                    }
                    
                    // b. Recurrence logic:
                    // If convertedWeekdays is nil OR empty, use .never. Otherwise, use .weekly().
                    let recurrence: Alarm.Schedule.Relative.Recurrence = convertedWeekdays?.isEmpty == false ?
                        .weekly(convertedWeekdays!) :
                        .never
                    
                    // 3. Build the relative schedule
                    let relativeSchedule = Alarm.Schedule.Relative(
                        time: time,
                        repeats: recurrence
                    )
                    
                    // 4. Wrap relative schedule into the top-level Alarm.Schedule
                    let schedule: Alarm.Schedule = .relative(relativeSchedule)
                    
                    let id = UUID()
                    
                    let intent = OpenAppIntent(id: id)
                    
                    let configuration = AlarmManager.AlarmConfiguration(
                        schedule: schedule,
                        attributes: attributes,
                        secondaryIntent: intent,
                        sound: .default,
                    )
                    
                    let alarm = try await AlarmManager.shared.schedule(id: id, configuration: configuration)
                    
                    print("✅ Alarm scheduled successfully:")
                    print("ID: \(alarm.id)")
                    print("Schedule: \(String(describing: alarm.schedule))")
                    print("State: \(alarm.state)")
                    
                    return "Alarm scheduled with ID: \(alarm.id)"
                    
                } catch {
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
                throw Exception(
                    name: "UnsupportedVersion",
                    description: "AlarmKit requires iOS 26.0 or later"
                )
            }
        }
    }
    
    @available(iOS 26.0, *)
    struct OpenAppIntent: LiveActivityIntent {
        static var title: LocalizedStringResource = "Opens App"
        static var openAppWhenRun: Bool = true
        static var isDiscoverable: Bool = false
        
        @Parameter
        var id: String
    
        init(id: UUID) {
            self.id = id.uuidString
        }
        
        init() {
            
        }
        
        func perform() async throws -> some IntentResult {
            if let alarmID = UUID(uuidString: id) {
                print(alarmID)
            }
            
            return .result()
        }
    }
}
