import { NativeModule, requireNativeModule } from "expo";

declare class ExpoAlarmsModule extends NativeModule {
  getApiKey(): string;
  askPermission(): Promise<string>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoAlarmsModule>("ExpoAlarms");
