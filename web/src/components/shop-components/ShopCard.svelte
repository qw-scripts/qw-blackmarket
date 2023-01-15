<script lang="ts">
  export let item: any;

  import { CheckCircle, PlusCircle } from "phosphor-svelte";
  import { formatAsUSD } from "../../utils/formatUSD";
  import { cartItems } from "../../store/stores";

  let hasAdded = false;

  function addItem(item: any) {
    hasAdded = true;
    cartItems.update((items) => {
      items.push(item);
      return items;
    });

    setTimeout(() => {
      hasAdded = false;
    }, 1000);
  }
</script>

<div
  class="p-2 flex items-start justify-between gap-2 w-full bg-stone-700 rounded-md shadow-md h-fit"
>
  <div class="flex flex-col gap-2">
    <h1 class="font-semibold leading-tight">{item.name}</h1>
    <p class="text-sm">{item.description}</p>
    <p class="text-sm">{formatAsUSD(item.price)}</p>
  </div>
  <button
    class="flex gap-3 items-center p-2 hover:bg-stone-800 rounded-md"
    on:click={() => addItem(item)}
  >
    {#if hasAdded}
      <CheckCircle color='#6fde8d' />
    {:else}
      <PlusCircle />
    {/if}
    <span class="text-sm font-semibold">Add</span>
  </button>
</div>
