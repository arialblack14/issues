defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

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
end
