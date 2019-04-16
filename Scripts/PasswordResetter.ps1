#Required to load the XAML form and create the PowerShell Variables

.\loadDialog.ps1 -XamlPath '..\Forms\PasswordResetterGUI.xaml'


#EVENT Handler 
    $btnChangePassword.add_Click({  
       $lblOldPassword.Content = "Hello World"
    })



#Launch the window
$xamGUI.ShowDialog() | out-null


<#


function Get-AccountNames{
    $ListOfAccountNames = Get-WmiObject -Class Win32_UserAccount -Filter "Disabled = False" | Select -ExpandProperty Name
    #$ListOfNames = $ListOfAccountNames.Name
    return $ListOfAccountNames
}

function Validate-Account($Target, $ListOfAccounts){
    echo "out loop"
    #echo $Target
    echo $ListOfAccounts
    $letterArray = "a","b","c","d"
    
    foreach ($letter in $letterArray)
    {
      Write-Host $letter
    }

    ForEach ($Accounts in $ListOfAccounts) {
        echo "In Loop"
        echo $Account
        echo $Target
        #if ($Account -eq $Target) {
        #    return $true
        #}
        }
    #return $false
    #Write-Error "Account Does Not Exist On This Computer"
}

#clear

$ListOfAccounts = Get-AccountNames

echo $ListOfAccounts
#$Target = Read-Host -Prompt "Enter User Name"
#$Valid = Validate-Account($Target, $ListOfAccounts)

#echo $Valid
#echo $TargetAccountName



#$SecurePassword = Read-Host -AsSecureString  "Enter password" | ConvertFrom-SecureString | out-file C:\Users\shinhs\Documents\securePassword.txt

#$PlainPassword = Get-Content C:\Users\shinhs\Documents\securePassword.txt


#$NewPassword = Read-Host -AsSecureString -Prompt "Enter New Password: " | ConvertFrom-SecureString

#$SecurePassword = ConvertTo-SecureString $NewPassword
#$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
#$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

#$TargetAccount = Get-LocalUser -Name $LocalAccount

#[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) #this is an important step to keep things secure
#echo $UnsecurePassword


#Set-LocalUser -Name $LocalAccount -Password $SecurePassword -Confirm

#>