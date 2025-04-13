local M = {}

M.remove_comments = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype

  if ft == 'lua' then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for i, line in ipairs(lines) do
      lines[i] = line:gsub('%-%-.*$', '')
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.cmd 'update'
    return
  end

  local js_family = { javascript = true, typescript = true, javascriptreact = true, typescriptreact = true, tsx = true, jsx = true }
  if js_family[ft] then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local in_multiline = false
    for i, line in ipairs(lines) do
      if in_multiline then
        local end_pos = line:find '%*/'
        if end_pos then
          lines[i] = line:sub(end_pos + 2)
          in_multiline = false
        else
          lines[i] = ''
        end
      else
        local single_line = line:gsub('//.*$', '')

        local start_pos = single_line:find '/%*'
        if start_pos then
          local end_pos = single_line:find('%*/', start_pos + 2)
          if end_pos then
            lines[i] = single_line:sub(1, start_pos - 1) .. single_line:sub(end_pos + 2)
          else
            lines[i] = single_line:sub(1, start_pos - 1)
            in_multiline = true
          end
        else
          lines[i] = single_line
        end
      end
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.cmd 'update'
    return
  end

  local success, language_tree = pcall(vim.treesitter.get_parser, bufnr)
  if not success or not language_tree then
    vim.notify('Treesitter parser not available for this file type', vim.log.levels.WARN)
    return
  end

  local tree = language_tree:parse()[1]
  if not tree then
    vim.notify('Failed to parse with treesitter', vim.log.levels.WARN)
    return
  end

  local root = tree:root()
  if not root then
    return
  end

  local queries = {
    '(comment) @comment',
    '(line_comment) @comment',
    '(block_comment) @comment',
    '(comment_block) @comment',
    '(html_comment) @comment',
    '(jsx_comment) @comment',
  }

  local changes = {}
  local lang = language_tree:lang()

  for _, query_str in ipairs(queries) do
    local success, query = pcall(vim.treesitter.query.parse, lang, query_str)
    if success and query then
      for _, match, _ in query:iter_matches(root, bufnr) do
        local node = match[1]
        if node then
          local ok, range_result = pcall(function()
            return { node:range() }
          end)

          if ok and range_result and #range_result == 4 then
            local start_row, start_col, end_row, end_col = unpack(range_result)
            table.insert(changes, {
              start_row = start_row,
              start_col = start_col,
              end_row = end_row,
              end_col = end_col,
            })
          end
        end
      end
    end
  end

  if #changes == 0 then
    vim.notify('No comments found or could not identify comments', vim.log.levels.INFO)
    return
  end

  table.sort(changes, function(a, b)
    if a.end_row > b.end_row then
      return true
    elseif a.end_row < b.end_row then
      return false
    else
      return a.end_col > b.end_col
    end
  end)

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_text(bufnr, change.start_row, change.start_col, change.end_row, change.end_col, { '' })
  end

  vim.cmd 'update'
end

M.code_actions = function()
  local function apply_specific_code_action(res)
    vim.lsp.buf.code_action {
      filter = function(action)
        return action.title == res.title
      end,
      apply = true,
    }
  end

  local actions = {}

  actions['Goto Definition'] = { priority = 100, call = vim.lsp.buf.definition }
  actions['Goto Implementation'] = { priority = 200, call = vim.lsp.buf.implementation }
  actions['Show References'] = { priority = 300, call = vim.lsp.buf.references }
  actions['Rename'] = { priority = 400, call = vim.lsp.buf.rename }

  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_range_params()

  params.context = {
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
  }

  vim.lsp.buf_request(bufnr, 'textDocument/codeAction', params, function(_, results, _, _)
    if not results or #results == 0 then
      return
    end
    for i, res in ipairs(results) do
      local prio = 10
      if res.isPreferred then
        if res.kind == 'quickfix' then
          prio = 0
        else
          prio = 1
        end
      end
      actions[res.title] = {
        priority = prio,
        call = function()
          apply_specific_code_action(res)
        end,
      }
    end
    local items = {}
    for t, action in pairs(actions) do
      table.insert(items, { title = t, priority = action.priority })
    end
    table.sort(items, function(a, b)
      return a.priority < b.priority
    end)
    local titles = {}
    for _, item in ipairs(items) do
      table.insert(titles, item.title)
    end
    vim.ui.select(titles, {}, function(choice)
      if choice == nil then
        return
      end
      actions[choice].call()
    end)
  end)
end

return M
