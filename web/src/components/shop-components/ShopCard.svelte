<script lang="ts">
    export let item: any;

  import { CheckCircle } from "phosphor-svelte";
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

<div class="p-2 flex flex-col gap-2 bg-stone-700 rounded-md shadow-md h-fit">
    <h1 class="font-semibold leading-tight">{item.name}</h1>
    <p class="text-sm">{item.desc}</p>
    <p class="text-sm">{item.price}</p>
    <button class="p-2 rounded-md border border-stone-200 bg-stone-700 text-stone-100 font-semibold hover:bg-stone-800 flex items-center justify-center gap-2" on:click={() => addItem(item)}>
        {#if hasAdded}
            <CheckCircle size={24} weight="fill" />
        {/if}
        Add to Cart</button>
</div>