-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    lazy = false,
    requires = { 'nvim-lua/plenary.nvim' }, -- if harpoon requires this
    config = function()
      require('harpoon').setup {}

      local function toggle_telescope_with_harpoon(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = require('telescope.config').values.file_previewer {},
            sorter = require('telescope.config').values.generic_sorter {},
          })
          :find()
      end
      vim.keymap.set('n', '<leader>ha', function()
        local harpoon = require 'harpoon'
        toggle_telescope_with_harpoon(harpoon:list())
      end, { desc = 'Open harpoon window' })
    end,
    keys = {
      {
        '<leader>hf',
        function()
          require('harpoon'):list():append()
        end,
        desc = '[H]arpoon [F]ile',
      },
      {
        '<leader>hq',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[H]arpoon [Q]uick menu',
      },
      {
        '<leader>h1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = '[H]arpoon to file [1]',
      },
      {
        '<leader>h2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = '[H]arpoon to file [2]',
      },
      {
        '<leader>h3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = '[H]arpoon to file [3]',
      },
    },
  },
}
