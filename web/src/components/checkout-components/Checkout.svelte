<script lang="ts">
  import { fetchNui } from "../../utils/fetchNui";
  import { onMount } from "svelte";
  import { cartItems } from "../../store/stores";
  import CartActions from "./CartActions.svelte";
  import CartItem from "./CartItem.svelte";

  let cart: any[];
  let shouldAllowCrypto = false;
  let cryptoInfo = {};

  cartItems.subscribe((cartStuff) => {
    cart = cartStuff;
  });

  onMount(async () => {
    const cryptoEnabled: boolean = await fetchNui("isCryptoEnabled");
    const clientCryptoInfo: any = await fetchNui("getCryptoInfo");

    shouldAllowCrypto = cryptoEnabled;
    cryptoInfo = clientCryptoInfo;
  });
</script>

<div class="flex gap-2 w-full">
  <div
    class="flex-1 w-3/4 cart-items-grid gap-2 overflow-y-scroll h-[46.5rem] noscroll-container"
  >
    {#each cart as item}
      <div class="bg-stone-700 rounded-md p-2">
        <CartItem cartItem={item} />
      </div>
    {/each}
  </div>
  <div class="w-1/4 p-2">
    <CartActions
      shouldUseCrypto={shouldAllowCrypto}
      clientCryptoInfo={cryptoInfo}
    />
  </div>
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
