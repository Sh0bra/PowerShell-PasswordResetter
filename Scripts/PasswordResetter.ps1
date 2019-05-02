#Required to load the XAML form and create the PowerShell Variables

.\loadDialog.ps1 -XamlPath '..\Forms\PasswordResetterGUIv2.xaml'

#######################################################################
###############             Functions                  ################
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

###############################################################################
###############                  DO STUFF                      ################
###############################################################################


Populate-ComboBox
Initialize-PasswordBoxes

###############################################################################
###############               EVENT Handler                    ################
###############################################################################

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


$btnSchedularScheduleTask.add_Click({  
    try {
        $Target = $txbSchedularAccount.Text

        if ($cbxSchedularLocalAdmin.IsChecked -eq $true) { $Target = "Administrator" }

        [System.Windows.MessageBox]::Show($Target)
        $Password = $pwbSchedularNewPassword.Password.ToString()

        if (!$Password) { throw 'Invalid Password' }

        if (!($Password -eq $pwbSchedularReEnterNewPassword.Password.ToString())) {
            throw 'Password Does not Match'
        }
        
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $TargetAccount = Get-LocalUser -Name $Target
        #$TargetAccount | Set-LocalUser -Password $SecurePassword 
        [System.Windows.MessageBox]::Show('Password has been changed')
    } catch {
        [System.Windows.MessageBox]::Show('Password Error: Passwords do not match.')
    }

})

$btnSchedularViewTasks.add_Click({  
    try {
        [System.Windows.MessageBox]::Show('Open New Window Showing Tasks in Task Manager \n that are relevent to this program.')       
    } catch {
        [System.Windows.MessageBox]::Show('Password Error: Passwords do not match.')
    }
})


###############################################################################
###############             Launch the window                  ################
###############################################################################

$xamGUI.ShowDialog() | out-null



#stop-process -Id $PID


# $range=10..21 | %{"10.10.0.$_"}
# foreach ($ip in $range){
# ([System.Net.Dns]::GetHostByAddress($ip)).HostName}