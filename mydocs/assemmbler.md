# gcc att and intel

https://github.com/gcc-mirror/gcc/blob/16e2427f50c208dfe07d07f18009969502c25dc8/gcc/config/v850/v850-c.c#L156

```
if      (streq (sect, "data"))    kind = GHS_SECTION_KIND_DATA;
else if (streq (sect, "text"))    kind = GHS_SECTION_KIND_TEXT;
else if (streq (sect, "rodata"))  kind = GHS_SECTION_KIND_RODATA;
else if (streq (sect, "const"))   kind = GHS_SECTION_KIND_RODATA;
else if (streq (sect, "rosdata")) kind = GHS_SECTION_KIND_ROSDATA;
else if (streq (sect, "rozdata")) kind = GHS_SECTION_KIND_ROZDATA;
else if (streq (sect, "sdata"))   kind = GHS_SECTION_KIND_SDATA;
else if (streq (sect, "tdata"))   kind = GHS_SECTION_KIND_TDATA;
else if (streq (sect, "zdata"))   kind = GHS_SECTION_KIND_ZDATA;
/* According to GHS beta documentation, the following should not be
allowed!  */
else if (streq (sect, "bss"))     kind = GHS_SECTION_KIND_BSS;
else if (streq (sect, "zbss"))    kind = GHS_SECTION_KIND_ZDATA;
```

# flakes

```
{
  description = "A filesystem that fetches DWARF debug info from the Internet on demand";

  inputs = ....


  # type: inputs -> outputs
  # inputs.nixpkgs is `outputs` from <nixpkgs/flakes.nix>
  # https://github.com/NixOS/rfcs/pull/49/files#diff-7e8d05fadc397ee6d143d6b47af2967d5f467b59820590c69dfc69da0173684dR116-R119
  outputs = { self, nixpkgs }: rec {
    packages.x86_64-linux.dwarffs =
      with nixpkgs.packages.x86_64-linux;
#      with nixpkgs.builders;
      with nixpkgs.lib;

      stdenv.mkDerivation {
        name = "dwarffs-0.1.${substring 0 8 self.lastModifiedDate}";
```

```
f = import ./flake.nix
o = (let o = f.outputs; in f.outputs { self = o; })
```
#

./default.nix
./pkgs/top-level/impure.nix # envs, currentSystem
./pkgs/top-level/default.nix 
