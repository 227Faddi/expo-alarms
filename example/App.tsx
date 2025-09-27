import * as Alarms from "expo-alarms";
import { useEffect, useState } from "react";
import { Text, TouchableOpacity, View } from "react-native";

export default function App() {
  const [permission, setPermission] = useState(false);

  const askPermission = async () => {
    const response = await Alarms.checkPermission();
    setPermission(response);
  };

  const handleAlarm = async () => {
    const response = await Alarms.setAlarm();
    console.log(response);
  };

  useEffect(() => {
    askPermission();
  }, []);

  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text>Permission: {permission ? "yes" : "no"}</Text>
      <TouchableOpacity
        onPress={handleAlarm}
        style={{ backgroundColor: "red", padding: 8 }}
      >
        <Text>Set Alarm</Text>
      </TouchableOpacity>
    </View>
  );
}
