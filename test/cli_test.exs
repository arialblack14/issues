defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1,
                            sort_into_ascending_order: 1,
                            convert_to_list: 1]

  test "parsing -h or --help options returns `:help`" do
    assert Issues.CLI.parse_args(["-h", "anything"]) == :help
    assert Issues.CLI.parse_args(["--help", "anything"]) == :help
  end

  test "3 values returned if 3 given" do
    assert Issues.CLI.parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "uses default_count if 2 values are given" do
    assert Issues.CLI.parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w[a b c]
  end

  defp fake_created_at_list(values) do
    data = for value <- values, do: [{"created_at", value}, {"other_data", "xxx"}]
    convert_to_list(data)
  end
end
