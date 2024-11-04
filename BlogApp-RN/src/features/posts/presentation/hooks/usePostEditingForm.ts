import { useState } from "react";
import { CompletedPost } from "../../data/models/completedPost";

export const usePostEditingForm: (
  post: CompletedPost
) => PostEditingFormResponse = (post: CompletedPost) => {
  const [editing, setEditing] = useState(false);
  const [title, setTitle] = useState<string>(post.title ?? "");
  const [content, setContent] = useState<string>(post.content ?? "");

  const updateEditing = (newValue: boolean) => {
    if (newValue) {
      if (title !== post.title) setTitle(post.title ?? "");
      if (content !== post.content) setContent(post.content ?? "");
      return setEditing(true);
    }
    setEditing(false);
  };
  return {
    editing: { get: editing, set: updateEditing },
    title: { get: title, set: setTitle },
    content: { get: content, set: setContent },
  };
};

interface PostEditingFormResponse {
  editing: { get: boolean; set: (newValue: boolean) => void };
  title: { get: string; set: (newValue: string) => void };
  content: { get: string; set: (newValue: string) => void };
}
