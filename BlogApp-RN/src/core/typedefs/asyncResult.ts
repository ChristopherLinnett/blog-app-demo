import { Either } from "fp-ts/lib/Either";
import { Failure } from "../errors/failures";

export type AsyncResult<T> = Promise<Either<Failure, T>>;
