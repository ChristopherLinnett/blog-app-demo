import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { CompletedPost } from "../../data/models/completedPost";
import PostRepo from "../repos/postRepo";

class GetPosts {
  constructor(private repo: PostRepo) {}
  call: () => AsyncResult<CompletedPost[]> = () => {
    return this.repo.getPosts();
  };
}

export default GetPosts;
