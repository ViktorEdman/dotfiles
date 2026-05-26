local Module = {}

local opts = {
    max_width = 80,
    max_height = 20,
    border = "rounded",
}

function Module.hover_window()
    vim.lsp.buf.hover(opts)
end

function Module.signature_window()
    vim.lsp.buf.signature_help(opts)
end

return Module
