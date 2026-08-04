
-- AstroCommunity: import any community modules here

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  
  -- This single import auto-configures TypeScript LSP, formatting, 
  -- linters, and the js-debug-adapter debugging tools flawlessly
  { import = "astrocommunity.pack.typescript" },
}
