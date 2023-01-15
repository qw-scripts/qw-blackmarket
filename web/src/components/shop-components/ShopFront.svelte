<script lang="ts">
  import ShopCard from "./ShopCard.svelte";

  let sampleData = [
    {
      name: "Item 1",
      desc: "This is a sample item",
      price: 1.0,
    },
    {
      name: "Item 2",
      desc: "This is a sample item",
      price: 1.0,
    },
    {
      name: "Item 3",
      desc: "This is a sample item",
      price: 5.0,
    },
    {
      name: "Item 4",
      desc: "This is a sample item",
      price: 100.0,
    },
    {
      name: "Item 5",
      desc: "This is a sample item",
      price: 1.0,
    },
  ];

  let search = "";
</script>

<div class="flex flex-col gap-2 w-full">
  <input
    type="text"
    bind:value={search}
    placeholder="search for an item"
    class="w-full p-2 rounded-md bg-stone-700 text-stone-100"
  />
  <div class="noscroll-container shop-grid gap-2 overflow-y-scroll h-[43.5rem]">
    {#each sampleData.filter((item) => item.name
        .toLowerCase()
        .includes(search.toLowerCase())) as item}
      <ShopCard {item} />
    {/each}
  </div>
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
