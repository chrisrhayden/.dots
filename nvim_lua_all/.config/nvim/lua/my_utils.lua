Keymap = { scope = "global", mode = "", key = "", action = "", opts = {} }

function Keymap:new(settings)
  for k, v in pairs(settings) do
    self[k] = v
  end

  return self
end

function Keymap:buf()
  self.scope = "buffer"
  return self
end

function Keymap:global()
  self.scope = "global"
  return self
end

function Keymap:nore()
  self.opts["noremap"] = true
  return self
end

function Keymap:silent()
  self.opts["silent"] = true
  return self
end

function Keymap:set_opts(opts)
  for k, v in pairs(opts) do
    self.opts[k] = v
  end
  return self
end

function Keymap:set()
  -- print("in set", vim.inspect(self))
  if self.scope == "global" then
    vim.api.nvim_set_keymap(self.mode, self.key, self.action, self.opts)
  else
    vim.api.nvim_buf_set_keymap(0, self.mode, self.key, self.action, self.opts)
  end
  return self
end
