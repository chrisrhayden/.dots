return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "akinsho/org-bullets.nvim"
  },
  ft = "org",
  opts = {
    org_agenda_files = "~/notebook/*",
    org_default_notes_file = "~/notebook/index.org",
    win_split_mode = "float",
    org_hide_leading_stars = true,
    org_hide_emphasis_markers = true,
    calendar_week_start_day = 0,
    org_tags_column = -80,
    org_indent_mode = "noindent",
    mappings = {
      org = {
        org_open_at_point = "<cr>",
        -- org_do_promote = "<lader>>",
        org_do_promote = false,
        org_do_demote = false,
      }
    }
  },
  config = function(_, opts)
    require("orgmode").setup_ts_grammar()

    require("orgmode").setup(opts)

    -- require("org-bullets").setup()
  end,
}
