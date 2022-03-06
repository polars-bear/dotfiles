vim.cmd [[
try
  colorscheme monokai_pro 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme pablo 
  set background=dark
endtry
]]
