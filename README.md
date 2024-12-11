# read-only_file_editor
a pure windows batch file that edits read-only files and traverse hidden directories (used for my school pc lol)

it has 3 modes to choose when executed.

## mode 1
mode 1 is search.   
Input a query and the program will use dir to search for any file/folder that matches the query across all physical drives.

## mode 2
mode 2 is file edit   
First input a path to the target file   
As long as the file has a read attribute, it can be copied   
therefore it will be copied to the temporary directory (recreates drive inside the temp dir for easier later traverse and mode3 btw)   
and then after editing it in notepad and closing, it will be copied back to replace it, assuming we have a write attribute in the folder that file exists in   

## mode 3
mode 3 is directory copy, robust version to mode 2   
also first input the path to target    
but secondly input the path to where to copy the target to   
(you can leave it blank to default to temp folder)   
instead of copying it back after copying, mode 3 will open explorer.exe to the copied folder, allowing further advance file/directory manipulation   
(need to copy it back manually using mode3 again after operation)    


## ending for no reason
yeah so thats it
kinda trash, costed me 8 hours

I hate batch