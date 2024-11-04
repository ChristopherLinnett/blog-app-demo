import { ResponseMessage } from "@/src/features/authentication/data/models/responseMessage";
import { CompletedComment } from "../models/completedComment";
import { CompletedPost } from "../models/completedPost";
import { PostTemplate } from "../models/postTemplate";

abstract class PostDatasource {
  abstract getPosts: () => Promise<CompletedPost[]>;
  abstract addPost: (post: PostTemplate) => Promise<CompletedPost>;
  abstract deletePost: (postId: string) => Promise<ResponseMessage>;
  abstract editPost: (
    postId: string,
    updateDetails: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => Promise<CompletedPost>;
  abstract addComment: (
    postId: string,
    comment: string,
    author: string,
  ) => Promise<CompletedComment>;
  abstract getCommentsByPostId: (postId: string) => Promise<CompletedComment[]>;
}

export default PostDatasource;
