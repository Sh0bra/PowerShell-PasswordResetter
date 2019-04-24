#Required to load the XAML form and create the PowerShell Variables

.\loadDialog.ps1 -XamlPath '..\Forms\PasswordResetterGUIv2.xaml'

#######################################################################


function Get-AccountNames {
    $ListOfAccountNames = Get-WmiObject -Class Win32_UserAccount -Filter "Disabled = False" | Select -ExpandProperty Name
    return $ListOfAccountNames
}


function Populate-ComboBox {
    $ListOfAccounts = Get-AccountNames

    ForEach ($Account in $ListOfAccounts) {
        $cbxLocalAccount.Items.Add($Account) | out-null
    }   
    $cbxLocalAccount.SelectedIndex = -1
}


function Initialize-PasswordBoxes {
    $pwbLocalNewPassword.PasswordChar = '*' 
    $pwbLocalReEnterNewPassword.PasswordChar = '*'
}

function Reset-LocalState {
    $pwbLocalNewPassword.Password = ''
    $pwbLocalReEnterNewPassword.Password = ''
    $cbxLocalAccount.SelectedIndex = -1
}


#DO STUFF

Populate-ComboBox
Initialize-PasswordBoxes


#EVENT Handler 
    
$btnLocalChangePassword.add_Click({  
    try {
        $Target = $cbxLocalAccount.SelectedItem.ToString()
        $Password = $pwbLocalNewPassword.Password.ToString()
        if (!$Password) { throw 'Invalid Password' }

        if (!($Password -eq $pwbLocalReEnterNewPassword.Password.ToString())) {
            throw 'Password Does not Match'
        }
        
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $TargetAccount = Get-LocalUser -Name $Target
        $TargetAccount | Set-LocalUser -Password $SecurePassword 
        [System.Windows.MessageBox]::Show('Password has been changed')
    } catch {
        [System.Windows.MessageBox]::Show('Password Error: Passwords do not match.')
    }

    Reset-LocalState
})




#Launch the window
$xamGUI.ShowDialog() | out-null



#stop-process -Id $PID
