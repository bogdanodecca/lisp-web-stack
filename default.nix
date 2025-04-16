{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.sbcl
    pkgs.openssl
  ];

  shellHook = ''
    echo "Note from lisp-web-stack: You still need to setup Emacs and quicklisp manually unfortunately"
    export LD_LIBRARY_PATH="${pkgs.openssl.out}/lib/:$LD_LIBRARY_PATH"
  '';
}
