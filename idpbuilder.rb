class Idpbuilder < Formula
  desc "IDP Client to create kind cluster"
  homepage "https://cnoe.io/"
  url "https://github.com/cnoe-io/idpbuilder/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "5fe24d7449d596d573d90b140cc4e946ae3c691e63b06ec3d7d7547ee2274b0a"
  license "Apache-2.0"
  head "https://github.com/cnoe-io/idpbuilder.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/cnoe-io/idpbuilder/pkg/cmd/version.idpbuilderVersion=#{version} \
      -X github.com/cnoe-io/idpbuilder/pkg/cmd/version.gitCommit=#{Utils.git_head} \
      -X github.com/cnoe-io/idpbuilder/pkg/cmd/version.buildDate=#{time.strftime("%F")}
    ]
    system "go", "build", *std_go_args(ldflags:)

    generate_completions_from_executable(bin/"idpbuilder", "completion")
  end

  test do
    assert_match "Manage reference IDPs",
                 shell_output("#{bin}/idpbuilder -h")
  end
end
