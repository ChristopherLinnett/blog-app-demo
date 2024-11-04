import { v4 as uuidv4 } from "uuid";
import { CompletedComment } from "./comment";

let posts: CompletedPost[] = [];

const addPost: (post: PostTemplate) => CompletedPost = ({
  title,
  content,
  author,
}) => {
  const post = { id: uuidv4(), title, content, author, comments: [] };
  posts.push(post);
  return post;
};

const updatePost: (
  id: string,
  updatedData: Partial<Pick<PostTemplate, keyof PostTemplate>>
) => CompletedPost | null = (id, updatedData) => {
  const index = posts.findIndex((post) => post.id === id);
  if (index !== -1) {
    posts[index] = { ...posts[index], ...updatedData };
    return posts[index];
  }
  return null;
};

export interface PostTemplate {
  title?: string;
  content?: string;
  author?: string;
}

export interface CompletedPost extends PostTemplate {
  id: string;
  comments: CompletedComment[];
}

export { addPost, posts, updatePost };
