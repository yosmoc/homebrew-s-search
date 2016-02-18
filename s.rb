require "language/go"

class S < Formula
  desc "Web search from the terminal"
  homepage "https://github.com/zquestz/s"
  url "https://github.com/zquestz/s/archive/v0.4.2.tar.gz"
  sha256 "12f1e9ff5d52703d8e8e14755c8b34d3c15d9f39295222c16860077c15cef807"

  head "https://github.com/zquestz/s.git"

  depends_on "go" => :build

  go_resource "github.com/mitchellh/go-homedir" do
    url "https://github.com/mitchellh/go-homedir.git",
      :revision => "d682a8f0cf139663a984ff12528da460ca963de9"
  end

  go_resource "github.com/spf13/cobra" do
    url "https://github.com/spf13/cobra.git",
      :revision => "65a708cee0a4424f4e353d031ce440643e312f92"
  end

  go_resource "github.com/zquestz/go-ucl" do
    url "https://github.com/zquestz/go-ucl.git",
      :revision => "9e5940bb3930921a83dcb0f9e20a32e3b1335590"
  end

  go_resource "github.com/zquestz/s/providers" do
    url "https://github.com/zquestz/s/providers.git",
      :revision => "66a10b882169f8b24fb59f68f7818f07a65407e6"
  end

  go_resource "github.com/zquestz/s/server" do
    url "https://github.com/zquestz/s/server.git",
      :revision => "2eaa10b5eaff36b32fb1a0363307a9a2e992014c"
  end

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/zquestz"
    ln_s buildpath, buildpath/"src/github.com/zquestz/s"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", "s"
    bin.install "s"
  end

  test do
    system "#{bin}/s", "--version"
  end
end
