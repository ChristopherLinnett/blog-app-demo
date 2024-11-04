class CustomException extends Error {
    constructor(public message: string, public statusCode: any) {
      super(message); 
      this.name = this.constructor.name;
    }
  
    toString() {
      return `${this.name}: ${this.message} (Status Code: ${this.statusCode})`;
    }
  
    equals(other: CustomException): boolean {
      return (
        other instanceof CustomException &&
        this.message === other.message &&
        this.statusCode === other.statusCode
      );
    }
  }
  
 export class ServerException extends CustomException {
    constructor(message: string, statusCode: any) {
      super(message, statusCode);
    }
  }
  
 export class CacheException extends CustomException {
    constructor(message: string, statusCode: any = 500) {
      super(message, statusCode);
    }
  }
  
 export class AuthException extends CustomException {
    constructor(message: string, statusCode: any) {
      super(message, statusCode);
    }
  }
  export class FileSystemException extends CustomException {
    constructor(message: string, statusCode: any) {
      super(message, statusCode);
    }
  }

  export class UnknownException extends CustomException {
    constructor(message: string, statusCode: any) {
      super(message, statusCode);
    }
  }

  export class DataFormatException extends CustomException {
    constructor(message: string, statusCode: any) {
      super(message, statusCode);
    }
  }