# Script to scrape news
# Gabriel Odom
# 2025-09-16


library(httr2)

date <- Sys.Date() - 1
req <- request("https:///newsapi.org/v2/everything") %>%
  req_url_query(
    # keyword here:
    q = '`"data science"`',
    from = date,
    pageSize = 10,
    # notes for how to set this are in the diamonds/ repo
    apiKey = Sys.getenv("NEWS_API_KEY")
  )
req_perform(req, path = paste0("./data_news/", date, ".json"))
