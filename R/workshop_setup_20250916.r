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


# Now I'm going to add an option to run this every Wednesday at 1:13AM
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
# Possible fix: I'm going to pre-append "./" to "data_news/".
# Ok, that didn't work. So, Git automatically ignores empty directories. Right
# now, the data_news/ directory doesn't exist on GitHub. I'm going to put an
# empty text file in there to make sure that GitHub can find the subdirectory.
# Finally!!!


# Third error:
# Error in `req_perform()`:
#   ! HTTP 401 Unauthorized.
# Backtrace:
#   ▆
# 1. └─httr2::req_perform(req, path = paste0("./data_news/", date, ".json"))
# 2.   └─httr2:::handle_resp(req, resp, error_call = error_call)
# 3.     └─httr2:::resp_failure_cnd(req, resp, error_call = error_call)
# 4.       ├─rlang::catch_cnd(...)
# 5.       │ ├─rlang::eval_bare(...)
# 6.       │ ├─base::tryCatch(...)
# 7.       │ │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
# 8.       │ │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
# 9.       │ │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
# 10.       │ └─base::force(expr)
# 11.       └─rlang::abort(...)
# Execution halted
# Error: Process completed with exit code 1.
# So we need to make sure to point to the API key in a place that GitHub can
# find it. First, we need to set the API key in GitHub; so we go to settings for
# the repository, then scroll down to Secrets and Variables, click on Actions,
# then add a repository secret. Create a secret named NEWS_API_KEY then store
# the value in the matching field. Then, we also need the configuration file to
# tell GitHub where to find that key. So, in the section for "Run your script",
# add an environment variable with:
# env:
#   NEWS_API_KEY: ${{ secrets.NEWS_API_KEY }}
# YAY it worked!!!


# Ok, so this code works (runs without errors), but it doesn't **do** anything.
# Well, it "does" what the script says it should do, but I haven't added an
# action to save the results. Thus, if I pull after the GitHub Action completes,
# there are no changes. In order to get the changes to "save" after an Action,
# the action should make a commit to the repo. Here is an action to do that:
# - uses: stefanzweifel/git-auto-commit-action@v5
# Let's try it out


# Fourth Error
# INPUT_PUSH_OPTIONS:
#   remote: Permission to gabrielodom/scrape_news.git denied to github-actions[bot].
# fatal: unable to access 'https://github.com/gabrielodom/scrape_news/': The requested URL returned error: 403
# Error: Error: Invalid status code: 128
# at ChildProcess.<anonymous> (/home/runner/work/_actions/stefanzweifel/git-auto-commit-action/v5/index.js:17:19)
# at ChildProcess.emit (node:events:524:28)
# at maybeClose (node:internal/child_process:1104:16)
# at ChildProcess._handle.onexit (node:internal/child_process:304:5) {
#   code: 128
# }
# Error: Error: Invalid status code: 128
# at ChildProcess.<anonymous> (/home/runner/work/_actions/stefanzweifel/git-auto-commit-action/v5/index.js:17:19)
# at ChildProcess.emit (node:events:524:28)
# at maybeClose (node:internal/child_process:1104:16)
# at ChildProcess._handle.onexit (node:internal/child_process:304:5)

# Stackoverflow tells me: "You have to configure your repository - Settings ->
# Action -> General -> Workflow permissions; choose the radio button for "Read
# and write permissions", then Save. Now go back to Actions and Re-Run Jobs.
# Now, at the completion of the Action, I can "pull" the changes from GitHub to
# my local machine.

