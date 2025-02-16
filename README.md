
# Why?

I write all of my code in NeoVim. I've spent a lot of time tweaking my config, in a bid to make me as efficient as possible while writing code. It feels silly to me, that whenever I need to write a "real-world" document (read: PDF), I have to go and use a completely unconfigurable text editor, like Microsoft Word, or Apple Pages. I want to be able to write beautiful long-form documents, without having to endure the straitjacket of conventional word-processing software. I couldn't find any solution, so I built this one.

# What can I do with this?

This lets you write write your documents in Markdown format, in your favourite terminal. Use e-macs, neovim, classic vim, anything you like, really. Just write Markdown, be happy, be free. Once you click save, this will auto-compile your work to a nice-looking PDF. 

# How do I get started?

Pandoc and basictext (for compilation), skim (for viewing), and entr (for file watching)
```zsh
brew install basictex pandoc skim entr
```
Mermaid filter for rendering mermaid charts
```zsh
npm install --global mermaid-filter
```

Or, just run
```zsh
make install
```

Make the compile.sh and the watcher.sh scripts executable
```zsh
chmod +x ./compile.sh
chmod +x ./watcher.sh
```

# How do I use it?

## Option 1 - Manually run the ./compile.sh script when you want to

- Create / edit any .md file in the directory.
- When you're ready, run the compile script `./compile.sh`.
- All modified Markdown files will be compiled to PDF.
- The PDF files will have the same name as each of the Markdown files, and will
  be in the same directory as each of the Markdown files.

### How does this 'compile script' actually work?

- The compile script compares the LAST-UPDATED time of each file with its
  LAST-COMPILATION time.
- It only does this for Markdown files (ending in .md), and does NOT do this
  for the README.md in the top level of the directory (i.e. this file).
- It gets the LAST-UPDATED time of each file using entr.
- It gets the LAST-COMPILED time of each file from a hidden file called
  <FILENAME>.timestamp.
- This hidden timestamp file is created if it does not exist, and/or updated
  for each updated file each time you run the compile script.
- This ensures that you only re-compile the updated files, and not every file
  in the directory (which would be slow).
- This is preferred to git diff, because comparing it to git diff (rather than
  each individual file's last update time) would mean files would continuously
  get re-compiled every time you ran the script until you committed your changes. 

## Option 2 - Let a file watcher do it for you 

- Run the ./watcher.sh script. 
- The watcher script watches for changes to markdown files in the git directory.
- If a change is detected, the ./compile.sh script is run automatically.
- To stop the script, just ctrl-c in the terminal.
- If you lose the process it's running in, you can find it by doing `ps aux |
  grep watcher.sh`. 


# A nice set up

- Split a full screen window, with vim on the left-hand-side, and skim on the right-hand-side.
- Open a PDF (from the directory) in skim.
- Open skim settings, go to "Sync", tick "Check for file changes" and "reload automatically". 
- Open another little tmux pane at the bottom of your vim window.
- Run `./watcher.sh` in that terminal there.
- Go back to vim.
- Make a change to the markdown file which is the source of the PDF (open in Skim).
- Watch the PDF immediately auto-update without you having to do anything.
- Celebrate, I guess?
