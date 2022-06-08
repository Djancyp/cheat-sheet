local M = {}
local api = vim.api
local cmd = vim.api.nvim_create_autocmd
require 'split'
function M.run()
  local ui = api.nvim_list_uis()[1]
  M.main_win = nil
  M.main_buf = nil
  M.main_win_width = math.floor(ui.width / 1.2)
  M.main_win_height = math.floor(ui.height / 1.2)
  M.main_win_style = "minimal"
  M.main_win_relavent = "win"
  M.main_win_border = 'double'
  M.main_col = ui.width / 2 - M.main_win_width / 2
  M.main_row = ui.height / 2 - M.main_win_height / 2

  M.input_win = nil
  M.input_buf = nil
  M.input_win_width = 60
  M.input_win_height = 1
  M.input_win_style = "minimal"
  M.input_win_relavent = "win"
  M.input_win_border = 'double'
  M.input_col = ui.width / 2 - M.input_win_width / 2
  M.input_row = ui.height / 2 - M.input_win_height / 2

  M.openInput()
end

function M.openInput()
  local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
  fileType = fileType .. "/ "
  M.input_buf = api.nvim_create_buf(false, true)
  M.input_win = api.nvim_open_win(M.input_buf, false, {
    relative = M.input_win_relavent,
    col = M.input_col,
    row = M.input_row,
    width = M.input_win_width,
    height = M.input_win_height,
    style = M.input_win_style,
    border = M.input_win_border,
  })
  api.nvim_win_set_option(M.input_win, 'cursorline', true)
  api.nvim_set_current_win(M.input_win)
  M.setKey(M.input_buf)
  --add filetype to first line
  api.nvim_buf_set_option(M.input_buf, 'modifiable', true)
  api.nvim_buf_set_lines(M.input_buf, 0, 1, false, { fileType })

  -- set cursor on the second line
  -- and put it in insert mode
  local cursor_input = fileType:len() + 1
  api.nvim_win_set_cursor(M.input_win, { 1, cursor_input })
  api.nvim_command('startinsert')
end

function M.openPreview()
  --get the text from the input buffer
  local input_lines = api.nvim_buf_get_lines(M.input_buf, 0, -1, false)
  input_lines = input_lines[1]
  api.nvim_win_close(M.input_win, true)
  M.input_win = nil
  M.input_buf = nil
  local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
  local url = "https://cheat.sh/" .. input_lines
  local cmdcommand = "curl -s " .. url
  local output = vim.api.nvim_call_function("system", { cmdcommand })
  output = output:split('\n') -- local output = vim.fn.system(cmdcommand)
  M.main_buf = api.nvim_create_buf(false, true)
  M.main_win = api.nvim_open_win(M.main_buf, false, {
    relative = M.main_win_relavent,
    width = M.main_win_width,
    height = M.main_win_height,
    style = M.main_win_style,
    row = M.main_row,
    col = M.main_col,
    anchor = 'NW',
    border = M.main_win_border
  })
  api.nvim_set_current_win(M.main_win)
  api.nvim_win_set_option(M.main_win, 'cursorline', true)
  -- set background color for the window
  api.nvim_win_set_option(M.main_win, 'winhighlight', 'Normal:CursorLine')

  api.nvim_buf_set_option(M.main_buf, 'filetype', 'javascript')
  api.nvim_buf_set_option(M.main_buf, "modifiable", true)
  for i, line in ipairs(output) do
    line = line:gsub('[^m]*m', '')
    line = line:gsub("^[ \t]*", "")

    api.nvim_buf_set_lines(M.main_buf, -1, -1, true, { line })
  end
  M.setKey(M.main_buf)
end

function M.setKey(buf)
  if M.input_buf == nil then
    api.nvim_buf_set_keymap(buf, 'n', 'q', '<Esc>:lua require"cheat-sheet".close_win()<CR>',
      { nowait = true, noremap = true, silent = true })
  elseif M.main_buf == nil then
    api.nvim_buf_set_keymap(buf, 'n', 'q', '<Esc>:lua require"cheat-sheet".close_win()<CR>',
      { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'i', '<CR>', '<Esc>:lua require"cheat-sheet".openPreview()<CR>',
      { nowait = true, noremap = true, silent = true })
  end
end

function M.close_win()
  if M.main_win then
    api.nvim_win_close(M.main_win, true)
    M.main_win = nil
    M.main_buf = nil
  elseif M.input_win then
    api.nvim_win_close(M.input_win, true)
    M.input_win = nil
    M.input_buf = nil
  end
end

return M
