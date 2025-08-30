function get_hl_groups_at_position(bufnr, row, col)
  local buf_highlighter = vim.treesitter.highlighter.active[bufnr]

  if not buf_highlighter then
    return {}
  end

  local matches = {}

  buf_highlighter.tree:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end

    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    -- Only worry about trees within the line range
    if root_start_row > row or root_end_row < row then
      return
    end

    local query = buf_highlighter:get_query(tree:lang())

    -- Some injected languages may not have highlight queries.
    if not query:query() then
      return
    end

    local iter = query:query():iter_captures(root, buf_highlighter.bufnr, row, row + 1)

    for capture, node, metadata in iter do
      local hl = query.hl_cache[capture]

      if hl and vim.treesitter.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          table.insert(matches, { capture = c, priority = metadata.priority })
        end
      end
    end
  end, true)
  return matches
end


return {
  'numToStr/Comment.nvim',
  config = function ()
    require('Comment').setup {

      pre_hook = function(ctx)
        local row = vim.fn.line "."
        local col = vim.fn.match(vim.fn.getline '.', '\\S')+1
        local matches = {}

        for _, i1 in ipairs(vim.fn.synstack(row, col)) do
          local i2 = vim.fn.synIDtrans(i1)
          local n1 = vim.fn.synIDattr(i1, "name")
          local n2 = vim.fn.synIDattr(i2, "name")
          table.insert(matches, "* " .. n1 .. " -> **" .. n2 .. "**")
        end

        -- print(vim.inspect(matches))

        --local bufnr = vim.api.nvim_get_current_buf()
        --local r, c = unpack(vim.api.nvim_win_get_cursor(0))
        --r = r - 1

        --local results = get_hl_groups_at_position(bufnr, r, c)
        --local highlights = {}
        --for _, hl in pairs(results) do
          --local l = "* **@" .. hl.capture .. "**"
          --if hl.priority then
            --l = l .. "(" .. hl.priority .. ")"
          --end
          --table.insert(highlights, l)
        --end

        --print(vim.inspect(highlights))

        if vim.iter(matches):any(function(s) return s:lower():find('javascript', 1, true) end) then
          return '// %s'
        elseif vim.iter(matches):any(function(s) return s:lower():find('css', 1, true) end) then
          return '/* %s */'
        elseif vim.iter(matches):any(function(s) return s:lower():find('html', 1, true) end) then
          return '<!-- %s -->'
        end

        return vim.bo.commentstring
      end
    }
  end,
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',
  }
}
