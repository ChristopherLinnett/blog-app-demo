// CommentsScreen.tsx

import FilledButton from "@/src/components/FilledButton";
import { LoadingView } from "@/src/components/LoadingView";
import { RootStackParamList } from "@/src/core/app/AppRouter";
import { RouteProp, useRoute } from "@react-navigation/native";
import { useState } from "react";
import { FlatList, StyleSheet, Text, View } from "react-native";
import { useSignoutButton } from "../../../authentication/presentation/hooks/useSignOutButton";
import { AddCommentModal } from "../components/AddCommentModal";
import { CommentTile } from "../components/CommentTile";
import { LoadingFailureView } from "../components/LoadingFaiulreView";
import useGetComments from "../hooks/useGetComments";
import useGetPosts from "../hooks/useGetPosts";

const PostDetailsPage: React.FC = () => {
  const { params } = useRoute<RouteProp<RootStackParamList, "PostDetails">>();
  const { postId } = params;

  useSignoutButton();

  const [modalVisible, setModalVisible] = useState(false);
  const {
    data: posts,
    isLoading: postLoading,
    isError: postsError,
    refetch: refetchPosts,
  } = useGetPosts();
  const {
    data: comments,
    isLoading: commentsLoading,
    isError: commentsError,
    refetch: refetchComments,
  } = useGetComments(postId);

  if (commentsLoading || postLoading)
    return <LoadingView style={{ flex: 1 }} />;

  if (postsError || posts === undefined)
    return <LoadingFailureView onRetry={refetchPosts} dataType="post" />;

  if (commentsError || comments === undefined)
    return <LoadingFailureView onRetry={refetchComments} dataType="comments" />;

  const post = posts?.filter((post) => post.id === postId)[0];
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.postTitle}>{post.title}</Text>
        <Text style={styles.postAuthor}>By: {post.author}</Text>
        <Text style={styles.postContent}>{post.content}</Text>
      </View>
      <FlatList
        data={comments}
        keyExtractor={(item) => item.id}
        renderItem={({ item: comment }) => (
          <CommentTile author={comment.author} content={comment.content} />
        )}
        contentContainerStyle={styles.commentList}
      />
      <View style={{ marginBottom: 50 }}>
        <FilledButton
          fillColour="#4CAF50"
          text="Add Comment"
          textColour="#fff"
          onPressed={() => {
            setModalVisible(true);
          }}
        />
      </View>
      <AddCommentModal
        modalVisible={modalVisible}
        hideModal={() => setModalVisible(false)}
        postId={postId}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
  },
  header: {
    marginBottom: 20,
  },
  postTitle: {
    fontSize: 24,
    fontWeight: "bold",
  },
  postAuthor: {
    fontSize: 16,
    fontStyle: "italic",
    color: "gray",
  },
  postContent: {
    fontSize: 16,
    marginTop: 10,
  },
  commentList: {
    paddingBottom: 50,
  },
});

export default PostDetailsPage;
