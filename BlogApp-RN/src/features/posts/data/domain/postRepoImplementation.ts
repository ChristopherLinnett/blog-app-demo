import { handleException } from "@/src/core/errors/handleException";
import { left, right } from "fp-ts/lib/Either";
import PostRepo from "../../domain/repos/postRepo";
import PostDatasource from "../datasources/postDatasource";
import { PostTemplate } from "../models/postTemplate";

class PostRepoImplementation implements PostRepo {
  constructor(private datasource: PostDatasource) {}
  getPosts = async () => {
    try {
      const result = await this.datasource.getPosts();
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };
  addPost = async (post: PostTemplate) => {
    try {
      const result = await this.datasource.addPost(post);
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };
  deletePost = async (postId: string) => {
    try {
      const result = await this.datasource.deletePost(postId);
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };
  updatePost = async (
    postId: string,
    updateDetails: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => {
    try {
      const result = await this.datasource.editPost(postId, updateDetails);
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };
  addComment = async (postId: string, comment: string, author: string) => {
    try {
      const result = await this.datasource.addComment(postId, comment, author);
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };

  getCommentsByPostId = async (postId: string) => {
    try {
      const result = await this.datasource.getCommentsByPostId(postId);
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };
}

export default PostRepoImplementation;
