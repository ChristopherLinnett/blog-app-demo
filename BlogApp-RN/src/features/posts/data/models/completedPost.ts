import { CompletedComment } from "./completedComment";
import { PostTemplate } from "./postTemplate";

export interface CompletedPost extends PostTemplate {
  id: string;
  comments: CompletedComment[];
}
