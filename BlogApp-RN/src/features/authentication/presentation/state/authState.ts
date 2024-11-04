class AuthState {
  constructor(private user: User, public token: Token) {}
  public get signedIn(): boolean {
    return (
      this.user.id !== undefined &&
      this.token.value !== undefined &&
      this.token.expires !== undefined &&
      new Date().getTime() < this.token.expires
    );
  }

  public get email(): string {
    return this.user.email ?? "";
  }

  public get fullName(): string {
    return `${this.user.firstName} ${this.user.lastName}`;
  }
  public get isStudent(): boolean {
    return this.user.role === "student";
  }
  public get isParent(): boolean {
    return this.user.role === "parent";
  }
  public get isInstitution(): boolean {
    return this.user.role === "institution";
  }
  public get isAdmin(): boolean {
    return this.user.role === "admin";
  }

  public copyWith: (params: AuthCopyParams) => AuthState = ({
    user,
    token,
  }) => {
    return new AuthState(user ?? this.user, token ?? this.token);
  };
}

interface AuthCopyParams {
  user?: User;
  token?: Token;
}

interface Token {
  value?: string;
  expires?: number;
}

export interface User {
  id?: string;
  email?: string;
  firstName?: string;
  lastName?: string;
  birthDate?: Date;
  role?: UserRole;
}

type UserRole = "student" | "parent" | "institution" | "admin" | undefined;

export default AuthState;
