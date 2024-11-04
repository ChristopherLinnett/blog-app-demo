import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { AuthException } from "@/src/core/errors/exceptions";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { isRight } from "fp-ts/lib/Either";
import { CompletedPost } from "../../data/models/completedPost";
import { PostTemplate } from "../../data/models/postTemplate";

export const useUpdatePost = (postId: string, sideEffect: () => void) => {
  const queryClient = useQueryClient();
  const { editPost } = useServices();

  return useMutation({
    mutationFn: async (
      newDetails: Partial<Pick<PostTemplate, keyof PostTemplate>>
    ) => {
      const response = await editPost(postId, newDetails);
      if (isRight(response)) {
        return response.right;
      }
      throw new AuthException(response.left.message, response.left.statusCode);
    },
    onMutate: async (newDetails) => {
      await queryClient.cancelQueries({ queryKey: ["posts"] });
      if (sideEffect) {
        sideEffect();
      }
      const previousPosts = queryClient.getQueryData<CompletedPost[]>([
        "posts",
      ]);

      queryClient.setQueryData<CompletedPost[]>(["posts"], (oldPosts) =>
        oldPosts?.map((post) =>
          post.id === postId ? { ...post, ...newDetails } : post
        )
      );

      return { previousPosts };
    },
    onError: (error, newDetails, context) => {
      if (context?.previousPosts) {
        queryClient.setQueryData(["posts"], context.previousPosts);
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ["posts"] });
    },
    onSuccess: () => {},
  }).mutate;
};
