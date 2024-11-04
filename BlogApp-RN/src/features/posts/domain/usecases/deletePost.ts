import { ResponseMessage } from "@/src/features/authentication/data/models/responseMessage";
import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import PostRepo from "../repos/postRepo";

class DeletePost {
  constructor(private repo: PostRepo) {}
  call: (postId: string) => AsyncResult<ResponseMessage> = (postId) => {
    return this.repo.deletePost(postId);
  };
}

export default DeletePost;
