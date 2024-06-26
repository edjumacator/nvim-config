---@param modes string | string[]
---@param lhs string | string[]
---@param rhs string | function
---@param opts? string | { desc: string?, force: boolean?, noremap: boolean?, silent: boolean?, nowait: boolean? }
---@return nil
local map = function(modes, lhs, rhs, opts)
  -- check if modes is a string or array
  -- if the type of opts is a string, make a new object with a description
  local options = type(opts) == 'string' and { desc = opts } or opts or {}

  -- vim.tbl_extend('force', options, opts)
  -- if not options.force then
  --   options.force = true
  -- end
  -- options.force = "force" in options and options.force or true

  local set = function(mode, _lhs, _rhs, _opts)
    vim.keymap.set(mode, _lhs, _rhs, _opts)
  end

  if type(modes) == 'string' then
    set(modes, lhs, rhs, options)
  else
    for _, mode in ipairs(modes) do
      local _rhs = rhs
      if mode == 'i' and type(_rhs) == 'string' then
        _rhs = '<Esc>' .. _rhs .. 'i'
      end
      options.desc = (options.desc or '') .. ' (' .. mode .. ' mode)'

      set(mode, lhs, _rhs, options)
    end
  end
end

return map
