<script lang="ts">
  import { onMount } from "svelte";
  import { fetchNui } from "../../utils/fetchNui";
  import ShopCard from "./ShopCard.svelte";

  interface ReturnData {
    name: string;
    description: string;
    price: number;
  }

  let itemList: ReturnData[] = [];

  onMount(async () => {
    const response = await fetchNui("getItemList");
    itemList = response;
  });

  let search = "";
</script>

<div class="flex flex-col gap-2 w-full">
  <input
    type="text"
    bind:value={search}
    placeholder="search for an item"
    class="w-full p-2 rounded-md bg-stone-700 text-stone-100"
  />
  {#if itemList.length === 0}
    <div class="flex justify-center items-center">
      <div
        class="loader ease-linear rounded-full border-4 border-t-4 border-gray-200 h-6 w-6 mb-4"
      />
    </div>
  {:else}
    <div
      class="noscroll-container shop-grid gap-2 overflow-y-scroll h-[43.5rem]"
    >
      {#each itemList.filter((item) => item.name
        .toLowerCase()
        .includes(search.toLowerCase())) as item}
        <ShopCard {item} />
      {/each}
    </div>
  {/if}
</div>

<style>
  .noscroll-container {
    -ms-overflow-style: none; /* Internet Explorer 10+ */
    scrollbar-width: none; /* Firefox */
  }
  .noscroll-container::-webkit-scrollbar {
    display: none; /* Safari and Chrome */
  }

  .shop-grid {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    grid-auto-rows: max-content;
  }
</style>
