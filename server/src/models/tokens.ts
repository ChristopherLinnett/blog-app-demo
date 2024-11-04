const tokens: Token[] = [];

export interface Token {
  id: string;
  value: string;
  expires: number;
}

export { tokens };
