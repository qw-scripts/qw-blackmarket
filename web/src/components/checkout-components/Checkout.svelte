<script lang="ts">
  import { cartItems } from "../../store/stores";
  import CartItem from "./CartItem.svelte";

  let cart: any[];

  cartItems.subscribe((cartStuff) => {
    cart = cartStuff;
  });
</script>

<div class="flex gap-2 w-full">
  <div
    class="flex-1 w-3/4 cart-items-grid gap-2 overflow-y-scroll h-[46.5rem] noscroll-container"
  >
    {#each cart as item}
      <div class="bg-stone-700 rounded-md shadow-md p-2">
        <CartItem cartItem={item} />
      </div>
    {/each}
  </div>
  <div class="w-1/4 bg-stone-700 rounded-md shadow-md p-2">cart total</div>
</div>

<style>
  .cart-items-grid {
    display: grid;
    grid-template-columns: 1fr;
    grid-auto-rows: max-content;
  }

  .noscroll-container {
    -ms-overflow-style: none; /* Internet Explorer 10+ */
    scrollbar-width: none; /* Firefox */
  }
  .noscroll-container::-webkit-scrollbar {
    display: none; /* Safari and Chrome */
  }
</style>
