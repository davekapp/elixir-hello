defmodule Hello.InfoSys.Wolfram do
  import SweetXml
  alias Hello.InfoSys.Result

  def start_link(query, query_ref, owner, limit) do
    Task.start_link(__MODULE__, :fetch, [query, query_ref, owner, limit])
  end

  def fetch(query_str, query_ref, owner, _limit) do
    query_str
    |> fetch_xml()
    |> xpath(~x"/queryresult/pod[contains(@title, 'Result') or
                                 contains(@title, 'Definitions')]
                            /subpod/plaintext/text()")
    |> log_xpath()
    |> send_results(query_ref, owner)
  end

  defp send_results(nil, query_ref, owner) do
    send(owner, {:results, query_ref, []})
  end

  defp send_results(answer, query_ref, owner) do
    results = [%Result{backend: "wolfram", score: 95, text: to_string(answer)}]
    send(owner, {:results, query_ref, results})
  end

  defp fetch_xml(query_str) do
    string = "https://api.wolframalpha.com/v2/query" <>
      "?appid=#{app_id()}" <>
      "&input=#{URI.encode(query_str)}&format=plaintext"
    # IO.puts("calling: #{string}")
    {:ok, {_, _, body}} = :httpc.request(String.to_char_list(string))
    # IO.puts("wolfram response body: #{body}")
    body
  end

  defp app_id, do: Application.get_env(:hello, :wolfram)[:app_id]

  defp log_xpath(result) do
    # IO.puts("result after xpath is: #{result}")
    result
  end
end
