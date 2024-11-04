import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { CompletedPost } from "../../data/models/completedPost";
import { PostTemplate } from "../../data/models/postTemplate";
import PostRepo from "../repos/postRepo";

class EditPost {
  constructor(private repo: PostRepo) {}
  call: (
    postId: string,
    updateInfo: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => AsyncResult<CompletedPost> = (postId, updateInfo) => {
    return this.repo.updatePost(postId, updateInfo);
  };
}

export default EditPost;
