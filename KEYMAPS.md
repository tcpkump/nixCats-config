# Keymaps & Commands

**Leader = `<Space>`, Local leader = `,`**

---

## Files & Search (Snacks Picker)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find file |
| `<leader>fo` | Recent files |
| `<leader>fw` | Grep in files |
| `<leader>fl` | Grep in LSP root |
| `<leader>fr` | Find & replace (grug-far) |
| `<leader>:` | Command history |
| `<leader>km` | Search keymaps |

### Picker Query Syntax

| Pattern | Behavior |
|---------|----------|
| `foo bar` | Fuzzy match both terms (AND) |
| `'foo` | Exact match |
| `^foo` | Match start of string |
| `foo$` | Match end of string |
| `!foo` | Exclude matches containing "foo" |
| `query #lua` | Filter results to `.lua` files |
| `query #src/` | Filter results to paths under `src/` |
| `query #.go` | Filter results to `.go` extension |

The `#` suffix is matched against the file path and works in any file picker.

---

## Git

| Key | Action |
|-----|--------|
| `<leader>gd` | Difftastic: all uncommitted changes vs HEAD (float) |
| `<leader>gD` | Difftastic: staged changes only (float) |
| `<leader>gb` | Difftastic: current branch vs main (float) |
| `<leader>gg` | Open Lazygit |
| `<leader>gm` | Modified files (git status picker) |
| `<leader>gcb` | Buffer commit log |
| `<leader>gcc` | All commits log |
| `<leader>gy` | Copy git permalink to clipboard (gitlinker) |
| `<leader>gY` | Open git permalink in browser (gitlinker) |

---

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gt` | Go to type definition |
| `gr` | Find references |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cd` | Show diagnostic float |
| `[d` / `]d` | Prev / Next diagnostic |

---

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Next / Prev item |
| `<CR>` | Accept |
| `<C-e>` | Hide menu |
| `<C-Space>` | Show / toggle docs |
| `<C-d>` / `<C-u>` | Scroll docs down / up |

---

## Windows & Splits (smart-splits)

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move cursor between splits |
| `<C-\>` | Move to previous split |
| `<A-h/j/k/l>` | Resize split |
| `<leader><leader>h/j/k/l` | Swap buffer in direction |

---

## File Tree (Snacks Explorer)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle Explorer |

---

## Editing

| Key | Action |
|-----|--------|
| `<C-s>` | Save file (normal / insert / visual) |
| `<leader>y` | Yank to system clipboard |
| `<leader>d` | Delete without yanking |
| `p` (visual) | Paste, preserve yank register |
| `n` / `N` | Next / Prev search result (centered) |
| `gcc` | Toggle line comment (mini.comment) |
| `gc` (visual) | Toggle comment block |
| `<leader>sx` | Switch word forward (true↔false, yes↔no, up↔down, on↔off, row↔column) |
| `<leader>sX` | Switch word reverse |

---

## Surround (mini.surround)

| Key | Action |
|-----|--------|
| `sa` | Add surrounding (e.g. `saiw"` wraps word in quotes) |
| `sd` | Delete surrounding |
| `sr` | Replace surrounding |
| `sf` / `sF` | Find surrounding (right / left) |
| `sh` | Highlight surrounding |

---

## Terraform

| Key | Action |
|-----|--------|
| `<leader>tfi` | `terraform init -upgrade` in buffer directory |
| `<leader>tfp` | `terraform plan` in buffer directory |

---

## Obsidian

Vault path: `~/obsidian`. Commands use the form `:Obsidian <subcommand>` (e.g. `:Obsidian today`).

| Key | Action |
|-----|--------|
| `<leader>od` | Open today's daily note |
| `<leader>on` | New note |
| `<leader>oq` | Quick switch note |
| `<leader>os` | Search vault |

---

## Todo Comments

Keywords: `TODO:` `FIX:` / `FIXME:` `HACK:` `WARN:` `NOTE:` `PERF:` `TEST:`

| Command | Action |
|---------|--------|
| `:TodoQuickFix` | List all todos in quickfix |
| `:TodoTelescope` | Browse todos in picker |
