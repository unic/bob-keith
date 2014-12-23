

# New-BobTheBook

Create a new book for all bob machines.
## Syntax

    New-BobTheBook [-OutputLocation] <String> [-Username] <String> [-Password] <String> [-BobTheBook] <String> [<CommonParameters>]


## Description

New-BobTheBook clones all bob machines, creates a book from their documentation
and merges all to one big "Bob - The Book"





## Parameters

    
    -OutputLocation <String>

The path to the location, where the repos should be cloned and the book written.





Required?  true

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Username <String>

The username for the git repository.





Required?  true

Position? 2

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Password <String>

The password for the git repository.





Required?  true

Position? 3

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -BobTheBook <String>

The path to the book which should be used as base for the book.





Required?  true

Position? 4

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-BobTheBook D:\temp\bobthebook -Username yannis -Password Pass@word$ -BobTheBook D:\sources\bob-thebook































