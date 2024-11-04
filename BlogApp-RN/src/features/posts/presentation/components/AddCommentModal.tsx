import { useState } from "react";
import {
  Button,
  KeyboardAvoidingView,
  Modal,
  Platform,
  StyleSheet,
  Text,
  TextInput,
  TouchableWithoutFeedback,
  View,
} from "react-native";
import { useAddComment } from "../hooks/useAddComment";

export const AddCommentModal: React.FC<{
  postId: string;
  modalVisible: boolean;
  hideModal: () => void;
}> = ({ postId, modalVisible, hideModal }) => {
  const [newComment, setNewComment] = useState("");

  const handleAddComment = useAddComment(postId, () => {
    hideModal(), setNewComment("");
  });

  return (
    <Modal
      transparent={true}
      visible={modalVisible}
      animationType="fade"
      onRequestClose={hideModal}
    >
      <TouchableWithoutFeedback onPress={hideModal}>
        <KeyboardAvoidingView
          style={styles.modalOverlay}
          behavior={Platform.OS === "ios" ? "padding" : "height"}
        >
          <TouchableWithoutFeedback onPress={() => {}}>
            <View style={styles.modalContainer}>
              <Text style={styles.modalTitle}>Add new Comment</Text>
              <TextInput
                style={styles.input}
                placeholder="Comment"
                value={newComment}
                onChangeText={setNewComment}
                multiline
              />
              <Button
                title="Submit"
                onPress={() => handleAddComment(newComment)}
              />
              <Button title="Cancel" onPress={hideModal} color="red" />
            </View>
          </TouchableWithoutFeedback>
        </KeyboardAvoidingView>
      </TouchableWithoutFeedback>
    </Modal>
  );
};

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    justifyContent: "flex-end", 
    backgroundColor: "rgba(0, 0, 0, 0.5)",
  },
  modalContainer: {
    marginTop: "auto",
    padding: 35,
    backgroundColor: "white",
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2,
    },
    borderRadius: 20,

    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
  modalTitle: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
  },
  input: {
    backgroundColor: "#fff",
    padding: 10,
    borderRadius: 8,
    marginBottom: 15,
    fontSize: 16,
  },
});
