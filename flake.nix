{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{
      self,
      ...
    }:
    inputs.utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [
            sbcl
            emacs
          ];

          buildInputs = with pkgs; [
            openssl
          ];

          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";

          shellHook = ''
            if ! test -f quicklisp/setup.lisp; then
              curl https://beta.quicklisp.org/quicklisp.lisp > quicklisp.lisp
              sbcl --no-sysinit --no-userinit --load quicklisp.lisp --eval '(quicklisp-quickstart:install :path #P"./quicklisp/")' --eval '(quit)'
            fi
          '';
        };
      }
    );
}
