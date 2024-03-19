skip_on_cran()
skip_on_covr()
skip_on_ci()
skip()
test_that("Testing auth_opal() and is_logged()", {
    Sys.setenv("X-OLAT-TOKEN" = "")
    sut1 <- is_logged()
    expect_equal(sut1, FALSE)

    auth <- auth_opal()
    sut2 <- typeof(auth)
    expect_equal(sut2, "character")

    sut3 <- is_logged()
    expect_equal(sut3, TRUE)
})
skip()
test_that("Testing upload to opal and get resources", {
    test_name <- "0fGwTxYRMNVN-test-purposes"
    file <- test_path("file/rmd/test_rmd_OneInColTable_as_table_T.Rmd")

    sut1 <- upload2opal(file, display_name = test_name, open_in_browser = FALSE)
    expect_equal(sut1$display_name, test_name)

    sut2 <- get_resources_by_name(display_name = test_name)
    expect_equal(sut2[[1]]$displayname, test_name)
})
