import { Pressable, StyleSheet, Text } from "react-native";

const FilledButton: React.FC<ButtonProps> = ({
  text,
  fillColour,
  textColour,
  disabled,
  onPressed,
}) => {
  return (
    <Pressable
      disabled={disabled}
      style={({ pressed }) => {
        return {
          ...styles.button,
          backgroundColor: fillColour,
          opacity: pressed || disabled ? 0.5 : 1,
        };
      }}
      onPress={onPressed}
    >
      <Text style={{ ...styles.buttonText, color: textColour }}>{text}</Text>
    </Pressable>
  );
};

interface ButtonProps {
  text: string;
  fillColour?: string;
  textColour?: string;
  disabled?: boolean;
  onPressed: () => any;
}

export default FilledButton;

const styles = StyleSheet.create({
  button: {
    width: "100%",
    padding: 15,
    backgroundColor: "#4CAF50",
    borderRadius: 8,
    alignItems: "center",
    marginTop: 10,
  },
  buttonText: {
    color: "#fff",
    fontSize: 18,
    fontWeight: "bold",
  },
});
