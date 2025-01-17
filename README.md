## Formula of idpbuilder

## How create a brew formula uide

- Create a git repository containing a README.md and xxx.rb file
- Edit the xxx.rb to define the Formula
- Tag the project to release it: `v0.1.0` by example
- Get the url of the released propject: https://github.com/ch007m/brew-idpbuilder/archive/refs/tags/v0.1.0.tar.gz
- Create locally a brew project to test it
```
❯ brew tap --force homebrew/core
❯ brew create https://github.com/ch007m/brew-idpbuilder/archive/refs/tags/v0.1.0.tar.gz
Formula name [brew-idpbuilder]:
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
- brew opens the EDITOR where you can edit the formula
```
# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Idpbuilder < Formula
  desc ""
  homepage ""
  url "https://github.com/ch007m/brew-idpbuilder/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f0297261768062331e08d2f5494c0e30298ca53715df53f9eeb6170f67cba4c4"
  license ""

  # depends_on "cmake" => :build

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "./configure", "--disable-silent-rules", *std_configure_args
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test brew-idpbuilder`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
```
- Update the formula.rb file and import the brew formulas in your IDEA
- Install it using this command in a terminal
```bash
HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source --verbose --debug idpbuilder
```
- If the build succeeds, you should then find the executable like its cellar folder
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
