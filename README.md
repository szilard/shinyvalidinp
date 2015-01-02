
### Input validation for Shiny

Shiny takes inputs from UI elements and sends them to the server, where the 
application gets it as R variables. While Shiny has some security measures in place,
as in any web application, it is the developer's responsibility to sanitize 
the inputs before using them. For example, Shiny has no way to protect you if
you are using an input e.g. from a dropdown menu in a SQL query 
(e.g. `select ... from ... where field='input'`). 
Someone manipulating the websocket communication can
craft a special input that can force the database to execute a query that's
not supposed to do (SQL injection). This might give an attacker access to data that's
not supposed to be accessible and it is a common security issue.

This simple R package provides functions that you can use to validate input (received 
from Shiny UI) on the server side (NB: any client side validation can be easily 
bypassed, so from security point of view you need to validate on the server side).

For example, assume you have a Shiny application that takes a company symbol from a dropdown 
(`selectInput`), gets the stock price from a SQL database and makes a plot. To validate
such input you would use on the server side (in `server.R`)
```
company <- validinp_character(input$company)
```
This checks if `company` conforms to a pattern (be default can contain alpha-numeric (`a-zA-Z0-9`), 
space, dot(`.`), underscore(`_`) or hyphen(`-`), i.e. "safe" characters). To change the pattern,
you can use the `pattern` argument (regular expression), e.g. 
```
company <- validinp_character(input$company, pattern = "^((ab)|(cd))$")
```
would allow only `ab` or `cd`. 
Now you can use safely `company` in a SQL query:
```
d <- dbGetQuery(con, paste0("select ymd, price from stocks where company='",company,"'"))
```
Otherwise, an unchecked input such as `company` being changed to 
`none' union select data from other_table...` can lead to unintended consequences.

This function takes a white-list approach (i.e. specify what is allowed) vs a black-list approach (specify what is forbidden). In the latter case it is always easy to forget about something and 
open a vulnerability. It is also always recommended to restrict the input as much as possible (for
example if you know that your input has just 2 values use `pattern = "^((value1)|(value2))$"")` instead
of the default `pattern="^[[:alnum:]. _-]+$"`).

Finally, this package is very experimental (just hacked it in an evening), use it at your own risk! 
Any suggestions for improvement are welcome though, and as with any security related code it would
be crucial to find and fix any bugs (please open an issue on github if you find such).







