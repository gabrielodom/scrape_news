# practice scraping news results
# Gabriel Odom
# 2025-09-16


# We have code here that we want to run:
source("R/scrape_news.r")

# We want this to run via a GitHub Action, so we need to set this up:
usethis::use_github_action()
# These options aren't helpful. I asked ChatGPT to write me one. Now that we
# have this, I'm going to commit and push to GitHub to see what happens.

# I committed my changes and pushed, but nothing happened in the Actions tab.
# Ah, maybe because the .yaml file was looking at the "master" branch instead of
# the "main" branch?
