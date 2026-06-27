vim.cmd("autocmd!")

------------------------------
-- encode settings
------------------------------
vim.scriptencoding = "utf-8"

------------------------------
-- python settings
------------------------------
vim.g.python3_host_prog = os.execute("echo -n $(which python3)")

vim.fs.root(0, ".git")
