# TODO: switch to release container when R-4.6 is out
FROM ghcr.io/r-devel/ubuntu-devel

RUN echo "R_PLATFORM_PKGTYPE=linux.binary.noble-$(arch)" >> "$HOME/.Renviron"

# Should reflect envvar set above
RUN R -e "print(.Platform$pkgType)"

# Install tidyverse + deps
RUN R -e "install.packages('tidyverse', repos = 'https://cran.r-universe.dev')"

# Assert that package can be loaded
RUN R -e "library(tidyverse)"
