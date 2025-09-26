package expo.modules.alarms

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ExpoAlarmsModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoAlarms")

    Function("getApiKey") {
      return@Function "api-key"
    }
  }
}
