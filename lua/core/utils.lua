local M = {}

M.map = function(lhs, rhs, desc, opts)
  if type(desc) == "table" then
    opts = desc
    desc = nil
  end
  opts = opts or {}
  if desc then
    opts.desc = desc
  end
  vim.keymap.set("n", lhs, rhs, opts)
end

M.map_expr = function(lhs, rhs, desc, opts)
  if type(desc) == "table" then
    opts = desc
    desc = nil
  end
  opts = opts or {}
  if desc then
    opts.desc = desc
  end
  opts.expr = true
  vim.keymap.set("n", lhs, rhs, opts)
end

M.map_mode = function(mode, lhs, rhs, desc, opts)
  if type(desc) == "table" then
    opts = desc
    desc = nil
  end
  opts = opts or {}
  if desc then
    opts.desc = desc
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end


M.packadd = function(name)
  vim.cmd("packadd " .. name)
end

return M
