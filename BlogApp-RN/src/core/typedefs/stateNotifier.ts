export interface StateNotifier<T, N> {
  state: T;
  notifier: N;
}
