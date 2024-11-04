import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { CompletedComment } from "../../data/models/completedComment";
import PostRepo from "../repos/postRepo";

class AddComment {
  constructor(private repo: PostRepo) {}
  call: (
    postId: string,
    comment: string,
    author: string
  ) => AsyncResult<CompletedComment> = (postId, comment, author) => {
    return this.repo.addComment(postId, comment, author);
  };
}

export default AddComment;
