#Our team was tasked to modularize the account termination script for the windows environment. The existing script was written in one file with multiple functions and some outdated code which required cleaning. The goal was to make it reusable, easy to understand & maintain and enhance debugging features. (i) I was given the opportunity to write a module to disable account in AD (Active Directory) and perform tasks to move the object to appropriate OU and clear appropriate attributes (memberof, telephonenumber). (ii) I was also tasked to write a basic log function that can be used within the tool. 

# I am hereby providing two scripts below.
### Script 1 to disable user account in windows domain
<#
    .Synopsis
    This powershell module performs the account termination in windows environment

    .Description
    Use this function to disable a user account in windows environment. It also clears essential attributes and moves the user object to disabled users OU.
    This script utilizes the write-logs module to log the results to a network share. 

 
    .Example
    #Disabling the user. Both the parameters uses string input
    disable-user -username <SAMAccountName> -servername <domainName>
#>

function disable-account(){
param(
#Defining username of the departing employee and option to select domain name where the account needs disabled. Setting them as mandatory fields for input.
[Parameter(Mandatory=$true)]
[string]$username,
[Parameter(Mandatory=$true)]
[Validateset("nivea.com", "main.nivea.com")]
[string]$servername
)

#OU in active directory for disabled user objects
$targetOU="OU=Disabled Users,DC=nivea,DC=com"

#Importing the module to write logs to a network share. 
#The file is in the same directory as current module file.
Import-Module .\write-logs.psm1

#Implementing Try Catch for error handling to avoid script from crashing and handle errors gracefully
try{

    #Checking if the user exists in the domain and passing the object to a variable if it exists
    #Supplying the userid (or SAMAccountName), the domain name and error action to continue script without printing the error
    $userObj=Get-ADUser -Identity $username -Server $servername -ErrorAction SilentlyContinue 

    #Disabling AD account in the domain
    Disable-ADAccount -Identity $username -Server $servername -ErrorAction SilentlyContinue | write-logs -logInfo "Successfully disabled account!"

    #Clearing telephone number and group membership attributes
    Set-ADObject -Identity ($userObj).DistinguishedName -Clear memberof,telephonenumber | write-logs -logInfo "Successfully cleared attributes!"

    #Move the user object to disabled users organization unit in AD
    Move-ADObject -Identity ($userObj).DistinguishedName -TargetPath $targetOU -ErrorAction SilentlyContinue | write-logs -logInfo "Moved object to disabled users OU"

}

#Catching the exception if the user is not found
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
{
    Write-Output "User not found! Error: $($_.Exception.message)" -ErrorAction SilentlyContinue | write-logs -logInfo "$($_.Exception.message)"
}

#Catching any other generic exception
catch {
    Write-Host "An error occurred: $($_.Exception.Message)" -ErrorAction SilentlyContinue | write-logs -logInfo "$($_.Exception.message)"
}
}

### Script 2 to log data to a network share
<#
    .Synopsis
    This powershell module writes the logs to the shared location \\server1\logs

    .Description
    Use this function to save logs to the network share. 
    It creates a new text file based on the date-time timestamp upto the denomination of minutes. The script appends information to log if the file already exists. 

 
    .Example
    #Save logs using this script
    write-logs -logInfo <Some_text_to_log>
#>

function write-logs(){
param(
#Declaring the parameter as string data type and setting it as mandatory
[Parameter(Mandatory=$true)]
[string]$logInfo
)

#Implementing Try Catch for error handling to avoid script from crashing and handle errors gracefully
try{
#Using the get-date cmdlet to convert date and time to string in appropriate format. 
#In the former section before the pipe we are getting current time and converting date-time to yyyy_MM_dd_HH:mm:ss format and appending with output
#In the latter section we are creating a new file with name having date-time format <yyyy_mm_dd_HH_mm>.txt. It appends data to existing file if it was already created.
"$((get-date).ToString('yyyy_MM_dd_HH:mm:ss')): $logInfo"| Add-Content "\\server1\logs\$((get-date).ToString('yyyy_MM_dd_HH_mm')).txt"
}

#Catching exception if there an error saving the information to the network share
catch{
Write-Output "Unable to log info! Error: $($_.Exception.message)"
}
}   
