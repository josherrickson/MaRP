## MaRP

MaRP is a **Ma**kefile for **R** **P**ackage development with a focus on
minimizing dependencies. It is an alternative to using the
[**devtools**](https://devtools.r-lib.org/) to avoid the massive amount of
package dependence that it brings. If you have an especially complex package,
**devtools** may suit you better.

While MaRP is designed to work out of the box, but is really supposed to just be
a starting point for a package's development. It has a number of Makefile rules
disabled which you can uncomment out as needed.

MaRP is based heavily on the
[Makefile](https://github.com/yihui/knitr/blob/b5583696976d12ad7aa951c8c0916b6a3f56ce93/Makefile)
for the [**knitr**](https://yihui.org/knitr/) package by Yihui Xie.

### Features

The following Make rules are supported:

- `all`: Runs a check, cleaning up artifacts afterwards.
- `deps`: Install package dependencies. The `DEP_FIELDS` variable in the
  Makefile can be customized to determine which fields in DESCRIPTION are looked
  at; the default is Depends and Imports.
- `document`: Run [**roxygen2**](https://roxygen2.r-lib.org).
- `build`: Build the package, without the manual (to save time). Useful for
  internal testing.
- `build-cran`: Build the package including the manual. The manual is needed for
  full checking and submission to CRAN.
- `test`: Run [**tinytest**](https://github.com/markvanderloo/tinytest) or
  [**testthat**](https://testthat.r-lib.org) (uncomment out whichever version
  you use) to carry out your package unit tests. The default is **tinytest**
  which has no dependencies.
- `install`: Build (if necessary) and install the package locally.
- `check`: Build (if necessary) and perform a CRAN check on the package. Note
  that unlike `make all`, this does not clean up artifacts.
- `vignettes`: NYI, will eventually build just the vignettes.
- `clean`: NYI, will eventually remove artifacts from the checking/building
  process.

There are also several optional rules that can be enabled by uncommenting:

- `coverage`: Runs [**covr**](https://covr.r-lib.org) against the package.
- `goodpractice`: Run
  [**goodpractice**](http://mangothecat.github.io/goodpractice/) against the
  package.
- `check_win`, `check_win_old`, `check_win_dev`: NYI, will eventually submit the
  package to the [win-builder](https://win-builder.r-project.org) for checking.
  Useful specifically for testing on the previous version or the development
  version of R without installing multiple versions of R locally.
