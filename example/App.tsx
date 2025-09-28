import * as Alarms from "expo-alarms";
import { useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";

export default function App() {
  const [permission, setPermission] = useState(false);
  const [hour, setHour] = useState("");
  const [minute, setMinute] = useState("");

  const askPermission = async () => {
    const response = await Alarms.checkPermission();
    setPermission(response);
  };

  const handleAlarm = async () => {
    const response = await Alarms.setAlarm({
      hour: Number(hour),
      minute: Number(minute),
      label: "Hello",
    });
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
      <View style={styles.container}>
        {/* Hour Input */}
        <TextInput
          style={styles.input}
          onChangeText={setHour}
          value={hour}
          placeholder="HH" // Placeholder for Hour
          keyboardType="numeric" // Forces a numeric keypad on mobile
          maxLength={2} // Ensures only 2 digits can be entered
        />

        {/* Minute Input */}
        <TextInput
          style={styles.input}
          onChangeText={setMinute}
          value={minute}
          placeholder="MM" // Placeholder for Minute
          keyboardType="numeric" // Forces a numeric keypad on mobile
          maxLength={2} // Ensures only 2 digits can be entered
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row", // Aligns the inputs side-by-side
    alignItems: "center",
    justifyContent: "center",
    padding: 10,
  },
  input: {
    height: 50,
    width: 60, // Fixed width to keep them close
    borderColor: "#ccc",
    borderWidth: 1,
    borderRadius: 8,
    textAlign: "center", // Center the text within the box
    fontSize: 24,
    marginHorizontal: 10,
  },
  separator: {
    fontSize: 30,
    fontWeight: "bold",
    color: "#333",
  },
});
