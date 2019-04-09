defmodule Issues.GithubIssues do
  require Logger

  @user_agent [{"User-agent", "Elixir tsirasalexis@yahoo.gr"}]

  def fetch(user, project) do
    Logger.info("Fetching user #{user}'s project #{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp handle_response(%{status_code: 200, body: body}), do: {:ok, :jsx.decode(body)}

  defp handle_response(%{status_code: status, body: body}) do
    Logger.error("Error #{status} returned")
    {:error, :jsx.decode(body)}
  end

  @github_url Application.get_env(:issues, :github_url)

  defp issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end
end
