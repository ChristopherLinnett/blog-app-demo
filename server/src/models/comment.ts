import { v4 as uuidv4 } from "uuid";

let comments: CompletedComment[] = [];

const addComment: (comment: CommentTemplate) => CompletedComment = ({
  postId,
  content,
  author,
}) => {
  const comment: CompletedComment = { id: uuidv4(), postId, content, author };
  comments.push(comment);
  return comment;
};

export interface CommentTemplate {
  postId: string;
  content: string;
  author: string;
}

export interface CompletedComment extends CommentTemplate {
  id: string;
}

export { addComment, comments };
