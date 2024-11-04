import { AuthException } from "@/src/core/errors/exceptions";
import { AuthFailure, UnknownFailure } from "@/src/core/errors/failures";
import { AsyncResult } from "@/src/core/typedefs/asyncResult";
import { ResponseMessage } from "@/src/features/authentication/data/models/responseMessage";
import { left, right } from "fp-ts/lib/Either";
import PostRepo from "../../domain/repos/postRepo";
import PostDatasource from "../datasources/postDatasource";
import { CompletedComment } from "../models/completedComment";
import { CompletedPost } from "../models/completedPost";
import { PostDetails } from "../models/postDetails";
import { PostTemplate } from "../models/postTemplate";

class PostRepoImplementation implements PostRepo {
  constructor(private datasource: PostDatasource) {}
  getPosts: () => AsyncResult<CompletedPost[]> = async () => {
    try {
      const result = await this.datasource.getPosts();
      return right(result);
    } catch (exception) {
      if (exception instanceof AuthException) {
        return left(AuthFailure.fromException(exception));
      }
      return left(
        new UnknownFailure("An unknonwn server error has occurred", 500)
      );
    }
  };
  addPost: (post: PostTemplate) => AsyncResult<CompletedPost> = async (
    post
  ) => {
    try {
      const result = await this.datasource.addPost(post);
      return right(result);
    } catch (exception) {
      if (exception instanceof AuthException) {
        return left(AuthFailure.fromException(exception));
      }
      return left(
        new UnknownFailure("An unknonwn server error has occurred", 500)
      );
    }
  };
  deletePost: (postId: string) => AsyncResult<ResponseMessage> = async (
    postId
  ) => {
    try {
      const result = await this.datasource.deletePost(postId);
      return right(result);
    } catch (exception) {
      if (exception instanceof AuthException) {
        return left(AuthFailure.fromException(exception));
      }
      return left(
        new UnknownFailure("An unknonwn server error has occurred", 500)
      );
    }
  };
  updatePost: (
    postId: string,
    updateDetails: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => AsyncResult<CompletedPost> = async (postId, updateDetails) => {
    try {
      const result = await this.datasource.editPost(postId, updateDetails);
      return right(result);
    } catch (exception) {
      if (exception instanceof AuthException) {
        return left(AuthFailure.fromException(exception));
      }
      return left(
        new UnknownFailure("An unknonwn server error has occurred", 500)
      );
    }
  };
  addComment: (
    postId: string,
    comment: string,
    author: string
  ) => AsyncResult<CompletedComment> = async (postId, comment, author) => {
    try {
      const result = await this.datasource.addComment(postId, comment, author);
      return right(result);
    } catch (exception) {
      if (exception instanceof AuthException) {
        return left(AuthFailure.fromException(exception));
      }
      return left(
        new UnknownFailure("An unknonwn server error has occurred", 500)
      );
    }
  };
  getCommentsByPostId: (postId: string) => AsyncResult<CompletedComment[]> = async (
    postId
  ) => {
    try {
      const result = await this.datasource.getCommentsByPostId(postId);
      return right(result);
    } catch (exception) {
      if (exception instanceof AuthException) {
        return left(AuthFailure.fromException(exception));
      }
      return left(
        new UnknownFailure("An unknonwn server error has occurred", 500)
      );
    }
  };
}

export default PostRepoImplementation;
