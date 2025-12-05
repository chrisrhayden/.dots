local note_dir = vim.fs.joinpath("~", "notes")

local orgmode = {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "akinsho/org-bullets.nvim" },
  },
  opts = {
    org_agenda_files = vim.fs.joinpath(note_dir, "**/*"),
    org_default_notes_file = vim.fs.joinpath(note_dir, "refile.org"),
    org_capture_templates = {
      b = {
        description = "Bad Light",
        template = "",
        target = vim.fs.joinpath(note_dir, "bad_light.org")
      }
    },
  },
  -- config = function(_, opts)
  --   local org = require("orgmode")
  --
  --   org.setup(opts)
  --
  --   print("orgggg")
  --   set_key {
  --     "<leader>oc",
  --     function()
  --       org.capture()
  --     end
  --   }
  -- end
}

return { orgmode }
