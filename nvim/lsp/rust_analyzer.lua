return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                overrideCommand = {
                    "cargo",
                    "clippy",
                    "--all-features",
                    "--all-targets",
                    "--workspace",
                    "--message-format=json",
                    -- "--target=wasm32-unknown-unknown",
                },
            },
        },
    },
}
