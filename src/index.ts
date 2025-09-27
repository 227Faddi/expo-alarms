import ExpoAlarmsModule from "./ExpoAlarmsModule";

export function getApiKey(): string {
  return ExpoAlarmsModule.getApiKey();
}

export function askPermission(): Promise<string> {
  return ExpoAlarmsModule.askPermission();
}
