# how buildInputs work? how libs (.so) that are added to buildInputs are discovered by make?

https://ianthehenry.com/posts/how-to-learn-nix/the-standard-environment/

```
Anyway, the manual tells us one very important thing that source "${stdenv}/setup" does for us: it processes buildInputs and puts them on our PATH. So that’s nice.

nixpkgs has a file called common-path.nix:

How can I ask Nix to show me runtime dependencies of an output?
  nix-store --query --references or nix-store --query --requisites, for the reqursive version. Note that Nix doesn’t really have a concept of a “runtime” reference, though, and this will include build-time dependencies in the case that you have propagatedBuildInputs.
Are runtime dependencies known per-derivation, or per-output?
  Per-output.

```

https://www.sam.today/blog/derivations-102-learning-nix-pt-4/

```
N | Phase     | Default Behaviour                                             | Behaviour with GNU Hello
1 | unpack    | unzips, untarz, or copies your source folder to the nix store | the source is a tarball, so it is automatically extracted
2 | patch     | applies any patches provided in the patches variable          | nothing happens
3 | configure | runs ./configure if it exists                                 | runs ./configure
4 | build     | runs make if it exists                                        | runs make, the app is built
5 | check     | skipped by default                                            | we turn it on, so it runs make check
6 | install   | runs make install                                             | runs make install
```


# what is D..
https://github.com/neuromore/studio/blob/a59ae10c638fcbb29f7f2e97f56a5c1ae7a4836a/deps/build/make/Makefile.linux?_pjax=%23js-repo-pjax-container%2C%20div%5Bitemtype%3D%22http%3A%2F%2Fschema.org%2FSoftwareSourceCode%22%5D%20main%2C%20%5Bdata-pjax-container%5D#L51


# how wrapQtHook works? where it is called?
https://github.com/NixOS/nixpkgs/blob/94d91a448b87a70204485bd768977c07575911e8/pkgs/development/libraries/qt-5/hooks/wrap-qt-apps-hook.sh


```
https://ryantm.github.io/nixpkgs/languages-frameworks/qt/#sec-language-qt

  nativeBuildInputs = [ wrapQtAppsHook ];

    qtWrapperArgs = [ ''--prefix PATH : /path/to/bin'' ];

  dontWrapQtApps = true;
  preFixup = ''
      wrapQtApp "$out/bin/myapp" --prefix PATH : /path/to/bin
  '';


qt5-packages.nix
  myapp = libsForQt5.myapp;

```

# depug derivations build

```
https://www.adelbertc.com/first-nix-derivation/

nix-build -A coursier -K
/.../nix-build-coursier-1.0.0-M15-5.drv-0
env-vars
```