// Reexport the native module. On web, it will be resolved to ExpoAlarmsModule.web.ts
// and on native platforms to ExpoAlarmsModule.ts
export { default } from './ExpoAlarmsModule';
export { default as ExpoAlarmsView } from './ExpoAlarmsView';
export * from  './ExpoAlarms.types';
