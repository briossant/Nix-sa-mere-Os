{pkgs, config, ...}:

# system level config for the user
{
    # modules
    imports = [
        ../../sys-modules/steam
    ];
}