context("validinp functions")

test_that("logical", {
    expect_equal(validinp_logical(TRUE), TRUE)
    expect_equal(validinp_logical(FALSE), FALSE)    

    expect_error(validinp_logical(NA))
    expect_error(validinp_logical(c(TRUE, TRUE)))     
    expect_error(validinp_logical(logical()))
    
    expect_error(validinp_logical(1:2))
    expect_error(validinp_logical(list(a=1,b=2)))
    expect_error(validinp_logical(letters))     
})

test_that("numeric", {
    expect_equal(validinp_numeric(2), 2)
    expect_equal(validinp_numeric(2, min=1, max=3), 2)
    
    expect_error(valid_numeric(NA))
    expect_error(valid_numeric(1:2))
    expect_error(valid_numeric(-1, min=1, max=3))
    expect_error(valid_numeric(4, min=1, max=3))
    
    expect_error(valid_numeric(letters))
    expect_error(valid_numeric(list(a=1,b=2)))
    expect_error(valid_numeric(TRUE))
})

test_that("character", {
    expect_equal(validinp_character("abcABC0123.- _"), "abcABC0123.- _")
    expect_equal(validinp_character(""), "")
})

test_that("Date", {
    
})


