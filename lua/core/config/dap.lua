require("dapui").setup()
require("dap-go").setup()
require("nvim-dap-virtual-text").setup({})

local dap = require("dap")
local ui = require("dapui")

dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
    }
}

dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end


vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { noremap = true })
vim.keymap.set('n', '<leader>dc', dap.continue, { noremap = true })
vim.keymap.set('n', '<leader>dn', dap.step_over, { noremap = true })
vim.keymap.set('n', '<leader>di', dap.step_into, { noremap = true })
vim.keymap.set('n', '<leader>do', dap.step_out, { noremap = true })
vim.keymap.set('n', '<leader>dr', dap.restart, { noremap = true })
vim.keymap.set('n', '<leader>dt', function()
    ui.close()
    dap.terminate()
end, { noremap = true })
vim.keymap.set('n', '<leader>dl', function()
    require "osv".launch({ port = 8086 })
end, { noremap = true })

vim.keymap.set('n', '<leader>dw', function()
    local widgets = require "dap.ui.widgets"
    widgets.hover()
end)

vim.keymap.set('n', '<leader>df', function()
    local widgets = require "dap.ui.widgets"
    widgets.centered_float(widgets.frames)
end)

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end -- Added this closing bracket
