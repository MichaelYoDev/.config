return {
    s({ trig = "each" },
        fmta([[
        {#each <> as <>}
            <>
        {/each}
        ]],
            {
                i(1),
                i(2),
                i(3),
            })
    ),
    s({ trig = "await" },
        fmta([[
        {#await <> }
            <>
        {:then}
            <>
        {/await}
        ]],
            {
                i(1),
                i(2),
                i(3),
            })
    ),
    s({ trig = "if" },
        fmta([[
        {#if <>}
            <>
        {/if}
        ]],
            {
                i(1),
                i(2),
            })
    ),
    s({ trig = "elif" },
        fmta([[
        {:else if}
            <>
        ]],
            {
                i(1),
            })
    ),
    s({ trig = "else" },
        fmta([[
        {:else}
            <>
        ]],
            {
                i(1),
            })
    ),
    s({ trig = "ts" },
        fmt([[
        <script lang="ts">
           {}
        </script>
        ]],
            {
                i(1)
            })
    ),
}
