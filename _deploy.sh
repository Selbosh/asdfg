#!/bin/sh

git config --global user.email "david@selbys.org.uk"
git config --global user.name "David Selby"

# Clones the GitHub repository to the /docs/ directory.
git clone https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git docs
cd docs

# Clears out anything already in /docs/
git rm -rf *

# Copies compiled output from the /_book/ folder to /docs/
# (_book is the default 'output_dir' in _bookdown.yml)
cp -r ../_book/* ./

# Commits + pushes everything in /docs/ to GitHub
cd ..
git add docs/
git commit -m "Update the book"
git push -q origin master
