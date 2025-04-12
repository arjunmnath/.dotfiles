### Session & Client Management

- **§ + Ctrl+X** – Lock the tmux server  
- **§ + c** – Create a new window (opens in the current pane’s directory)  
- **§ + Ctrl+D** – Detach the current session  
- **§ + * (asterisk)** – Toggle synchronized input across panes  
  > *Note: Although “*” was also mapped to list clients earlier in the file, the later binding (synchronize-panes) takes effect.*

---

### Window Navigation & Management

- **§ + H** – Switch to the previous window  
- **§ + L** – Switch to the next window  
- **§ + Ctrl+A** – Toggle to the last active window  
- **§ + Ctrl+W** – List all windows  
- **§ + w** – List all windows  
- **§ + " (double quote)** – Open the window chooser  
- **§ + R** – Rename the current window (prompts for a new name)  
- **§ + r** – Reload the tmux configuration  
- **§ + S** – Open the session chooser  
- **§ + <** – Swap the current window with the previous window  
- **§ + >** – Swap the current window with the next window  
- **M-h** (Alt/Option + h) – Switch to the previous window (non-prefix binding)  
- **M-l** (Alt/Option + l) – Switch to the next window (non-prefix binding)

---

### Pane Navigation

- **§ + h** – Move focus to the pane on the left  
- **§ + j** – Move focus to the pane below  
- **§ + k** – Move focus to the pane above  
- **(Conflict Alert)**: **§ + l** was originally set to move focus to the pane on the right but is later re-bound; see below.

---

### Pane Resizing (Using the Prefix)

- **§ + ,** – Resize the current pane 20 columns to the left  
- **§ + .** – Resize the current pane 20 columns to the right  
- **§ + -** – Resize the current pane 7 rows downward  
- **§ + =** – Resize the current pane 7 rows upward

---

### Pane & Display Actions

- **§ + z** – Toggle zoom (maximize/restore) for the active pane  
- **§ + P** – Toggle the pane border status display  
- **§ + x** – Swap the current pane with the next pane  
- **§ + Ctrl+L** – Refresh the client display  
- **§ + l** – Refresh the client display  
  > *Note: This re-binds “l” so that it no longer switches to the right pane as originally assigned.*  
- **§ + K** – Clear the current pane (sends the clear command)  
- **In Copy Mode (vi)**: Press **v** – Begin text selection

---

### Window Splitting

- **§ + s** – Split the window vertically (using current pane’s directory)  
- **§ + -** – Split the window vertically (duplicate binding)  
- **§ + v** – Split the window horizontally (using current pane’s directory)  
- **§ + |** – Split the window horizontally (using current pane’s directory)
