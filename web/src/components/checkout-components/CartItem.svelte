<script lang="ts">
  export let cartItem: any;
  import { formatAsUSD } from "../../utils/formatUSD";
  import { cartItems } from "../../store/stores";
  import { MinusCircle } from "phosphor-svelte";

  function removeItem(item: any) {
    cartItems.update((items) => {
      items.splice(items.indexOf(item), 1);
      return items;
    });
  }
</script>

<div class="p-2 bg-stone-700 rounded-md flex items-start justify-between gap-2 w-full">
  <div class="flex flex-col gap-2">
    <h1 class="font-semibold leading-tight">{cartItem.name}</h1>
    <p class="text-sm">{cartItem.description}</p>
    <p class="text-sm">{formatAsUSD(cartItem.price)}</p>
  </div>
  <button class="flex gap-3 items-center p-2 hover:bg-stone-800 rounded-md" on:click={() => removeItem(cartItem)}>
    <MinusCircle />
    <span class="text-sm">Remove</span>
  </button>
</div>
