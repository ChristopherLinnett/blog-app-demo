import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { CompletedComment } from "../../data/models/completedComment";
import { PostDetails } from "../../data/models/postDetails";
import PostRepo from "../repos/postRepo";

class GetComments {
  constructor(private repo: PostRepo) {}
  call: (postId: string) => AsyncResult<CompletedComment[]> = (postId) => {
    return this.repo.getCommentsByPostId(postId);
  };
}

export default GetComments;
