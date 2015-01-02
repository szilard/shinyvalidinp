
#' validate logical input
#' 
#' validate TRUE/FALSE: checkboxInput
#' 
#' @param x input
#' @return validated input
#' @export
#' @examples
#' \dontrun{validinp_logical(input$chkbox)}
validinp_logical <- function(x) {
    if(!( is.logical(x) && length(x)==1 && !is.na(x) )) {
        stop("Invalid input from shiny UI")
    }
    x
}


#' validate numeric input
#' 
#' validate numeric: numericInput, sliderInput, actionButton
#' 
#' @param x input
#' @param min min value
#' @param max max value
#' @return validated input
#' @export
#' @examples
#' \dontrun{validinp_numeric(input$n)}
#' \dontrun{validinp_numeric(input$n, min=0, max=10)}
validinp_numeric <- function(x, min=-Inf, max=Inf) {
    if(!( is.numeric(x) && length(x)==1 && !is.na(x) && x>=min && x<=max )) {
        stop("Invalid input from shiny UI")
    }
    x
}


#' validate character input
#' 
#' validate character: textInput, selectInput, checkboxGroupInput, radioButtons
#' 
#' @param x input
#' @param pattern that input has to match (regexp)
#' @param many TRUE if more than 1 string (checkboxGroupInput)
#' @return validated input
#' @export
#' @examples
#' \dontrun{validinp_character(input$txt)}
#' \dontrun{validinp_character(input$radiobox, pattern="^((ab)|(cd))$")}
#' \dontrun{validinp_character(input$chkboxgrp, many=TRUE}
validinp_character <- function(x, pattern="^[[:alnum:]. _-]+$", many=FALSE) {
    if(many && is.null(x)) return(character(0))  ## hack for checkboxGroupInput
    if(!( is.character(x) && (many || length(x)==1) && length(x)>=1 && 
              all(!is.na(x)) && all(grepl(pattern,x)) )) {
        stop("Invalid input from shiny UI")
    }
    x
}


#' validate Date input
#' 
#' validate Date: dateInput, dateRangeInput
#' 
#' @param x input
#' @param min min date
#' @param max max date
#' @param many TRUE if date range (i.e. 2 values)
#' @return validated input
#' @export
#' @examples
#' \dontrun{validinp_Date(input$dt)}
#' \dontrun{validinp_Date(input$dt_range, many=TRUE)}
validinp_Date <- function(x, min=-Inf, max=Inf, many=FALSE) {
    if(!( is.atomic(x) && inherits(x, "Date") && (many || length(x)==1) && 
              length(x) %in% c(1,2) && all(!is.na(x)) && all(x>=min & x<=max) )) {
        stop("Invalid input from shiny UI")
    }
    x
}
