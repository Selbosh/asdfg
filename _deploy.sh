#!/bin/sh

git config user.name "David Selby"
git config user.email "david@selbys.org.uk"

git checkout -b temporary_branch

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
git add docs
git commit -m "Update the book [ci skip]"

# Reconcile any detached heads
git checkout master
git commit -m "Update the book 2 [ci skip]"
git rebase temporary_branch

git push -q origin master