import { AsyncResult } from "@/src/core/typedefs/asyncResult";
import { ResponseMessage } from "../../../authentication/data/models/responseMessage";
import { CompletedComment } from "../../data/models/completedComment";
import { CompletedPost } from "../../data/models/completedPost";
import { PostTemplate } from "../../data/models/postTemplate";

abstract class PostRepo {
  abstract getPosts: () => AsyncResult<CompletedPost[]>;
  abstract addPost: (post: PostTemplate) => AsyncResult<CompletedPost>;
  abstract deletePost: (postId: string) => AsyncResult<ResponseMessage>;
  abstract updatePost: (
    postId: string,
    updateDetails: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => AsyncResult<CompletedPost>;
  abstract addComment: (
    postId: string,
    comment: string,
    author: string
  ) => AsyncResult<CompletedComment>;
  abstract getCommentsByPostId: (postId: string) => AsyncResult<CompletedComment[]>;
}

export default PostRepo;
