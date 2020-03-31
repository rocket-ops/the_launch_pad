<#
.Synopsis
	Leveraging Powershell 7.0's, ForEach-Object -Parallel, this script will do accelerated string searches. 
.DESCRIPTION
    Parallel_filter.ps1 accelerates string searches with Powershell by leveraging parallel processing offered by Powershell 7.0's, 
    ForEach-Object -Parallell parameter.

    The user will need a text file containing the strings to search for inside a dataset.  The strings should be one per line. 

    Usage requires PowerShell 7.0 due to usage of the -Raw output also. 

    Usage involves the entry of 3 parameters
        -key - This is the txt file with strings to search. 
        -log - This is any dataset to be searched within. 
        -out - This is the location/file to save results. 

.EXAMPLE
    The easiest method is to copy the script, key file, and log all into the same folder and execute as follows"
    
            .\Parallel_filter.ps1 -key .\key.txt -log .\log.csv -out test2.csv

    The user can also declare paths as follows:

            .\Parallel_filter.ps1 -key c:\test\key.txt -log c:\test\log.csv -out c:\cases\output.csv
#>
param(
    [Parameter(Mandatory=$True)]
    [string]$key, # Where to find the file containing strings to search.
    [Parameter(Mandatory=$True)]
    [string]$log, # Location of the file/log to be searched. 
    [string]$out  # Location to save output file. 
)
if(-not(test-path $out)){
    Write-Host -ForegroundColor Green "[+] " -NoNewline; Write-Host -ForegroundColor cyan "Creating output file " -NoNewline; Write-Host "$out" 
    }
    else{
    write-host -foreground yellow "[+] " -NoNewline; write-host -ForegroundColor Red "File already exists, appending output to " -NoNewline; Write-Host -ForegroundColor cyan "$out"
}
New-Item -Path $out -ErrorAction SilentlyContinue
Write-host -foreground green "[+] " -NoNewline; write-host -ForegroundColor cyan "Beginning Search..."

Get-Content $key | ForEach-Object -Parallel {
    Select-String  -Raw -Path $using:log -Pattern $_
    } | Out-File -append $out

Write-Host -ForegroundColor green "[+] " -NoNewline; write-host -foregroundcolor cyan "Search Complete"
Write-Host -ForegroundColor green "Output located at " -NoNewline; write-host -ForegroundColor cyan "$out "