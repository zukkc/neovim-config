require "nvchad.mappings"


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>fp", function()
  local path = vim.fn.input("Open file path: ", "", "file")
  vim.cmd("edit " .. path)
end, { desc = "Open external file" })

map("n", "<leader>pd", function()
  vim.cmd("NeovimProjectDiscover")
end, { desc = "Open projects list" })


map("n", "<C-b>", function()
  vim.cmd("wa")
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "scons target=template_debug && morphic --path game/",
    id = "morphic_build",
    title = "Morphic Engine Build",
    clear_cmd = false
  }
end, { desc = "Run Morphic Game" })
