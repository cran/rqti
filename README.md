
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

# <img src="man/figures/logo.svg" align="right" width="250" height="100" />

[![R-CMD-check](https://github.com/shevandrin/rqti/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/shevandrin/rqti/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/shevandrin/rqti/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/shevandrin/rqti/actions/workflows/test-coverage.yaml)
[![Codecov test
coverage](https://codecov.io/gh/shevandrin/rqti/branch/main/graph/badge.svg)](https://app.codecov.io/gh/shevandrin/rqti?branch=main)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN
status](https://www.r-pkg.org/badges/version/rqti)](https://CRAN.R-project.org/package=rqti)
<!-- badges: end -->

# rqti

The objective of `rqti` is to establish a robust and stand-alone R
library tailored for crafting exercises and exams in adherence to the
[QTI
v2.1](https://www.imsglobal.org/question/qtiv2p1/imsqti_implv2p1.html)
standard directly from R. Users have the flexibility to render the
exercises either locally (using qtijs) or integrate them seamlessly into
the OPAL learning management system. Our primary audience comprises
instructors specializing in research methods and statistics who seek to
harness the full capabilities of R while aligning with the QTI standard.
In particular, instructors utilizing OPAL will find our package
especially advantageous, as it capitalizes on OPAL’s robust API.

## Documentation

Comprehensive documentation, encompassing installation instructions, a
quick start guide, example usage, and detailed functionality
documentation, can be accessed at the following link:
<https://shevandrin.github.io/rqti/>

## Testing

Our commitment to robustness is reflected in our pursuit of high test
coverage through automated tests, located in the “tests” folder.

## Support and Bug Reports

Should you find any missing features or encounter issues, please do not
hesitate to inform us via email or open an issue on GitHub. We will
offer support until the project’s funding concludes in September 2024.
Following that, we will maintain a stable, usable version, with support
for new features provided as time permits.

## Contribute

To contribute to this package, clone the repository, implement your
feature, and submit a pull request. Kindly adhere to the tidyverse style
and the general package guidelines outlined at <https://r-pkgs.org>.
Your contributions are greatly appreciated.

<!-- Why do we need another package for creating exams when there is already the `exams`-package? The philosophy of `exams` is **one for all**, whereas `rqti` follows the Unix-philosophy: **do one thing and do it well**. tldr: -->
<!-- - `rqti` has more (QTI) features (e.g. exercise type) than `exams` -->
<!-- - `rqti` uses OOP (S4), the system is easy to extend (LMS specific needs) -->
<!-- - the Rmd-interface is cleaner as it just focues on QTI -->
<!-- - low-level functions can be used flexibly to create exercises -->
<!-- - `rqti` puts a premium on testing, with currently over 100 tests -->
<!-- - rendering of QTI files in the browser (or viewer pane of RStudio) directly from R -->
<!-- - functions to upload files via REST API to LMS (for us OPAL, but you can implement your own) -->
<!-- If you just use QTI-exercises, you should check out our package. If you need different formats next to QTI, e.g. print, LMS that do not support QTI stick to `exams`. -->
<!-- Just focusing on QTI gives us more time to support great features of the QTI standard that are missing in `exams`. For instance, `rqti` offers dropdown-inputs, ordering-exercises, and match-tables. -->
<!-- ## Installation -->
<!-- ```{r eval=FALSE} -->
<!-- install.packages("librarian") # skip if you have librarian already -->
<!-- librarian::shelf(shevandrin/rqti) -->
<!-- ``` -->
<!-- ##  -->
<!-- ## What is not possible -->
<!-- - Composites (several exercise types in one task) are not implemented because they do not work in our LMS (OPAL); several gaps do work, though -->
<!-- - Associates are not implemented because they does not work in OPAL -->
<!-- ## Comparison between exams and rqti -->
<!-- The `exams` package uses templates and pastes strings together to create rqti files. This has some disadvantages: it is error prone, not easy to maintain and difficult to extend. If for instance, a new exercise type needs to be added, many locations have to be changed. `rqti` is supposed to make life easier by providing some standard functions to create all parts of the QTI xml file. -->
<!-- Extending exams is just a matter of composing the correct `rqti` functions. Testing small `rqti` functions is easy, whereas the main function of `exams` `make_item_body` consists of 736 lines. Indeed, this function has grown substantially over time (todo: provide evidence). -->
<!-- Based on rqti one can also develop new interfaces for creating exercises. -->
