<script lang="ts">
  import { Cards, CurrencyBtc, CurrencyDollar, TrashSimple } from "phosphor-svelte";
  import { fetchNui } from "../../utils/fetchNui";
import { cartItems } from "../../store/stores";
  import { formatAsUSD } from "../../utils/formatUSD";


  let cartTotalPrice = 0;
  let totalCartItems = 0;
  let currentCartItems: any[];

  function calcTotalCartCost(cart: any[]) {
    let total = 0;
    cart.forEach((item) => {
      total += item.price;
    });
    return total;
  }

  cartItems.subscribe((cartStuff) => {
    totalCartItems = cartStuff.length;
    cartTotalPrice = calcTotalCartCost(cartStuff);
    currentCartItems = cartStuff;
  });

  async function checkout(currencyType: string) {
    const checkoutList: any[] = []

    currentCartItems.forEach(item => {
      checkoutList.push(item.item)
    })

    const checkoutData = {
      cartItems: checkoutList,
      total: cartTotalPrice,
      currency: currencyType,
    };

    const canClearItems: boolean = await fetchNui('checkout', checkoutData);

    if (canClearItems) {
      clearCart();
    }
  }

  function clearCart() {
    cartItems.set([]);
  }
</script>

<div class="flex flex-col gap-2 items-center w-full">
  <div class="flex items-center justify-between gap-2 w-full">
    <div class="flex flex-col gap-1">
        <h1 class="text-xl font-semibold">Total</h1>
        <p class="text-sm text-stone-500">{totalCartItems} items</p>
    </div>
    <div>
        <p class="text-xl font-semibold">{formatAsUSD(cartTotalPrice)}</p>
    </div>
  </div>
  <div class="flex flex-col gap-4 w-full pt-6">
      <button
        class="p-2 rounded-md border border-stone-200 bg-stone-700 text-stone-100 font-semibold hover:bg-stone-800 w-full text-sm flex gap-3 items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-stone-700"
        disabled={totalCartItems === 0}
        on:click={() => checkout('bank')}
        >
        <Cards />
        Checkout with Card</button>
        <!-- <button
        class="p-2 rounded-md border border-stone-200 bg-stone-700 text-stone-100 font-semibold hover:bg-stone-800 w-full text-sm flex gap-3 items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-stone-700"
        disabled={totalCartItems === 0}
        on:click={() => checkout('crypto')}
        >
        <CurrencyBtc />
        Checkout with Crypto</button> -->
        <span class="text-sm text-stone-500 text-center w-full font-semibold">OR</span>
        <button
        class="p-2 rounded-md border border-stone-200 bg-stone-700 text-stone-100 font-semibold hover:bg-stone-800 w-full text-sm flex gap-3 items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-stone-700"
        disabled={totalCartItems === 0}
        on:click={clearCart}
        >
        <TrashSimple />
        Clear Cart</button>
  </div>
</div>
