<script lang="ts">
    export let item: any;

    import { cartItems } from "../../store/stores";

    function addItem(item: any) {
        cartItems.update((items) => {
            items.push(item);
            return items;
        });
    }
</script>

<div class="p-2 flex flex-col gap-2 bg-stone-700 rounded-md shadow-md h-fit">
    <h1 class="font-semibold leading-tight">{item.name}</h1>
    <p class="text-sm">{item.desc}</p>
    <p class="text-sm">{item.price}</p>
    <button class="p-2 rounded-md border border-stone-200 bg-stone-700 text-stone-100 font-semibold hover:bg-stone-800" on:click={() => addItem(item)}>Add to Cart</button>
</div>