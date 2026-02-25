# Hướng dẫn cài đặt và sử dụng Gitsigns

Gitsigns là plugin Neovim hiển thị các dấu hiệu git (git signs) trong gutter (vùng bên trái dòng). Plugin này giúp bạn dễ dàng nhìn thấy những thay đổi trong file mà không cần sử dụng câu lệnh git.

## Cài đặt

Thêm vào file cấu hình plugin (ví dụ: `lua/plugins/init.lua` hoặc sử dụng lazy.nvim):

```lua
{
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end
}
```

## Tính năng

- Hiển thị các dòng đã thêm, sửa đổi, hoặc xóa
- Hiển thị số dòng thay đổi trong gutter
- Xem chi tiết hunk (khối thay đổi) bằng `:Gitsigns`
- Preview các thay đổi
- Stage và unstage từng hunk

## Các lệnh cơ bản

| Lệnh | Mô tả |
|------|-------|
| `Gitsigns` | Mở menu gitsigns |
| `:Gitsigns preview_hunk` | Xem trước hunk hiện tại |
| `:Gitsigns stage_hunk` | Stage hunk hiện tại |
| `:Gitsigns reset_hunk` | Hoàn tác hunk hiện tại |
| `:Gitsigns toggle_deleted` | Hiển/ẩn các dòng đã xóa |

## Cấu hình mẫu

```lua
require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  numhl = true,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
})
```

## Phím tắt mặc định

- `]c` - Chuyển đến thay đổi tiếp theo
- `[c` - Chuyển đến thay đổi trước đó
- `ghs` - Stage hunk
- `ghr` - Reset hunk
- `ghp` - Preview hunk

Bạn có thể tùy chỉnh các phím tắt này trong file cấu hình mapping.

---

**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
