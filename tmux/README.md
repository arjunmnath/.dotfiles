# tmux shortcuts

## window management
- `prefix + c` - create new window 
- `prefix + n` - next window
- `prefix + p` - previous window
- `prefix + <index>` - go to window with index 
- `prefix + :swap-window <options>` - change the order of windows
- `prefix + &` - kill the window

## pane management
- `prefix + -` - horizontal split
- `prefix + |` - vertical split
- `prefix + <arrow key>` - pane navigation
- `ctrl + <h | j | k | l>` - pane navigation with vim motions
- `prefix + < { | } >` - swap panes
- `prefix + q` - show pane indexes
- `prefix + q + <index>` - select pane with index 
- `prefix + z` - zoom current pane into full screen
- `prefix + !` - turn pane into window
- `prefix + x` - close current pane


## session management
- `tmux` - create an unnamed session
- `tmux new -s <name>` - create named session
- `prefix + :new` - create an unnamed session when inside a session
- `prefix + :new` - create an unnamed session when inside a session
- `tmux ls` - list all active sessions
- `prefix + s` - list all active sessions when inside a session
- `prefix + w` - preview all windows in active sessions when inside a session
- `tmux attach` or `tmux a`- attach to most recent session 
- `tmux attach -t <name>` or `tmux a -t <name>` - attach to a specific session
- `prefix + I` - reload tmux environment installing plugins