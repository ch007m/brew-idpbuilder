## Homebrew guides

Formula Cookbook: https://docs.brew.sh/Formula-Cookbook

How to add a formula: https://docs.brew.sh/Adding-Software-to-Homebrew

Instructions to submit a formula using a PR: https://docs.brew.sh/How-To-Open-a-Homebrew-Pull-Request

Example of Formula PR: https://github.com/Homebrew/homebrew-core/pull/46886

## How to create a new formula

To package a project as a brew formula, it is needed to have a git repository with releases/tag.
You can create a git repository for that purpose and release it as documented hereafter

- Create a git repository containing a README.md
- Tag the project to release it: `v0.1.0`
- Get the url of the released propject: https://github.com/ch007m/brew-idpbuilder/archive/refs/tags/v0.1.0.tar.gz
  
Alternativetely, you can get from an existing project the URL of a tag or release: https://github.com/cnoe-io/idpbuilder/archive/refs/tags/v0.8.1.tar.gz

Next, git clone the brew project and create a new Formula

```bash
❯ brew tap --force homebrew/core
❯ brew create --go --set-name <FORMULA_NAME> --set-license Apache-2.0 https://github.com/ch007m/brew-idpbuilder/archive/refs/tags/v0.1.0.tar.gz
==> Downloading https://github.com/ch007m/brew-idpbuilder/archive/refs/tags/v0.1.0.tar.gz
==> Downloading from https://codeload.github.com/ch007m/brew-idpbuilder/tar.gz/refs/tags/v0.1.0
######################################################################################################################################################################################################## 100.0%
Warning: Cannot verify integrity of '7173b6c7e01f98c6c23ef042cca5de7a0b9b37ff70facd2787ec91321256e624--brew-idpbuilder-0.1.0.tar.gz'.
No checksum was provided.
For your reference, the checksum is:
  sha256 "f0297261768062331e08d2f5494c0e30298ca53715df53f9eeb6170f67cba4c4"
Please run the following command before submitting:
  HOMEBREW_NO_INSTALL_FROM_API=1 brew audit --new brew-idpbuilder
Editing /opt/homebrew/Library/Taps/homebrew/homebrew-core/Formula/b/brew-idpbuilder.rb
Warning: Using subl because no editor was set in the environment.
This may change in the future, so we recommend setting EDITOR
or HOMEBREW_EDITOR to your preferred text editor.
```
- As alternative, edit/open the Formula generated under $(brew --prefix)/Library/Taps/homebrew/homebrew-core/Formula/<FIRST_LETTER_OF_FORMULA>/<FORMULA_NAME>.rb using your IDE.

## How create build/install the package

Whzn you have created a new Formula, it is needed to build it locally as described hereafter:
- Git clone locally the homebrew core project if not yet done
```
❯ brew tap --force homebrew/core
```
- Create/edit the formula under the following path: $(brew --prefix)/Library/Taps/homebrew/homebrew-core/Formula/<FIRST_LETTER_OF_FORMULA>/<FORMULA_NAME>.rb
```
class Idpbuilder < Formula
  desc "IDP Client to create kind cluster."
  homepage "https://cnoe.io/"
  url "https://github.com/cnoe-io/idpbuilder/archive/refs/tags/v0.8.1.tar.gz"
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

```
- Install it using this command in a terminal
```bash
HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source --verbose --debug idpbuilder
```
- If the build succeeds, you should then find the executable:
```bash
❯ ls -la $(brew --prefix)/bin | grep idpbuilder
lrwxr-xr-x@    1 cmoullia  staff        41 16 Jan 18:29 idpbuilder -> ../Cellar/idpbuilder/0.8.1/bin/idpbuilder

❯ ls -la $(brew --cellar)/idpbuilder
total 0
drwxr-xr-x@   3 cmoullia  staff    96 16 Jan 18:29 ./
drwxrwxr-x@ 238 cmoullia  staff  7616 16 Jan 18:29 ../
drwxr-xr-x@  10 cmoullia  staff   320 16 Jan 18:29 0.8.1/

/opt/homebrew/Library/Taps/homebrew/homebrew-core on master •
❯ ls -la $(brew --cellar)/idpbuilder/0.8.1
total 48
drwxr-xr-x@ 10 cmoullia  staff    320 16 Jan 18:29 ./
drwxr-xr-x@  3 cmoullia  staff     96 16 Jan 18:29 ../
drwxr-xr-x@  3 cmoullia  staff     96 16 Jan 18:29 .brew/
-rw-r--r--@  1 cmoullia  staff    962 16 Jan 18:29 INSTALL_RECEIPT.json
-rw-r--r--@  1 cmoullia  staff  11341 16 Jan 18:25 LICENSE
-rw-r--r--@  1 cmoullia  staff   3028 16 Jan 18:25 README.md
drwxr-xr-x@  3 cmoullia  staff     96 16 Jan 18:29 bin/
drwxr-xr-x@  3 cmoullia  staff     96 16 Jan 18:29 etc/
-rw-r--r--@  1 cmoullia  staff   1729 16 Jan 18:29 sbom.spdx.json
drwxr-xr-x@  4 cmoullia  staff    128 16 Jan 18:29 share/
```
## To test the formula

Test the formula by executing this command: `brew test idpbuilder`

## To generate the bottles

- Uninstall the package 
```
❯ brew uninstall idpbuilder
Uninstalling /opt/homebrew/Cellar/idpbuilder/0.8.1... (9 files, 46.2MB)
```
- Rebuild it using the flag `--build-bottle`
❯ HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-bottle idpbuilder
```
- Then you can bootle it or them using the command
```bash
❯ HOMEBREW_NO_INSTALL_FROM_API=1 brew bottle idpbuilder

==> Determining idpbuilder bottle rebuild...
==> Bottling idpbuilder--0.8.1.arm64_sonoma.bottle.tar.gz...
==> Detecting if idpbuilder--0.8.1.arm64_sonoma.bottle.tar.gz is relocatable...
./idpbuilder--0.8.1.arm64_sonoma.bottle.tar.gz
  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "afa70a99adf6120b23685f663cca39a51ae9efb36f4c85f7fcc5a633b9880778"
  end
```
- Add the `bottle do` block under the Formula

**Important** the `bottle do` block must not been added for new formula not yet pushed on homebrew !!

## To audit the Formula

You can run `brew audit --strict` to test the formula for adherence to Homebrew house style, which is loosely based on the [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide#the-ruby-style-guide). 
The audit command includes warnings for trailing whitespace, preferred URLs for certain source hosts, and many other style issues. Fixing these warnings before committing will make the process a lot quicker for everyone.

```bash
❯ brew audit --strict idpbuilder
idpbuilder
  * line 11, col 3: Use 2 (not 4) spaces for indentation.
Error: 1 problem in 1 formula detected.
```
Execute this audit command for new formulae
```bash
❯ brew audit --new idpbuilder
```
## Get or populate the url sha256

After editing the formula, you can run `brew fetch your-formula --build-from-source` to fetch the tarball and display the new checksum. 

If you've already downloaded the tarball somewhere, you can calculate the hash with `openssl sha256 < some_tarball.tar.gz` or `shasum -a 256 some_tarball.tar.gz`

