{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {
  buildInputs = with pkgs; [
    sbcl
    emacs
    openssl
  ];

  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";

  shellHook = ''
    echo "Note from lisp-web-stack: You still need to configure Emacs manually unfortunately"
    export LD_LIBRARY_PATH="${pkgs.openssl.out}/lib/:$LD_LIBRARY_PATH"
    if ! test -f quicklisp/setup.lisp; then
      curl https://beta.quicklisp.org/quicklisp.lisp > quicklisp.lisp
      sbcl --no-sysinit --no-userinit --load quicklisp.lisp --eval '(quicklisp-quickstart:install :path #P"./quicklisp/")' --quit
    fi
  '';
}
