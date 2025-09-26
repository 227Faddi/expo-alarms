import * as ExpoAlarm from "expo-alarms";
import { Text, View } from "react-native";

export default function App() {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text>API key: {ExpoAlarm.getApiKey()}</Text>
    </View>
  );
}
