import { NativeModule, requireNativeModule } from "expo";

declare class ExpoAlarmsModule extends NativeModule {
  setAlarm(): Promise<string>;
  checkPermission(): Promise<boolean>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoAlarmsModule>("ExpoAlarms");
