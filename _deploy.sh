#!/usr/bin/env

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

# Clones the GitHub repository to the /docs/ directory.
git clone https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git docs
cd docs

# Clears out anything already in /docs/
git rm -rf *

# Copies compiled output from the /_book/ folder to /docs/
# (_book is the default 'output_dir' in _bookdown.yml)
cp -r ../_book/* ./

# Commits + pushes everything in /docs/ to GitHub
git add --all *
git commit -m "Update the book"
git push -q origin master