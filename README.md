# Binary packages for Linux [![badge](https://github.com/r-devel/linux-binary-packages/actions/workflows/test.yml/badge.svg)](https://github.com/r-devel/linux-binary-packages/actions/workflows/test.yml)

R-4.6 has finally standardized the format for serving binary packages on platforms beyond Windows and MacOS, notably Linux. Here we run some demos and tests to further improve this.

R news item: https://developer.r-project.org/blosxom.cgi/R-devel/NEWS/2026/02/03

## How it works

This is not enabled by default. Users (or distro-maintainers) opt-in via environment variable `R_PLATFORM_PKGTYPE` which specifies the path where R will look for binaries on package repositories. This variable is usually set in any of the `Renviron` files that gets loaded when R starts. 

The format of this variable must be `{os}.binary.{flavor}` for example if we use:


```env
R_PLATFORM_PKGTYPE=linux.binary.noble-x86_64
```

Then the server binaries need to be hosted on:

```
https://{server}/bin/linux/noble-x86_64/contrib/{r-version}/PACKAGES
```

Where `linux` and `noble-x86_64` are taken from `R_PLATFORM_PKGTYPE` and `{r-version}` is the usual `major.minor` R version (without the patch part) e.g. `4.6`.

R will show a warning and fall back on building packages from source as usual for packages or repositories where the requested binaries are not available.


## Testing with R-universe

Currently R-universe already hosts such binaries for Ubuntu "noble" 24.04 for both arm64 and x86_64:

 - https://cran.r-universe.dev/bin/linux/noble-x86_64/contrib/4.6/PACKAGES.gz
 - https://cran.r-universe.dev/bin/linux/noble-arm64/contrib/4.6/PACKAGES.gz

We can use the attached [Dockerfile](Dockerfile) to test that this works as intended by installing the tidyverse and its dependencies. The output logs show that installation is quick and no packages get built from source.

```sh
docker build . --no-cache --progress=plain
```

Output from nightly runs of this Dockerfile on GitHub actions is here: https://github.com/r-devel/linux-binary-packages/actions/workflows/test.yml