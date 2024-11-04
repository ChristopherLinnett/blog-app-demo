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
import { useAddPost } from "../hooks/useAddPost";

export const AddPostModal: React.FC<{
  modalVisible: boolean;
  hideModal: () => void;
}> = ({ modalVisible, hideModal }) => {
  const [newPostTitle, setNewPostTitle] = useState("");
  const [newPostContent, setNewPostContent] = useState("");

  const handleAddPost = useAddPost(() => {
    hideModal(), setNewPostContent(""), setNewPostTitle("");
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
              <Text style={styles.modalTitle}>Create New Post</Text>
              <TextInput
                style={styles.input}
                placeholder="Title"
                value={newPostTitle}
                onChangeText={setNewPostTitle}
              />
              <TextInput
                style={styles.input}
                placeholder="Content"
                value={newPostContent}
                onChangeText={setNewPostContent}
                multiline
              />
              <Button
                title="Submit"
                onPress={() =>
                  handleAddPost({
                    title: newPostTitle,
                    content: newPostContent,
                  })
                }
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
