$LocalAccount = "Administrator"
echo $LocalAccount


#$SecurePassword = Read-Host -AsSecureString  "Enter password" | ConvertFrom-SecureString | out-file C:\Users\shinhs\Documents\securePassword.txt

#$PlainPassword = Get-Content C:\Users\shinhs\Documents\securePassword.txt


$NewPassword = Read-Host -AsSecureString -Prompt "Enter New Password" | ConvertFrom-SecureString

$SecurePassword = ConvertTo-SecureString $NewPassword
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

$TargetAccount = Get-LocalUser -Name $LocalAccount


#$Decoder = ConvertTo-SecureString $NewPassword
#$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Decoder)
#$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
#echo $UnsecurePassword


[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) #this is an important step to keep things secure
echo $UnsecurePassword
