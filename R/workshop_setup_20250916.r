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
# YAY! The GitHub Action is actually working. Not sure if it will run without
# errors, but something is happening.

# First error:
# Run Rscript scrape_news.R
# Fatal error: cannot open file 'scrape_news.R': No such file or directory
# Error: Process completed with exit code 2.
# I think this is because the script is in R/. Let's fix that.


# Second error:
# Error in `req_perform()`:
#   ! Failed to perform HTTP request.
# Caused by error in `curl::curl_fetch_disk()`:
#   ! Failed to open file data_news/2025-09-15.json.
# Backtrace:
#   ▆
# 1. └─httr2::req_perform(req, path = paste0("data_news/", date, ".json"))
# 2.   └─httr2:::handle_resp(req, resp, error_call = error_call)
# 3.     └─rlang::cnd_signal(resp)
# Execution halted
# Error: Process completed with exit code 1.
# Possible fix: I'm going to pre-append "./" to "data_news/"

# Third error:

# So we need to make sure to point to the API key in a place that GitHub can
# find it. First, we need to set the API key in GitHub; so we go to settings for
# the repository, then scroll down to Secrets and Variables, click on Actions,
# then add a repository secret. Create a secret named NEWS_API_KEY then store
# the value in the matching field. Then, we also need the configuration file to
# tell GitHub where to find that key. So, in the section for "Run your script",
# add an environment variable with:
# env:
#   NEWS_API_KEY: ${{ secrets.NEWS_API_KEY }}
