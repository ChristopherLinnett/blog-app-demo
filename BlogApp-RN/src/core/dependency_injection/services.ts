import AuthDatasourceImplementation from "@/src/features/authentication/data/datasources/authDatasourceImplementation";
import AuthRepoImplementation from "@/src/features/authentication/data/domain/authRepoImplementation";
import { AuthResponse } from "@/src/features/authentication/data/models/authResponse";
import { ResponseMessage } from "@/src/features/authentication/data/models/responseMessage";
import Login from "@/src/features/authentication/domain/usecases/login";
import Logout from "@/src/features/authentication/domain/usecases/logout";
import SignUp from "@/src/features/authentication/domain/usecases/signUp";
import PostDatasourceImplementation from "@/src/features/posts/data/datasources/postDatasourceImplementation";
import PostRepoImplementation from "@/src/features/posts/data/domain/postRepoImplementation";
import { CompletedComment } from "@/src/features/posts/data/models/completedComment";
import { CompletedPost } from "@/src/features/posts/data/models/completedPost";
import { PostTemplate } from "@/src/features/posts/data/models/postTemplate";
import AddComment from "@/src/features/posts/domain/usecases/addComment";
import AddPost from "@/src/features/posts/domain/usecases/addPost";
import DeletePost from "@/src/features/posts/domain/usecases/deletePost";
import EditPost from "@/src/features/posts/domain/usecases/editPost";
import GetComments from "@/src/features/posts/domain/usecases/getComments";
import GetPosts from "@/src/features/posts/domain/usecases/getPosts";
import { AxiosInstance } from "axios";
import { AsyncResult } from "../typedefs/asyncResult";

export class Services {
  login: (username: string, password: string) => AsyncResult<AuthResponse>;
  logout: () => AsyncResult<ResponseMessage>;
  signUp: (username: string, password: string) => AsyncResult<AuthResponse>;

  addComment: (
    postId: string,
    comment: string,
    author: string
  ) => AsyncResult<CompletedComment>;
  addPost: (post: PostTemplate) => AsyncResult<CompletedPost>;
  deletePost: (postId: string) => AsyncResult<ResponseMessage>;
  editPost: (
    postId: string,
    updateInfo: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => AsyncResult<CompletedPost>;
  getComments: (postId: string) => AsyncResult<CompletedComment[]>;
  getPosts: () => AsyncResult<CompletedPost[]>;

  constructor(private httpClient: AxiosInstance) {
    const authRepo = new AuthRepoImplementation(
      new AuthDatasourceImplementation(httpClient)
    );
    const postRepo = new PostRepoImplementation(
      new PostDatasourceImplementation(httpClient)
    );

    this.login = new Login(authRepo).call;
    this.logout = new Logout(authRepo).call;
    this.signUp = new SignUp(authRepo).call;

    this.addComment = new AddComment(postRepo).call;
    this.addPost = new AddPost(postRepo).call;
    this.deletePost = new DeletePost(postRepo).call;
    this.editPost = new EditPost(postRepo).call;
    this.getComments = new GetComments(postRepo).call;
    this.getPosts = new GetPosts(postRepo).call;
  }
}
