

# New-BobTheBook

Create a new book for all bob machines.
## Syntax

    New-BobTheBook [-OutputLocation] <String> [-Username] <String> [-Password] <SecureString> [-BobTheBook] <String> [<CommonParameters>]


## Description

New-BobTheBook clones all bob machines, creates a book from their documentation
and merges all to one big "Bob - The Book"





## Parameters

    
    -OutputLocation <String>
_The path to the location, where the repos should be cloned and the book written._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Username <String>
_The username for the git repository._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Password <SecureString>
_The password for the git repository._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -BobTheBook <String>
_The path to the book which should be used as base for the book._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-BobTheBook D:\temp\bobthebook -Username yannis -Password Pass@word$ -BobTheBook D:\sources\bob-thebook































