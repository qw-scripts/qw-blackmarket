import { writable } from "svelte/store";

export const visibility = writable(false);

export const cartItems = writable<any[]>([]);

export const currentRoute = writable<'market' | 'checkout'>("market");
