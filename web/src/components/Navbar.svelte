<script lang="ts">
    import { ShoppingCartSimple, Skull, Storefront } from 'phosphor-svelte';
    import { cartItems, currentRoute } from '../store/stores';

    let currentCartAmount: number;

    cartItems.subscribe((value) => {
        currentCartAmount = value.length;
    });

    function changeRoute(route: 'market' | 'checkout') { 
        currentRoute.set(route);
    }
</script>

<div class="flex items-center p-4 bg-stone-700 rounded-md">
    <ul class="flex items-center justify-between gap-12 font-semibold w-full">
        <li class="hover:text-stone-200 hover:cursor-pointer">
            <button class="flex items-center gap-2" on:click={() => changeRoute('market')}>
                Market
                <Storefront />
            </button>
        </li>
        <li>
            <Skull size={"24"} />
        </li>
        <li class="flex items-center gap-2">
            <span class="text-sm bg-stone-800 p-1 w-8 h-8 rounded-full flex items-center justify-center">{currentCartAmount}</span>
            <button class="flex items-center gap-2 hover:text-stone-200 hover:cursor-pointer" on:click={() => changeRoute('checkout')}>
                Cart
                <ShoppingCartSimple />
            </button>
        </li>
    </ul>
</div>