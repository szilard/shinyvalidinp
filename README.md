
## Input validation for Shiny

#### Motivation

Shiny takes inputs from UI elements and sends them to the server, where the 
application gets it as R variables. While Shiny has some security measures in place,
as in any web application, it is the developer's responsibility to sanitize 
the inputs before using them. For example, Shiny has no way to protect you if
you are using an input e.g. from a dropdown menu in a SQL query 
(e.g. `select ... from ... where field='input'`). 
Someone manipulating the websocket communication can
craft a special input that can force the database to execute a query that's
not supposed to do (SQL injection). This might give an attacker access to data that's
not supposed to be accessible or do other nepharious things, and it is a common security issue.

#### Goal

This simple R package provides functions that you can use to validate input (received 
from Shiny UI) on the server side (NB: any client side validation can be easily 
bypassed, so from security point of view you need to validate on the server side).

#### Usage

Assume you have a Shiny application that takes a company name from a dropdown 
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
example if you know that your input has just 2 values use `pattern = "^((value1)|(value2))$")` instead
of the default `pattern="^[[:alnum:]. _-]+$"`).

#### Demo

A companion demo Shiny app shows the difference between having and not having
input validation. Source code is 
[here on github](https://github.com/szilard/shinyvalidinp-demo) 
while running live demo
is [here on ShinyApps.io](https://szilard.shinyapps.io/shinyvalidinp-demo/).


#### Alternatives

An alternative approach (considered usually the most secure) would be to use prepared statements, 
but currently for example the `RMySQL` package does not support that. 

Another approach would be to use character "escaping", for example the `mysqlEscapeStrings` function
in case of `RMySQL`, but that has had in the past bugs/vulnerabilities. 

If you are using `dplyr`, then you get some basic validation automatically, but that's meant mainly
to prevent accidental misuse, not an attack. As Hadley says "This is unlikely to prevent any serious
attack, but should make it unlikely that you produce invalid sql".

#### Additional defenses

You should also have additional layers of security, such as minimal priviledges to the database user (e.g. for 
a Shiny app you might get away with read-only access to just the tables you need), or restricting the Shiny
app to a limited set of users etc.

#### Disclaimer and how to get involved

Finally, this package is very experimental, **use it at your own risk!** 
Any suggestions for improvements are welcome, especially reporting bugs and/or suggesting fixes. 
As with any security related code, it would be crucial not to leave out edge cases that could
lead to vulnerabilities.




