import {
  AuthException,
  CacheException,
  DataFormatException,
  FileSystemException,
  ServerException,
  UnknownException,
} from "./exceptions";

export abstract class Failure {
  constructor(public message: string, public statusCode: number | string) {
    if (typeof statusCode !== "number" && typeof statusCode !== "string") {
      throw new Error(
        `${typeof statusCode} is not valid for a statusCode, use a String or integer only`
      );
    }
  }

  get errorMessage(): string {
    return `${this.statusCode}${
      typeof this.statusCode === "number" ? " Error" : ""
    }: ${this.message}`;
  }

  equals(other: Failure): boolean {
    return (
      other instanceof Failure &&
      this.message === other.message &&
      this.statusCode === other.statusCode
    );
  }
}

export class CacheFailure extends Failure {
  constructor(message: string, statusCode: number | string) {
    super(message, statusCode);
  }

  static fromException(exception: CacheException): CacheFailure {
    return new CacheFailure(exception.message, exception.statusCode);
  }
}

export class ServerFailure extends Failure {
  constructor(message: string, statusCode: number | string) {
    super(message, statusCode);
  }

  static fromException(exception: ServerException): ServerFailure {
    return new ServerFailure(exception.message, exception.statusCode);
  }
}

export class AuthFailure extends Failure {
  constructor(message: string, statusCode: number | string) {
    super(message, statusCode);
  }

  static fromException(exception: AuthException): AuthFailure {
    return new AuthFailure(exception.message, exception.statusCode);
  }
}

export class FileSystemFailure extends Failure {
  constructor(message: string, statusCode: number | string) {
    super(message, statusCode);
  }

  static fromException(exception: FileSystemException): FileSystemFailure {
    return new FileSystemFailure(exception.message, 500);
  }
}

export class UnknownFailure extends Failure {
  constructor(message: string, statusCode: number | string) {
    super(message, statusCode);
  }

  static fromException(exception: Error | UnknownException): FileSystemFailure {
    return new UnknownFailure(
      exception.message ?? "An unknown error has occurred",
      500
    );
  }
}

export class DataFormatFailure extends Failure {
  constructor(message: string, statusCode: number | string) {
    super(message, statusCode);
  }

  static fromException(exception: DataFormatException): FileSystemFailure {
    return new DataFormatFailure(exception.message, exception.statusCode);
  }
}
