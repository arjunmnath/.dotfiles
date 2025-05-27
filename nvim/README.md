# Neovim Motion Cheat Sheet

## Character Motions

Motions that move the cursor within a line or by small steps. These include **h/l** (one character left/right), **j/k** (one line down/up), and the *find* commands **f,F,t,T** (jump to a character on the line). These work with operators (e.g. `dh`, `cW`, etc.) to affect text. By default, **j/k** move by actual lines (ignoring soft-wrapped screen lines); to move by screen lines when wrap is on use `gj/gk`. The **whichwrap** option can allow `h/l` to wrap to adjacent lines if set (though this is not recommended). All of these motions are *inclusive* or *exclusive* as documented (see Vim docs).

| **Motion**           | **Description**                                                                           | **Operators** | **Notes & Nuances**                                                                              |                                   |
| -------------------- | ----------------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------------------------------------------------ | --------------------------------- |
| `h` / `l`            | Move left / right one character.                                                          | Yes           | Basic horizontal motion. Respects `whichwrap` (if `h,l` included) to wrap across lines.          |                                   |
| `j` / `k`            | Move down / up one line.                                                                  | Yes           | Moves by whole lines (ignores soft wrap). To move by screen line, use `gj` / `gk`.               |                                   |
| `f<char>`, `F<char>` | Find the next occurrence of `<char>` on the line (forward/backward); lands *on* the char. | Yes           | Example: `fa` jumps to next `a`. Case-sensitive by default.                                      |                                   |
| `t<char>`, `T<char>` | Like `f/F` but stops *just before* the character.                                         | Yes           | Example: `ta` jumps to just before the next `a`. Useful for targeting.                           |                                   |
| `;` / `,`            | Repeat the last `f/F/t/T` motion (forward / reverse).                                     | Yes           | `;` repeats in same direction, `,` repeats in opposite direction.                                |                                   |
| `0`                  | Go to first column of the line (absolute start).                                          | Yes           | Equivalent to \`                                                                                 | \` with no count; ignores indent. |
| `^`                  | Go to first non-blank character of the line.                                              | Yes           | Skips leading whitespace (like “indent”).                                                        |                                   |
| `$`                  | Go to end (last character) of the line.                                                   | Yes           | Jumps to the last character (inclusive).                                                         |                                   |
| `g_`                 | Go to the last non-blank character of the line.                                           | Yes           | Similar to `$` but stays off trailing whitespace.                                                |                                   |
| `%`                  | Jump to matching bracket/parenthesis.                                                     | Yes           | Finds the matching `()[]{}` pair. Honors the `'matchpairs'` setting (defaults include `()[]{}`). |                                   |

## Word Motions

Motions that move by words. Lowercase **w/e/b** use Vim’s “word” definition (letters, digits, and `_`), treating punctuation as word separators; uppercase **W/E/B** use “WORD” (any whitespace-separated sequence). For example, `w` jumps to the start of the next word (punctuation ends a word), while `W` jumps to the next block of text separated by whitespace only.  All work with counts and operators (e.g. `2cw`, `d3W`). See also backward variants **b/B** (to previous word/WORD) and **ge/gE** (to end of previous word/WORD).

| **Motion** | **Description**                                       | **Operators** | **Notes & Nuances**                                                                    |
| ---------- | ----------------------------------------------------- | ------------- | -------------------------------------------------------------------------------------- |
| `w`        | Forward to start of next word.                        | Yes           | A word ends at punctuation or whitespace. (Delimits on non-word chars.)                |
| `W`        | Forward to start of next WORD (whitespace-delimited). | Yes           | Treats words as only separated by spaces. Punctuation is not a delimiter (unlike `w`). |
| `e`        | Forward to end of current/next word (inclusive).      | Yes           | Jumps to last character of the word.                                                   |
| `E`        | Forward to end of current/next WORD.                  | Yes           | Like `e` but with WORD definition (skip punctuation).                                  |
| `b`        | Backward to start of previous word.                   | Yes           | Opposite of `w`.                                                                       |
| `B`        | Backward to start of previous WORD.                   | Yes           | Opposite of `W`.                                                                       |
| `ge`       | Backward to end of previous word.                     | Yes           | Like `e` but backward.                                                                 |
| `gE`       | Backward to end of previous WORD.                     | Yes           | Like `E` but backward.                                                                 |

*Use Case:* Quickly navigate through code or text by whole words.  Examples: `cw` (change word), `dw` (delete word), `d3W` (delete three WORDs). Note that `w`/`e` consider punctuation as a break, whereas `W`/`E` do not. Word motions ignore screen wrapping.

## Sentence Motions

Move by sentences, defined as ending in `.`, `!`, or `?` followed by end-of-line or space/tab. The motions **`)`** goes forward one sentence, **`(`** goes backward one sentence. Both accept a count (e.g. `2)` jumps two sentences). They work with operators (e.g. `d(` to delete backwards to start of sentence).

*Use Case:* Jump through prose or comment text one sentence at a time.  **Nuance:** By default Vim often requires two spaces after a sentence-ending punctuation in “compatible” mode, so with only one space `(`/`)` may not recognize the sentence break. Disabling compatibility (`set nocp`) or adjusting `'cpoptions'` allows single-space sentence ends.

## Paragraph Motions

Move by paragraphs, which are delimited by blank lines or certain macros. The motion **`}`** moves forward to the start of the next paragraph, and **`{`** moves backward to the previous paragraph. A paragraph is defined as text separated by at least one empty line (or by nroff-style macros in `'paragraphs'`); note that a line containing only whitespace is not itself a paragraph boundary. Both motions work with counts (e.g. `2}`) and with operators (`d}` deletes to next paragraph).

*Use Case:* Navigate or operate on blocks of text or code separated by empty lines. For example, `dap` deletes a paragraph (with text object `ap`). Paragraph motions are linewise (they move to non-blank lines).

## Text Object Motions

Text objects let operators act on syntactic units. They only work in operator-pending or visual mode. Common built-in objects include **aw/iw** (around/inside word), **aW/iW** (WORD), **as/is** (sentence), **ap/ip** (paragraph), and **at/it** (HTML/XML tag). Also pair-based objects: **a" / i"**, **a' / i'**, **a` / i`** (quotes), **a( / i(** (parentheses), **a{ / i{**, **a\[ / i\[**, **a< / i<**, etc., which select including or excluding the delimiters respectively (the “a” form includes delimiters, “i” excludes them).

| **Text Object** | **Description**                                | **Operators** | **Notes & Use**                                                |
| --------------- | ---------------------------------------------- | ------------- | -------------------------------------------------------------- |
| `aw`, `iw`      | Around/Inside a *word*.                        | Yes           | Includes/excludes surrounding spaces. e.g. `ciw`, `daw`.       |
| `aW`, `iW`      | Around/Inside a *WORD* (whitespace-delimited). | Yes           | Like above but uses large-word (`W`) rules.                    |
| `as`, `is`      | Around/Inside a *sentence*.                    | Yes           | Operates on entire sentence (like `ap/ip` but by punctuation). |
| `ap`, `ip`      | Around/Inside a *paragraph*.                   | Yes           | Includes/excludes the blank-line boundary.                     |
| `at`, `it`      | Around/Inside a *tag* (HTML/XML).              | Yes           | e.g. `dat` deletes entire tag block, `cit` changes inside tag. |
| `a"` / `i"`     | Around/Inside double quotes `""`.              | Yes           | e.g. `ci"` changes text inside quotes.                         |
| `a'` / `i'`     | Around/Inside single quotes `''`.              | Yes           |                                                                |
| `a\`` / `i\`\`  | Around/Inside backticks ` `.                   | Yes           |                                                                |
| `a(` / `i(`     | Around/Inside parentheses `()`.                | Yes           |                                                                |
| `a{` / `i{`     | Around/Inside braces `{}`.                     | Yes           |                                                                |
| `a[` / `i[`     | Around/Inside brackets `[]`.                   | Yes           |                                                                |
| `a<` / `i<`     | Around/Inside angle brackets `<>`.             | Yes           |                                                                |
| *etc.*          | Other pair delimiters (e.g. pipes, etc.)       | Yes           | Vim will find the nearest matching pair by default.            |

*Use Case:* Combine with operators to edit structured units. E.g. `diw` deletes inner word, `dap` deletes paragraph, `ci(` changes inside parentheses, `=ip` auto-formats a paragraph, etc. For block objects (like quotes or braces), the nearest matching pair to the cursor is used. See `:help text-objects` for details. (Third-party plugins add more objects if installed.)

## Screen-based Motions

These reposition the view within the window rather than moving the cursor in the file. **H** (High) moves the cursor to the top line of the window, **M** to the middle, and **L** (Low) to the bottom. All accept a count: e.g. `3H` goes to the 3rd line of the window. Other screen motions include **zt/zb/zz** which scroll the window so the current line is at top/bottom/center respectively: `zt` moves cursor line to top, `zz` centers it (preserving column), and `zb` moves it to bottom. These are not typically used with operators (they just scroll the view). Use them to quickly jump around large files or restore context (e.g. after a jump).

## Search Motions

Fuzzy navigation via pattern search. Enter **`/pattern`** to search forward or **`?pattern`** backward (use `<Enter>` to execute). Then **`n`** jumps to the next match and **`N`** to the previous. Vim also has quick-word searches: **`*`** searches forward for the word under cursor, **`#`** backward; **`g*`/`g#`** do similar but also match inside words. All can be used as motions with operators (e.g. `d/word<CR>` deletes to “word”). Search results honor options like `ignorecase`, and the setting `'wrapscan'` controls whether searches wrap around the file.

For navigating changes, **`g;`** and **`g,`** move to older or newer entries in the change list. Each change (including undo/redo) is recorded; `g;` goes to the previous change location, `g,` to the next. (Note: `.` (dot) moves to the last change, see below.) These are extremely useful for retracing edits.

## Mark/Jump Motions

Marks record positions. Lowercase marks `'a`/`` `a`` jump to mark a (line vs exact), and uppercase marks (`'A`, etc.) jump across files. \*\*`'` (single-quote) jumps to the start of a marked line; \*\*`` ` `` (backtick) jumps to the exact cursor column of the mark. The special mark `''` (two apostrophes) repeats the previous jump (line-wise), and \`\`\`\`\`\` (two backticks) repeats it exactly. Example: `''` returns to the last jump location in normal mode. The mark `.` refers to the position of the last change (so `` `.` `` goes to the precise edit spot).

Other jumps: **Ctrl-O** and **Ctrl-I** step backward/forward through the jump list (history of significant jumps). Use `:marks` to list all marks. Operators do not apply to mark motions (they just reposition the cursor).

## Count-based Motions

Any motion (and many commands) can be prefixed with a count. For example `3w` moves three words forward, `5j` moves down five lines, `10G` goes to line 10. When using with operators, counts multiply: in the sequence `[count]{operator}[count]{motion}`, the operator’s count is multiplied by the motion’s count. For example, **`2d3w`** deletes 6 words (2×3). Similarly, `3dd` deletes 3 lines. In general, `[N]{motion}` repeats the motion N times.

*Use Case:* Quickly act on multiple units. E.g. `d5e` deletes five word-ends forward, `4y$` yanks to end-of-line four times, etc.

## Fold-specific Motions

For navigating code folds, Vim provides **`zj`** and **`zk`**: `zj` moves down to the start of the next fold (closed fold counted as one) and `zk` to the end of the previous fold. These respect counts and can be used with operators (`dzj` deletes until next fold). Other fold commands: **`zc`** closes a fold under the cursor, **`zo`** opens it; **`zC`/`zO`** recursively close/open; **`zr`/`zm`** and **`zR`/`zM`** reduce/increase all fold levels (open/close many folds). These are not regular motions in that they alter folds rather than move. The `zv` command “open to reveal” the cursor line (opens just enough folds to make it visible). Fold motions generally respect the `'foldenable'` and `'foldlevel'` settings.

## Visual & Miscellaneous Motions

* **`gv`** – reselect the last visual-selection area. After you exit Visual mode (e.g. by an operation or escape), `gv` re-enters Visual with the previous range selected.
* **`.` (dot)** repeats the last edit, but **\`\`\` (backtick mark) followed by `.`** (`\``.`) jumps to the exact position of that last change (apostrophe-dot `' .` jumps to its line).
* **`^` (caret)** – a special mark for the position where the cursor was last in Insert mode (before entering Normal). You can use `^` (backtick-caret) to jump there.
* **Macros:** Not strictly motions, but note that recording (`q{register}`) and executing (`@{register}`) macros operate on these motions.

*Note:* Motions above are the core built-ins. Popular navigation plugins add their own: for example, **vim-sneak** uses `s`/`S` for char-two searches; **hop.nvim** or **leap.nvim** introduce multi-character motions (like pressing keys to jump anywhere); etc. These are not covered here unless explicitly enabled.

**Sources:** Vim’s reference (e.g. \:help motion.txt) and community documentation provide details on all above motions and their behavior. Each motion can be combined with operators (`d,c,y,>`, etc.) and often with counts for powerful text editing. Use `:help {motion}` in Neovim for full syntax.
