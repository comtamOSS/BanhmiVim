local call_if_config_true = function(condition, action)
  if condition then
    action()
  end
end

local autocmd_config = require("config.banhmivim").autocmd

call_if_config_true(autocmd_config.highlight_yank, function ()
     require("autocmd.highlight_yank")
end)

call_if_config_true(autocmd_config.no_auto_comment_on_new_line, function ()
     require("autocmd.no_auto_comment_on_new_line")
end)

call_if_config_true(autocmd_config.remove_trailing_whitespace_on_save, function ()
     require("autocmd.remove_trailing_whitespace_on_save")
end)

call_if_config_true(autocmd_config.restore_position_in_last_time_edit, function ()
     require("autocmd.restore_position_in_last_time_edit")
end)

call_if_config_true(autocmd_config.show_cursorline_only_in_active_window, function ()
     require("autocmd.show_cursorline_only_in_active_window")
end)

call_if_config_true(autocmd_config.syntax_highlight_for_dotenv_file, function ()
     require("autocmd.syntax_highlight_for_dotenv_file")
end)

call_if_config_true(autocmd_config.virtualtext_for_heading, function ()
     require("autocmd.virtualtext_for_heading")
end)




