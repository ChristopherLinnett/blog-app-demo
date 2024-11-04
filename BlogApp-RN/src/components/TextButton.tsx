import { Pressable, Text, TextStyle, View, ViewStyle } from "react-native";

const StyledButton: React.FC<{
  title: string;
  textStyle?: TextStyle;
  buttonStyle?: ViewStyle;
  onPress: () => void;
}> = ({ title, textStyle, buttonStyle, onPress }) => {
  return (
    <Pressable
      style={({ pressed }) => {
        return { opacity: pressed ? 0.5 : 1 };
      }}
      onPress={onPress}
    >
      <View style={buttonStyle}>
        <Text style={textStyle}>{title}</Text>
      </View>
    </Pressable>
  );
};

export default StyledButton;
