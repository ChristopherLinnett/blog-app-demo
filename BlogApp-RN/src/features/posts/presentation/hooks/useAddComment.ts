import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { AuthException } from "@/src/core/errors/exceptions";
import { useAuthSelector } from "@/src/features/authentication/presentation/state/authStateNotifier";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { isRight } from "fp-ts/lib/Either";
import { CompletedComment } from "../../data/models/completedComment";

export const useAddComment = (postId: string, sideEffect: () => void) => {
  const queryClient = useQueryClient();
  const { addComment } = useServices();
  const email = useAuthSelector((state) => state.email);

  return useMutation({
    mutationFn: async (newComment: string) => {
      const response = await addComment(postId, newComment, email);
      if (isRight(response)) {
        return response.right;
      }
      throw new AuthException(response.left.message, response.left.statusCode);
    },
    onMutate: async (newComment) => {
      await queryClient.cancelQueries({ queryKey: ["comments", postId] });
      if (sideEffect) {
        sideEffect();
      }
      const previousComments = queryClient.getQueryData<CompletedComment[]>([
        "comments",
        postId,
      ]);

      const optimisticComment: CompletedComment = {
        postId: postId,
        id: "temp" + Date.now().toString(),
        content: newComment,
        author: email,
      };
      queryClient.setQueryData<CompletedComment[]>(
        ["comments", postId],
        (oldComments) =>
          oldComments
            ? [...oldComments, optimisticComment]
            : [optimisticComment]
      );

      return { previousComments };
    },
    onError: (error, newComment, context) => {
      if (context?.previousComments) {
        queryClient.setQueryData(
          ["comments", postId],
          context.previousComments
        );
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ["comments", postId] });
    },
    onSuccess: () => {},
  }).mutate;
};
