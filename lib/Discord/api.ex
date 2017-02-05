defmodule Alchemy.Discord.Api do
  @moduledoc false

  # Performs a `get` request for a url, using the provided token as authorization.
  # All discord requests need an authorization token. This info has to be given statically.
  # This doesn't support user accounts atm.
  # Returns a raw HTTPotion `response`.
  def get(url, token) do
    HTTPotion.get url, headers: ["Authorization": "Bot #{token}"]
  end

  # Performs a `patch` request, returning an HTTPotion response.
  # This isn't used too often
  def patch(url, data, token) do
    HTTPotion.patch url, [headers: ["Authorization": "Bot #{token}",
                                    "Content-Type": "application/json"],
                          body: data]
  end

  # Fetches an image, encodes it base64, and then formats it in discord's
  # preferred formatting. Returns {:ok, formatted}, or {:error, why}
  def fetch_avatar(url) do
    data = HTTPotion.get(url).body |> Base.encode64
    {:ok, "data:image/jpeg;base64,#{data}"}
  end
end
