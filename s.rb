require 'formula'

HOMEBREW_S_VERSION='0.4.1'
class S < Formula
  homepage 'https://github.com/zquestz/s'
  url 'https://github.com/zquestz/s.git', :tag => "v#{HOMEBREW_S_VERSION}"
  version HOMEBREW_S_VERSION
  head 'https://github.com/zquestz/s.git', :branch => 'master'

  depends_on 'go' => :build

  def install
    ENV['GOPATH'] = buildpath
    system 'go', 'get', 'github.com/mitchellh/go-homedir'
	  system 'go', 'get', 'github.com/zquestz/go-ucl'
    system 'go', 'get', 'github.com/spf13/cobra'

    mkdir_p buildpath/'src/github.com/zquestz/s'
    ln_s buildpath/'search', buildpath/'src/github.com/zquestz/s/.'
    system 'go', 'build', '-o', 's'
    bin.install 's'
  end
end
