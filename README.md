# README

Short URL generator. Forked from: https://github.com/renatomolina/shorturlchallenge

The app takes in a valid URL and creates a short version of it. There is minimal validation of the URL.

To run:
1. `bundle install`
2. `rails s`
3. go to `http://localhost:3000`

Known issues/future improvements:
1. Duplicate URLs are allowed.
2. No expiration for URLS. Eventually the system will run out of URLs.
3. Validation of urls is minimal and could be improved.
