import { StyleSheet, Text, View } from "react-native";
import { CompletedComment } from "../../data/models/completedComment";

export const CommentTile: React.FC<Partial<CompletedComment>> = ({
  author,
  content,
}) => {
  return (
    <View style={styles.commentContainer}>
      <Text style={styles.commentAuthor}>{author}</Text>
      <Text style={styles.commentContent}>{content}</Text>
    </View>
  );
};
const styles = StyleSheet.create({
  commentContainer: {
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: "#ccc",
    marginBottom: 10,
  },
  commentAuthor: {
    fontWeight: "bold",
  },
  commentContent: {
    marginTop: 5,
  },
});
