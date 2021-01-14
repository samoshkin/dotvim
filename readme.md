
# dotvim

Personal Vim configuration designed in a modular way.

**A warn note**. I tested it on my local machine only so far. Most likely it depends on my own environment (terminal, OS, installed apps) in some unforeseen ways. With that said, I cannot guarantee the smooth experience on your machine. Be prepared to fix issues on your own.

**Tested under**:

- vim @8.2 (Included patches: 1-2100)
- iTerm2 @3.3.7
- tmux @3.1c
- MacOS Catalina @10.15.7

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Mappings](#mappings)
- [Text objects](#text-objects)
- [IDE-like experience using language servers](#ide-like-experience-using-language-servers)
- [Modular configuration](#modular-configuration)
- [Plugins](#plugins)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Features

- Wide **languages support** via [vim-polyglot](https://github.com/sheerun/vim-polyglot)
- **Motion**. Respect display lines when text is soft wrapped. Smooth scroll for `<C-u>`, `<C-d>`,`<C-f>`, `<C-b>` page movements. Recenter screen after most motions. Includes a bunch of useful text objects: line, url, entire buffer, matchit `%` region, lines with same indentation, current fold, function/class, etc. Improved `f` and `t` movements via [clever-f](https://github.com/rhysd/clever-f.vim) plugin.
- **Text manipulation** commands and mappings. Insert new line above or below the cursor. Move lines around. Duplicate line. Delete/change/yank to start/end of the line. Split and join lines. Switch between a single-line statement and a multi-line one (if, for, function calls). Move function arguments around.
- **IDE-like features** powered by [coc.nvim](https://github.com/neoclide/coc.nvim) and language servers. Go to definfion, peek into defintion in a preview window, find symbol references, search through document or workspace symbols, rename and refactor, highlight symbol under the cursor. Open a drawer with a tree-view outline of document symbols powered by [vista.vim](https://github.com/liuchengxu/vista.vim).
- **Insert mode completion** (a.k.a `IntelliSense`) provided by [coc.nvim](https://github.com/neoclide/coc.nvim) and language servers.
- **Lint your files** with a linter program of your choice and show diagnostic icons in the Vim's sign column on the left. Populate location list with a linter errors and navigate through them. Apply quick fix action to resolve the issue if provided by the language server.
- Expad **snippets** for various languages as provided by [honza/vim-snippets](https://github.com/honza/vim-snippets)
- Instant **project-wide text search** as you type using [ripgrep](https://github.com/BurntSushi/ripgrep) and [fzf](https://github.com/junegunn/fzf). Live preview of a file and a line with match with syntax highlight enabled.
- **Fuzzy find for project or MRU files** in an integrated [fzf](https://www.url.com) popup. Use fuzzy finder to look up for other things: Vim commands, help tags, opened buffers, tags, lines in the buffer. Enjoy live file previews as you search with syntax highlighting enabled.
- **Formatting**. Format as-you-type when supported by a language server. Format whole buffer by [Neoformat](https://github.com/sbdchd/neoformat) and CLI tools like [Prettier](https://prettier.io/), [stylefmt](https://github.com/morishitter/stylefmt), [js-beautify](https://github.com/beautify-web/js-beautify) and others. Formatting can be automatically triggerred on save, on leaving the insert mode, or manually on demand. If there's neither language server no dedicated format programs installed, it's still capable of removing trailing whitespaces at EOL and trailing new lines at EOF, changing indentation between tabs and spaces. Editorconfig support.
- **Buffer and window management.** Working with split and tabs with ease. Copy file name or path. Maximize current split. Cycle between main and alternate buffer and tab. Smart quit window function.
- **Pick and open files** using either [nnn](https://github.com/jarun/nnn) or [NERDTree](https://github.com/preservim/nerdtree). Locate current file or explore project structure in a NERDTree drawer on the left side.
- **File type icons** in a [NERDTree](https://github.com/preservim/nerdtree) and status line. Icons support requires using one of the [NerdFont](https://www.nerdfonts.com/) as your terminal's font.
- Use Vim **as a Git difftool or mergetool**. Disabled syntax highlighting in a diff mode.
- **Git integration** powered by [fzf](https://github.com/junegunn/fzf), [vim-fugitive](https://github.com/tpope/vim-fugitive) and [vim-gitgutter](https://github.com/airblade/vim-gitgutter). Browse git log, review commits and file diffs, browser Git object database (commits, trees, block), review `git status` files and make a commit. Undo, stage or preview diff hunks while working with a buffer.
- **Status line** powered by [lightline](https://github.com/itchyny/lightline.vim) that includes only essential pieces of data. No bloated UI with heavy computations.
- **vim + tmux play nice together**. `<C-arrow>` and `<S-arrow>` keys work smoothly. `FocusGained` and `FocusLost` events are properly captured by Vim (via [tmux-plugins/vim-tmux-focus-events](https://github.com/tmux-plugins/vim-tmux-focus-events)). `<S-CR>` and `<C-CR>` keys are added by configuring [iTerm](https://iterm2.com/) to send custom escape sequence. Different cursor shape is applied depending on the current mode.
- **Better quickfix and location lists** with [romainl/qf-vim](https://github.com/romainl/vim-qf)
- Opt-in **auto-save behavior**.
- **Save and restore Vim session**. Session is associated with a particular directory. Thus, you can have an unique session for every project.
- Better **yank and paste behavior**. Improved by [vim-cutlass](https://github.com/svermeulen/vim-cutlass), [vim-yoink](https://github.com/svermeulen/vim-yoink) and [vim-subversive](https://github.com/svermeulen/vim-subversive) plugins.
- Use [universal-ctags](https://github.com/universal-ctags/ctags) to generate tags file when there's no language server support for the given file type.
- **Markdown support** with live preview, syntax highlighting, fenced code block languages, TOC generation.
- [gruvbox](https://github.com/morhetz/gruvbox) color scheme


## Screenshots

- [Screen #1](https://i.imgur.com/faCgH9u.png). Multiple split windows with different file types. Two versions of status line - for active and inactive windows. Sign column with a diff hunk "added/changed/removed" indicators. Insert mode completion. Inline colors for "#hex" colors in CSS. [gruvbox](https://github.com/morhetz/gruvbox) colorscheme.
- [Screen #2](https://i.imgur.com/lrcK8CN.png). Pick files or explore project structure using [NERDTree](https://github.com/preservim/nerdtree) or an integrated [nnn](https://github.com/jarun/nnn) file manager.
- [Screen #3](https://i.imgur.com/YW2F3JK.png). Peek into symbol definition in a preview window at the bottom. Tree-view drawer with a document symbols outline on the right side.
- [Screen #4](https://i.imgur.com/qJMgh5m.png). View linter and syntax errors for the current line in a popup. Sign column with a bug icons of different color depending on an issue level. List of all diagnostic issues within a file at the bottom.
- [Screen #5](https://i.imgur.com/BwecrD4.png). Explore Git internal object database. Review commit, file tree or a file snapshot at that specific commit.
- [Screen #6](https://i.imgur.com/5oAI3Dr.png). Use Vim as a git difftool.
- [Screen #7](https://i.imgur.com/QdImwJb.png). Text-based project search showing results in a quickfix window.
- [Screen #8](https://i.imgur.com/Jo1ubpy.png). Fuzzy find and open files in a popup with a live file preview on the right side.
- [Screen #9](https://i.imgur.com/Qlv9mKq.png). Another use case for fuzzy finder. Search available Vim commands and execute them on selection.
- [Screen #10](https://i.imgur.com/nEGq8AG.png). Text-based project search showing results in a fuzzy finder popup with a live preview of the particular match on the right side.
- [Screen #11](https://i.imgur.com/vQflvfw.png). Writing markdown file with a side-by-side live preview in a browser.

## Installation

```bash
git clone https://github.com/samoshkin/dotvim ~/.vim
cd ~/.vim
./install.sh
```

Required external dependencies. Make sure they are installed and are available on `PATH`:

- [fzf](https://github.com/junegunn/fzf), A command-line fuzzy finder.
- [nnn](https://github.com/jarun/nnn), n³ The unorthodox terminal file manager.
- [delta](https://github.com/dandavison/delta), A viewer for git and diff output.
- [rg](https://github.com/BurntSushi/ripgrep), modern and fast `grep` replacement.
- [bat](https://github.com/sharkdp/bat), cat(1) clone with syntax highlighting.
- Change your terminal's font to one of the [NerdFont](https://www.nerdfonts.com/) family (e.g. DroidSansMono NerdFont). This is needed to render file type icons.
- [universal ctags](https://github.com/universal-ctags/ctags). [exuberant-ctags](http://ctags.sourceforge.net/) do not fit.
- git



## Mappings

Most native Vim mappings work as you expect. This config follows and builds upon the ideology and spirit of the Vim, rather than fighting against it.

`leader` and `localleader` are mapped as:

```vim
nnoremap <Space> <Nop>
let mapleader=" " "<Space>
let maplocalleader=","
```

Toggle various settings/feature ON and OFF with a uniform mapping that starts with `<leader>t`, for example:

```vim
nmap <leader>ts     :ToggleSyntax<CR>
nmap <leader>th     :set hlsearch!<CR>
nmap <leader>tl     <Plug>(qf_loc_toggle_stay)
nmap <leader>tq     <Plug>(qf_qf_toggle_stay)
nmap <leader>tt     :GutentagsToggle<CR>
nmap <leader>t{}    :DelimitMateSwitch<CR>
nmap <leader>tp     :set paste!<CR>
nmap <leader>td     :GitGutterBufferToggle<CR>
nmap <leader>tw     :setl wrap!<CR>
nmap <leader>tz     :setlocal foldenable!<CR>
nmap <leader>te     :call CocAction("diagnosticToggle")<CR>
```

`<C-C>` is mapped to `<Esc>`. Use it to exit from any non-Normal mode, plus it works to exit insert completion menu, `coc.nvim` lists, various `fzf` popups. IMO, `<C-c>` is easier to type that `<ESC>` or other alternatives like `jk`. Most likely you already get used to it after working in a shell.

```vim
inoremap <C-C> <ESC>
noremap <C-C> <ESC>
vnoremap <C-C> <ESC>
```

By default terminal Vim does not distinguish `<S-CR>` and `<C-CR>` from regular `<CR>`. However, you can tell the terminal to send specific escape sequence (`\e[13;2u`, `\e[13;5u`) and instruct Vim to recognize them.

```vim
" See https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
" See https://vim.fandom.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
execute "set <F20>=\e[13;2u"
execute "set <F21>=\e[13;5u"
```

The solution is not portable, but these keys are quite useful, especially in the Insert mode:

```vim
" Shift-Enter(remapped as <F20>) to start editing new line below without splitting the current one
" Ctrl-Enter(remapped as <F21>) to start editing new line above
inoremap <F20> <C-o>o
inoremap <F21> <C-o>O
```

When Vim is running inside tmux, `<S-arrow>` and `<C-arrow>` keys are not delegated by tmux downwards to the Vim. To enable it, you need to change your `tmux.conf`:

```
set -wg xterm-keys on
```

Even despite that, Vim's still not able to automatically recognize `<S-arrow>` and `<C-arrow>` keys when `tmux` reports itself as a `screen-256color`. This is due to the lack of data in a `terminfo` database for that terminal type. To fix it manually tell Vim about right escape sequences:

```vim
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif
```

## Text objects

There're a bunch of custom text objects installed. The "Zen" of vim is that you're speaking a language. Grammar consists of basic vocabulary: verbs, modifiers, nouns. The text objects extend the vocabulary of available `{nouns}`.

```
iW aW, WORD
iw aw, word
is as, sentence
ip ap, paragraph

i' a', single quotes
i" a", double quotes
i` a`, back ticks
iq/aq, between any quote

i( a(, parenthesis
i[ a[, brackets
i{ a{, bracnes
i> a>, angle brackets
ib/ab, between any paretheses and braces

if/af, function (when supported by the language server)
ic/ac, class (when supported by the language server)
ia/aa, function arguments

ie/ae, entire file
il/al, current line
ii/ai, block of lines with same indentation
iy/ay, syntax highlights
iu/au, URIs
iv/av, variable segement of lower_case or camelCase
iz/az, block of folded lines
ih/ah, vim-gitgutter diff hunks
im/am, to select matchit % pairs
ib/ab, text between parentheses and braces ( [ { <

gc,    commented text
```

## IDE-like experience using language servers

[Language server](https://langserver.org/) integration brings highly important features that are usually found only in IDEs. To enumerate most prominent ones:

- go to symbol definition
- find symbol references
- search through document or project-wide symbols
- show documentation of the symbol under the cursor
- insert mode completion based on suggestions from the language server (a.k.a `IntelliSense` in the Microsoft realm)
- code formatting. Unlike tools like `Prettier`, the language server is capable enough to properly format the region of the text without reformatting the whole file. For example, format function body or the text range you just altered in the Insert mode.
- code linting

[coc.nvim](https://www.url.com) is the Vim plugin that represent the client-side of the LSP protocol, whereas language server itself should be installed separately. Each language server usually takes care of a particular file type or a language. To mention some of them: [tsserver](https://www.url.com), [vim-lsp](https://www.url.com), [vscode-json-languageservice](https://www.url.com), [bash-language-service](https://www.url.com)

[coc-extensions](coc-extensions.json) file is just a normal `package.json` file that declares installed language servers. Extensions should be installed in a special folder, and `install.sh` script takes care of it:

```bash
mkdir -p "~/.config/coc/extensions"
ln -sf "~/.vim/coc-extensions.json" "~/.config/coc/extensions/package.json"
pushd ~/.config/coc/extensions
yarn install
popd
```

[coc-settings.json](coc-settings.json) is the main configuration file for `coc.nvim` itself plus any language server you installed before. To open it from inside the Vim, use `:CocConfig` command.

Code linting is done through the [coc-diagnostic](https://www.url.com) language server. It's a special one because it's not limited to support single file type, but allows you to plug any linter program and lint any file. Checkout [coc-settings.json]() for the configuration:

```json
"diagnostic-languageserver.filetypes": {
  "vim": "vint",
  "email": "languagetool",
  "markdown": [ "write-good", "markdownlint" ],
  "sh": "shellcheck",
  "javascript": ["eslint"],
  "javascriptreact": ["eslint"],
  "scss": ["stylelint"],
  "sass": ["stylelint"],
  "less": ["stylelint"],
  "css": ["stylelint"]
}
```

Note, that [dense-analysis/ale](https://www.url.com) is not used in this config.


## Modular configuration

Unlike most `.vim` configuration on the internet, this one does not keep hundreds of settings kept in a single giant `vimrc` file. On the contrary, settings and functions are broken down into the individual files, with a respect to Vim guidelines.

- `vimrc`, the main entry point of Vim configuration. Is executed first. Keeps only few settings and lists installed plugins.
- `plugin/`, any file in this directory is automatically sourced by Vim, however don't rely on the execution order. Most configuration is kept here, with each file limited to a specific aspect or a single plugin.
- `after/`, files in this directory are guaranteed to run after `vimrc` and `plugin/*` files.
- `after/ftplugin`, keeps settings that are unique only for the particular file type.
- `after/syntax`, defines regular expressions to match various syntax groups in a file of a given file type. Syntax highlighting relies on the extracted syntax groups
- `after/colors`, syntax highlight and color customization for a particular colorscheme
- `autoload/_`, custom functions are defined here. Functions are lazy loaded when used by a command or a mapping. Weird `_` directory name is used as a private namespace for my own functions, so they don't conflict with functions defined in other plugins.
- `coc-extensions.json` and `coc-settings.json` are files related to `coc.nvim` plugin and language server configuraton.
- `filetype.vim`, associate the file with a file type by looking at file extension. Once file type is set, `ftplugin/{filetype}.vim` files are sourced.
- `Ultisnips/`, user-defined snippets.

Here is the `.vim` directory outline:

```
├── after
│  ├── colors
│  │  └── gruvbox.vim
│  ├── ftplugin
│  │  ├── git.vim
│  │  ├── gitcommit.vim
│  │  ├── markdown.vim
│  │  ├── scss.vim
│  ├── plugin
│  │  └── colorscheme.vim
│  └── syntax
│     ├── gitcommit.vim
│     ├── json.vim
│     └── nerdtree.vim
├── autoload
│  ├── _
│  │  ├── buffer.vim
│  │  ├── diff.vim
│  │  ├── fugitive.vim
│  │  ├── mixedwhitespace.vim
│  │  ├── qfloc.vim
│  │  ├── search.vim
│  │  ├── session.vim
│  │  ├── util.vim
│  │  └── window.vim
│  └── plug.vim
├── coc-extensions.json
├── coc-settings.json
├── deprecated
│  ├── plug_ale.vim
│  └── plug_findfiles.vim
├── filetype.vim
├── install.sh
├── nerdtree_plugin
│  ├── copy_path_to_clipboard.vim
│  └── gitignore_filter.vim
├── plugin
│  ├── buffer.vim
│  ├── colors.vim
│  ├── command.vim
│  ├── diagnostic.vim
│  ├── diff.vim
│  ├── motion.vim
|  |   ...........
│  ├── plug_cleverf.vim
│  ├── plug_coc.vim
│  ├── plug_commentary.vim
│  ├── plug_delimitmate.vim
│  ├── plug_editorconfig.vim
│  ├── plug_exchange.vim
├── UltiSnips
└── vimrc
```

## Plugins

[vim-plug](https://www.url.com) is used as a plugin manager. All plugin dependencies are pinned to a specific commit for repeatable and stable installations.

```vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }, 'commit': '8c533e3' }
Plug 'junegunn/fzf.vim', { 'commit': '811b860' }
Plug 'pbogut/fzf-mru.vim', { 'commit': 'c0a6bda' }
```

For the full list of plugins, checkout main [vimrc](vimrc) file or use `:PlugStatus` command.

