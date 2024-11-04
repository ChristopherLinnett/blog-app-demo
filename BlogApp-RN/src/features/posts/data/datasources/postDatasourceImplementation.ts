import { AuthException, UnknownException } from "@/src/core/errors/exceptions";
import { ResponseMessage } from "@/src/features/authentication/data/models/responseMessage";
import { AxiosError, AxiosInstance, AxiosResponse } from "axios";
import { Platform } from "react-native";
import { CompletedComment } from "../models/completedComment";
import { CompletedPost } from "../models/completedPost";
import { PostTemplate } from "../models/postTemplate";
import PostDatasource from "./postDatasource";

class PostDatasourceImplementation implements PostDatasource {
  url: string;
  constructor(private httpClient: AxiosInstance) {
    const address = Platform.OS === "ios" ? "localhost" : "10.0.2.2";
    this.url = `http://${address}:3001/api`;
  }
  getPosts: () => Promise<CompletedPost[]> = async () => {
    const endpoint = this.url + "/posts";

    try {
      const response: AxiosResponse<CompletedPost[]> =
        await this.httpClient.get<CompletedPost[]>(endpoint);
      const postsResponse: CompletedPost[] = response.data;
      return postsResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };

  addPost: (post: PostTemplate) => Promise<CompletedPost> = async (post) => {
    const endpoint = this.url + "/posts";
    try {
      const response: AxiosResponse<CompletedPost> =
        await this.httpClient.post<CompletedPost>(endpoint, post);
      const postResponse = response.data;
      return postResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };

  deletePost: (postId: string) => Promise<ResponseMessage> = async (postId) => {
    const endpoint = this.url + "/posts/" + postId;

    try {
      const response: AxiosResponse<ResponseMessage> =
        await this.httpClient.delete<ResponseMessage>(endpoint);
      const postResponse: ResponseMessage = response.data;
      return postResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };

  editPost: (
    postId: string,
    updateDetails: Partial<Pick<PostTemplate, keyof PostTemplate>>
  ) => Promise<CompletedPost> = async (postId, updateDetails) => {
    const endpoint = this.url + "/posts/" + postId;

    try {
      const response: AxiosResponse<CompletedPost> =
        await this.httpClient.put<CompletedPost>(endpoint, {
          postId,
          ...updateDetails,
        });
      const postResponse: CompletedPost = response.data;
      return postResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };
  addComment: (
    postId: string,
    comment: string,
    author: string
  ) => Promise<CompletedComment> = async (postId, comment, author) => {
    const endpoint = this.url + "/comments/" + postId;
    try {
      const response: AxiosResponse<CompletedComment> =
        await this.httpClient.post<CompletedComment>(endpoint, {
          content: comment,
          author: author,
        });
      const authResponse: CompletedComment = response.data;
      return authResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };
  getCommentsByPostId: (postId: string) => Promise<CompletedComment[]> = async (
    postId
  ) => {
    const endpoint = this.url + "/comments/" + postId;

    try {
      const response: AxiosResponse<CompletedComment[]> =
        await this.httpClient.get<CompletedComment[]>(endpoint);
      const authResponse: CompletedComment[] = response.data;
      return authResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };
}

export default PostDatasourceImplementation;
