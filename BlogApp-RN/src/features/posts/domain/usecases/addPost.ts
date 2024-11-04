import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { CompletedPost } from "../../data/models/completedPost";
import { PostTemplate } from "../../data/models/postTemplate";
import PostRepo from "../repos/postRepo";

class AddPost {
  constructor(private repo: PostRepo) {}
  call: (post: PostTemplate) => AsyncResult<CompletedPost> = (post) => {
    return this.repo.addPost(post);
  };
}

export default AddPost;
