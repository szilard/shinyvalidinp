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
    expect_equal(validinp_character("ab", pattern="^((ab)|(cd))$"), "ab")
    
    expect_error(validinp_character("'"))
    expect_error(validinp_character(NA))
    expect_error(validinp_character(NA_character_))
    expect_error(validinp_character(character(0)))
    expect_error(validinp_character(c("ab","cd")))
    expect_error(validinp_character(list(a="a",b="b")))
    expect_error(validinp_character(".", pattern="^[[:alnum:]]$"))    
    expect_error(validinp_character(NULL))    
    expect_error(validinp_character("abc", pattern="^((ab)|(cd))$"))
    
    expect_equal(validinp_character(c("a","b"), many=TRUE), c("a","b"))
    expect_equal(validinp_character("a", many=TRUE), "a")
    expect_equal(validinp_character(character(0), many=TRUE), character(0))
    expect_equal(validinp_character(NULL, many=TRUE), character(0))   ## hack for checkboxGroupInput

    expect_error(validinp_character(c("a",NA), many=TRUE))    
    expect_error(validinp_character(c("a","a'b"), many=TRUE))     
})

test_that("Date", {
    expect_equal(validinp_Date(as.Date("2015-01-01")), as.Date("2015-01-01"))
    expect_equal(validinp_Date(as.Date("2015-01-01"), min="2014-01-01"), as.Date("2015-01-01"))

    expect_error(validinp_Date("2015-01-01"))
    expect_error(validinp_Date(NA))
    expect_error(validinp_Date(0))
    expect_error(validinp_Date(as.Date("2015-01-01"), min="2015-01-02"))
    
    expect_equal(validinp_Date(as.Date("2015-01-01")+1:2, many=TRUE), as.Date("2015-01-01")+1:2)
    
    expect_error(validinp_Date(as.Date("2015-01-01")+1:3, many=TRUE))
})


