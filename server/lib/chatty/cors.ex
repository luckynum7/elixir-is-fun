defmodule Chatty.CORS do
@moduledoc """
  Control CORS w/ [corsica](https://github.com/whatyouhide/corsica)
"""
  use Corsica.Router,
    origins: ["http://127.0.0.1:8000", ~r{^https?://(.*\.?)arcaboat\.com$}]
    # allow_credentials: true,
    # max_age: 600

  # resource "/public/*", origins: "*"
  resource "/*"
end
