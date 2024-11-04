import { CompletedComment } from "./completedComment";

export interface PostDetails {
    author: string;
    comments: CompletedComment[];
    content: string;
    id: string;
    title: string;
}