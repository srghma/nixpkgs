# gcc att and intel

https://github.com/gcc-mirror/gcc/blob/16e2427f50c208dfe07d07f18009969502c25dc8/gcc/config/v850/v850-c.c#L156

```
enum GHS_section_kind
{
  GHS_SECTION_KIND_DEFAULT,

  GHS_SECTION_KIND_TEXT,
  GHS_SECTION_KIND_DATA,
  GHS_SECTION_KIND_RODATA,
  GHS_SECTION_KIND_BSS,
  GHS_SECTION_KIND_SDATA,
  GHS_SECTION_KIND_ROSDATA,
  GHS_SECTION_KIND_TDATA,
  GHS_SECTION_KIND_ZDATA,
  GHS_SECTION_KIND_ROZDATA,

  COUNT_OF_GHS_SECTION_KINDS  /* must be last */
};
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

#  https://tldp.org/HOWTO/pdf/Program-Library-HOWTO.pdf

a - static library (archive, `ar rcs my_library.a file1.o file2.o` (r -replace, c, s archive index))


```
https://www.google.com/search?q=static+library+vs+dll+vs+so+vs
Static libraries (.a files): At link time, a copy of the entire library is put into the final application so that the functions within the library are always available to the calling application
Shared objects (.so files): At link time, the object is just verified against its API via the corresponding header (.h) file. The library isn't actually used until runtime, where it is needed.
```

# default.nix

./default.nix
./pkgs/top-level/impure.nix # envs, currentSystem
./pkgs/top-level/default.nix
