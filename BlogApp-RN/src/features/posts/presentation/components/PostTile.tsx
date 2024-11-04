import StyledButton from "@/src/components/TextButton";
import { RootStackParamList } from "@/src/core/app/AppRouter";
import { useAuthSelector } from "@/src/features/authentication/presentation/state/authStateNotifier";
import { NavigationProp, useNavigation } from "@react-navigation/native";
import { Pressable, StyleSheet, Text, TextInput, View } from "react-native";
import { CompletedPost } from "../../data/models/completedPost";
import { useDeletePost } from "../hooks/useDeletePost";
import { usePostEditingForm } from "../hooks/usePostEditingForm";
import { useUpdatePost } from "../hooks/useUpdatePost";

const PostTile: React.FC<{ post: CompletedPost }> = ({ post }) => {
  const navigation = useNavigation<NavigationProp<RootStackParamList>>();
  const { editing, title, content } = usePostEditingForm(post);

  const navigateToDetails = (postId: string) => {
    navigation.navigate("PostDetails", { postId });
  };

  const handleEditAction = () => {
    if (!editing.get) {
      return editing.set(true);
    }
    const updateTheTitle = title.get !== post.title;
    const updateTheContent = content.get !== post.content;
    if (!updateTheContent && !updateTheTitle) return editing.set(false);
    handleUpdatePost({ title: title.get, content: content.get });
  };
  const handleDeletePost = useDeletePost(post.id);

  const handleUpdatePost = useUpdatePost(post.id, () => {
    editing.set(false);
  });

  const [author, isAdmin] = useAuthSelector((state) => [
    state.email,
    state.isAdmin,
  ]);

  const available = !post.id.includes("temp");
  return (
    <Pressable
      style={({ pressed }) => [pressed && { opacity: 0.5 }]}
      onPress={() => navigateToDetails(post.id)}
      disabled={editing.get || !available}
    >
      <View
        style={{
          ...styles.postItem,
          opacity: !available ? 0.5 : 1,
        }}
      >
        <View style={{ flexDirection: "row", flex: 1 }}>
          <View style={{ flexDirection: "column", flex: 1 }}>
            {editing.get ? (
              <TextInput
                autoFocus
                placeholder="Title"
                value={title.get}
                onChangeText={title.set}
                style={[styles.postTitle, { opacity: 0.4 }]}
              />
            ) : (
              <Text style={styles.postTitle}>{post.title}</Text>
            )}
            {editing.get ? (
              <TextInput
                placeholder="Content"
                value={content.get}
                onChangeText={content.set}
                style={[styles.postContent, { opacity: 0.4 }]}
              />
            ) : (
              <Text style={styles.postContent}>{post.content}</Text>
            )}
          </View>
          {available && (
            <>
              <View style={{ justifyContent: "center" }}>
                {post.author === author && (
                  <StyledButton
                    title={editing.get ? "Save" : "Edit"}
                    onPress={handleEditAction}
                    textStyle={{ ...styles.textButton, color: "blue" }}
                  />
                )}
                {(post.author === author || isAdmin) && !editing.get && (
                  <StyledButton
                    title={"Delete"}
                    onPress={handleDeletePost}
                    textStyle={{ ...styles.textButton, color: "red" }}
                  />
                )}
                {editing.get && (
                  <StyledButton
                    title="Cancel"
                    onPress={() => editing.set(false)}
                    textStyle={{ ...styles.textButton, color: "red" }}
                  />
                )}
              </View>
            </>
          )}
        </View>
      </View>
    </Pressable>
  );
};

const styles = StyleSheet.create({
  postItem: {
    backgroundColor: "#fff",
    padding: 15,
    borderRadius: 8,
    marginBottom: 15,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  postTitle: {
    fontSize: 18,
    fontWeight: "bold",
    color: "#333",
  },
  postContent: {
    fontSize: 14,
    color: "#666",
    marginTop: 5,
  },
  textButton: {
    textAlign: "center",
    padding: 5,
  },
});

export default PostTile;
