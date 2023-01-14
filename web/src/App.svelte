<script lang="ts">
  import Navbar from "./components/Navbar.svelte";
  import ShopFront from "./components/shop-components/ShopFront.svelte";
  import VisibilityProvider from "./providers/VisibilityProvider.svelte";
  import { debugData } from "./utils/debugData";
  import { currentRoute } from "./store/stores";
  import Checkout from "./components/checkout-components/Checkout.svelte";

  debugData([
    {
      action: "setVisible",
      data: true,
    },
  ]);

  let currRoute: string;

  currentRoute.subscribe((route) => {
    currRoute = route;
  });
</script>

<main>
  <VisibilityProvider>
    <div class="container bg-stone-800 text-stone-100">
      <div class="w-full p-4">
        <Navbar />
        {#if currRoute === "market"}
          <div class="py-2">
            <ShopFront />
          </div>
        {/if}
        {#if currRoute === "checkout"}
          <div class="py-2">
            <Checkout />
          </div>
        {/if}
      </div>
    </div>
  </VisibilityProvider>
</main>

<style>
  .container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    border-radius: 5px;
    min-height: 85%;
    min-width: 85%;
    user-select: none;
  }
</style>
