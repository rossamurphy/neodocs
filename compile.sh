#!/bin/zsh

# Find the root of the repository
ROOT_DIR=$(git rev-parse --show-toplevel)

# Find all .md files that have changed since the last compilation, excluding README.md in the root directory
find "$ROOT_DIR" -type f -name '*.md' ! -path "$ROOT_DIR/README.md" -print0 | while IFS= read -r -d '' md_file; do
  # Create a timestamp file for each markdown file
  TIMESTAMP_FILE="${md_file}.timestamp"

  # If the timestamp file does not exist, create it with an old date
  if [[ ! -f "$TIMESTAMP_FILE" ]]; then
    touch -t 197001010000 "$TIMESTAMP_FILE"
  fi

  # Check if the file was modified after the last compilation
  if [[ "$md_file" -nt "$TIMESTAMP_FILE" ]]; then
    # Extract the filename without the extension
    base_name="${md_file%.md}"

    # Compile the .md file to a PDF with LaTeX math support
    pandoc \
      --from=gfm+tex_math_dollars \
      --to=pdf \
      --template=template.tex \
      -F mermaid-filter \
      "$md_file" \
      -o "${base_name}.pdf"

    echo "Compilation complete: ${base_name}.pdf"

    # Update the timestamp file to the current time
    touch "$TIMESTAMP_FILE"
  fi
done

