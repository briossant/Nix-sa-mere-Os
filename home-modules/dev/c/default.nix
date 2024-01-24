{ pkgs, ... }:

{
    home.packages = with pkgs; [
        gcc
        gdb
        gnumake
        valgrind
        clang-tools_16
        criterion
    ];
}
