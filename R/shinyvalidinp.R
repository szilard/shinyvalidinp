
validinp_logical <- function(x) {
    if(!( is.logical(x) && length(x)==1 && !is.na(x) )) {
        stop("Invalid input from shiny UI")
    }
    x
}

validinp_numeric <- function(x, min=-Inf, max=Inf) {
    if(!( is.numeric(x) && length(x)==1 && !is.na(x) && x>=min && x<=max )) {
        stop("Invalid input from shiny UI")
    }
    x
}

validinp_character <- function(x, pattern="^[[:alnum:]. _-]+$", many=FALSE) {
    if(many && is.null(x)) return(character(0))  ## hack for checkboxGroupInput
    if(!( is.character(x) && (many || length(x)==1) && length(x)>=1 && 
              all(!is.na(x)) && all(grepl(pattern,x)) )) {
        stop("Invalid input from shiny UI")
    }
    x
}

validinp_Date <- function(x, min=-Inf, max=Inf, many=FALSE) {
    if(!( is.atomic(x) && inherits(x, "Date") && (many || length(x)==1) && 
              length(x) %in% c(1,2) && all(!is.na(x)) && all(x>=min & x<=max) )) {
        stop("Invalid input from shiny UI")
    }
    x
}
