<script lang="ts">
  export let cartItem: any;
</script>

<div class="p-2 bg-stone-700 rounded-md shadow-md flex flex-col gap-2">
  <h1 class="font-semibold leading-tight">{cartItem.name}</h1>
  <p class="text-sm">{cartItem.desc}</p>
  <p class="text-sm">{cartItem.price}</p>
  <button
    class="p-2 rounded-md border border-stone-200 bg-stone-700 text-stone-100 font-semibold hover:bg-stone-800"
    >Remove Item</button
  >
</div>
