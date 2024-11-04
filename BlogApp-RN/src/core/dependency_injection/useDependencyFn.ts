import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { Services } from "@/src/core/dependency_injection/services";

export const useDependencyFn = <T extends keyof Services>(
  fn: T
): Services[T] => {
  const services = useServices();
  const output = services[fn];
  return output;
};
