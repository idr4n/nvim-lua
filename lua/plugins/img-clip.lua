return {
  "HakonHarnes/img-clip.nvim",
  cmd = { "PasteImage", "ImgClipDebug" },
  opts = {
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    },
  },
  keys = {
    { "<leader>pI", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
