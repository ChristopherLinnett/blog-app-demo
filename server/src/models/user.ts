const users: UserWithPassword[] = [
  { id: "1", email: "admin", role: "admin", password: "admin" },
  { id: "2", email: "editor", role: "institution", password: "editor" },
];

export interface User {
  id: string;
  email?: string;
  firstName?: string;
  lastName?: string;
  birthDate?: Date;
  role?: UserRole;
}

type UserRole = "student" | "parent" | "institution" | "admin" | undefined;

export interface UserWithPassword extends User {
  password: string;
}

export { users };
