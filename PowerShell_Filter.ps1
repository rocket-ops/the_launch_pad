<#
.Synopsis
	Hi! My names Berry and I am just learning this shit, so bear with me. 
	
   Used to take a list of strings from a text file and then extract matches from another file. 

.DESCRIPTION

   PLEASE NOTE: THIS SCRIPT IS INTENDED TO BE RAN WITH POWERSHELL 7.0. The -Raw parameter is needed to get a clean output.
        You can remove -Raw from the line below but it might not output long strings correctly.  

   The user will need to enter three parameters. 
   
    1. "Enter path and file name of txt file containing filters (will not work if spaces in directory name, yet)"

        As stated, I have not yet figured out how to allow for the entry of spaces in the field.  Also there is no validation 
        checks as of V4, so if you enter a valid location the script will just fail. 

    2.  "Enter path and file name of content you want filtered"
        
        This can be any non-binary type of file. 

    3. "Enter path and file name of output file"

        The script will create the file if it currently is not created. 
       
.EXAMPLE
        
        Enter path and file name of txt file containing filters (will not work if spaces in directory name, yet): c:\cases\keyword.txt
        Enter path and file name of content you want filtered: c:\cases\firewall.csv
        Enter path and file name of output file: c:\cases\106.csv


        Directory: C:\cases


        Mode                LastWriteTime         Length Name                                                                                                                                         
        ----                -------------         ------ ----                                                                                                                                         
        -a----        3/27/2020   3:59 PM              0 106.cs

        Note: There is no completion notification as of V4.

#>

$filter = Read-Host -Prompt "Enter path and file name of txt file containing filters (will not work if spaces in directory name, yet)"
$loglocation = Read-Host -Prompt "Enter path and file name of content you want filtered"
$outputfile = Read-Host -Prompt "Enter path and file name of output file"
$ips = Get-Content $filter
New-Item -Path $outputfile
ForEach($i in $ips){
    #remove -Raw below if using PowerShell 6.0 or lower
	$string = Select-String -Raw -Path $loglocation -Pattern $i
    $string | Out-File $outputfile -Append    
    }
