import FilledButton from "@/src/components/FilledButton";
import { LoadingView } from "@/src/components/LoadingView";
import React, { useState } from "react";
import { FlatList, StyleSheet, View } from "react-native";
import { useSignoutButton } from "../../../authentication/presentation/hooks/useSignOutButton";
import { AddPostModal } from "../components/AddPostModal";
import { LoadingFailureView } from "../components/LoadingFaiulreView";
import PostTile from "../components/PostTile";
import useGetPosts from "../hooks/useGetPosts";

const PostList: React.FC = () => {
  const [modalVisible, setModalVisible] = useState(false);
  const { data: posts, isLoading, isError, refetch } = useGetPosts();

  useSignoutButton();

  if (isLoading) return <LoadingView style={{ flex: 1 }} />;
  if (isError) return <LoadingFailureView onRetry={refetch} dataType="posts" />;

  return (
    <View style={styles.container}>
      <FlatList
        data={posts}
        keyExtractor={(item) => item.id}
        renderItem={({ item: post }) => <PostTile post={post} />}
        contentContainerStyle={styles.listContent}
      />
      <AddPostModal
        modalVisible={modalVisible}
        hideModal={() => setModalVisible(false)}
      />
      <View style={{ marginBottom: 50 }}>
        <FilledButton
          fillColour="#4CAF50"
          text="Add New Post"
          textColour="#fff"
          onPressed={() => setModalVisible(true)}
        />
      </View>
    </View>
  );
};

export default PostList;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f5f5f5",
    padding: 20,
  },
  listContent: {
    paddingBottom: 20,
  },
  addButton: {
    backgroundColor: "#4CAF50",
    padding: 10,
    borderRadius: 8,
    alignItems: "center",
    marginBottom: 50,
  },
  addButtonText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "bold",
  },
});
