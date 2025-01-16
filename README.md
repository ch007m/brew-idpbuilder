## Formula of idpbuilder

## HowTo guide

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
