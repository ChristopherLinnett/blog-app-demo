import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { AuthException } from "@/src/core/errors/exceptions";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { isRight } from "fp-ts/lib/Either";
import { CompletedPost } from "../../data/models/completedPost";

export const useDeletePost = (postId: string, sideEffect?: () => void) => {
  const queryClient = useQueryClient();
  const { deletePost } = useServices();

  return useMutation({
    mutationFn: async () => {
      const response = await deletePost(postId);
      if (isRight(response)) {
        return response.right;
      }
      throw new AuthException(response.left.message, response.left.statusCode);
    },
    onMutate: async () => {
      if (sideEffect) {
        sideEffect();
      }
      await queryClient.cancelQueries({ queryKey: ["posts"] });

      const previousPosts = queryClient.getQueryData<CompletedPost[]>([
        "posts",
      ]);

      queryClient.setQueryData<CompletedPost[]>(["posts"], (oldPosts) =>
        oldPosts ? oldPosts.filter((post) => post.id !== postId) : []
      );

      return { previousPosts };
    },
    onError: (error, _, context) => {
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
