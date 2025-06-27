#
# The PowerShell script is used to update OS proxy options on-demand based on different business context access requirement.
# 
# Author: Jian-Hua Pan(Jonathan)
# Email 1& MS Teams: hdpanjianhua@msn.com
# Email 2: fdpjh@126.com
# 
# Version: 2.0
# Created on 2024-06-22


Write-Host " "

# Print Set-ProxyOption CLI&GUI Tool Welcome Message and Help Information 
Write-Host "--------------------------------------------------------------------------------------------------------------"
Write-Host " "
Write-Host "              Welcome to use 'Set Proxy Option' PowerShell CLI&GUI Tool!  ^_^ " -BackgroundColor Magenta -ForegroundColor Black
Write-Host " "
Write-Host "                  Version                 : 2.0" -BackgroundColor Cyan -ForegroundColor Black
Write-Host "                  Relase Date             : 2024-06-22" -BackgroundColor Cyan -ForegroundColor Black
Write-Host "                  Author                  : Jian-Hua Pan(Jonathan)" -BackgroundColor Cyan -ForegroundColor Black
Write-Host "                  Support Email & MS Teams: hdpanjianhua@msn.com" -BackgroundColor Cyan -ForegroundColor Black
Write-Host " "
Write-Host "Command Parameter: "  -ForegroundColor DarkCyan
Write-Host "        <no_parameter> : Default 'Customizable' option ('auto-proxy-on') " -ForegroundColor Green
Write-Host "        all-off        : All Proxy Options are 'Off'. " -ForegroundColor Green
Write-Host "        auto-on        : The 'Automatically detect settings' option is 'On' " -ForegroundColor Green
Write-Host "        proxy-on       : The 'Use a proxy server' option is 'On'  " -ForegroundColor Green
Write-Host "        auto-proxy-on  : Both 'Automatically detect settings' and 'Use a proxy server' option is 'On' " -ForegroundColor Green
Write-Host " "
Write-Host "Usage Example: " -ForegroundColor DarkCyan
Write-Host "        setproxy " -ForegroundColor Green
Write-Host "        setproxy all-off " -ForegroundColor Green
Write-Host "        setproxy auto-on " -ForegroundColor Green
Write-Host "        setproxy proxy-on " -ForegroundColor Green
Write-Host "        setproxy auto-proxy-on" -ForegroundColor Green
Write-Host " "
Write-Host "--------------------------------------------------------------------------------------------------------------"
Write-Host " "


# Customizable Development Reference
################################################################################################################
# Enable/Disable IE Proxy/"Use automatic configuration script"                                                 # 
################################################################################################################
#$RegKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections'
#$Settings = (Get-ItemProperty -Path $RegKey).DefaultConnectionSettings
# $Settings[8] value:
# 1 | 01 –> All unchecked
# 3 | 03 –> Use a Proxy Server…” (2) checked
# 9 | 09 –> “Automatically detect settings” (8) checked
# 11 | 0b (1+8+2) –> “Automatically detect settings” (8) and “Use a Proxy Server…” (2) checked
# 13 | 0d (1+8+4) –> “Automatically detect settings” (8) and “Use Automatic configuration script” (4) checked
# 15 | 0f (1+8+4+2) –> All three check box are checked
################################################################################################################

function Set-OSProxyOption
{
    [CmdletBinding()]
    [Alias('setproxy')]
    # [OutputType([int])]
    Param
    (
        # Proxy Option
        [Parameter(Mandatory=$false, Position=0, HelpMessage="Only 'all-off','auto-on', 'proxy-on' and 'auto-proxy-on' allowed for the paramter.")]
        [ValidateSet('all-off', 'auto-on', 'proxy-on', 'auto-proxy-on')]
        [string]
        $proxy_option = 'auto-proxy-on'
        # $proxy_option

    )

    Begin
    {
        $RegKey = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections'
        $Settings = (Get-ItemProperty -Path $RegKey).DefaultConnectionSettings

        if ( $Settings[8] -eq 1 )
        {            
            Write-Host " "
            Write-Host "Before Change: " -ForegroundColor Magenta
            Write-Host "All Proxy Options are 'Off' now!" -ForegroundColor Blue -BackgroundColor Yellow

        } elseif ( $Settings[8] -eq 9 ) {
            
            Write-Host " "
            Write-Host "Before Change: " -ForegroundColor Magenta
            Write-Host "The 'Automatically detect settings' option is 'On' now!" -ForegroundColor Blue -BackgroundColor Yellow
        
        } elseif ( $Settings[8] -eq 3 ) {

            Write-Host " "
            Write-Host "Before Change: " -ForegroundColor Magenta
            Write-Host "The 'Use a proxy server' option is 'On' now!" -ForegroundColor Blue -BackgroundColor Yellow    

        } elseif ( $Settings[8] -eq 11 ) {

            Write-Host " "
            Write-Host "Before Change: " -ForegroundColor Magenta
            Write-Host "Both 'Automatically detect settings' and 'Use a proxy server' option is 'On' now!" -ForegroundColor Blue -BackgroundColor Yellow    

        } else {

            Write-Host "WARNING: The 'Use setup script' option is 'On' now!" -ForegroundColor Red -BackgroundColor Yellow
        
        } 

    }
    Process
    {

        if ($proxy_option -eq 'all-off') {

        $Settings[8] = 1

        Set-ItemProperty -path $regKey -name DefaultConnectionSettings -value $Settings
        # msg console /time:3 "Proxy is disabled now!"
        Write-Host " "
        Write-Host "After Change: " -ForegroundColor Magenta
        Write-Host "All Proxy Options are 'Off' now!" -ForegroundColor Green -BackgroundColor Yellow
        Write-Host " "

        } elseif ($proxy_option -eq 'auto-on') {

        $Settings[8] = 9
        Set-ItemProperty -path $regKey -name DefaultConnectionSettings -value $Settings
        # msg console /time:3 "Proxy is disabled now!"
        Write-Host " "
        Write-Host "After Change: " -ForegroundColor Magenta
        Write-Host "The 'Automatically detect settings' option is 'On' now!" -ForegroundColor Green -BackgroundColor Yellow
        Write-Host " "

        } elseif ($proxy_option -eq 'proxy-on') {

        $Settings[8] = 3

        Set-ItemProperty -path $regKey -name DefaultConnectionSettings -value $Settings
        Write-Host " "
        Write-Host "After Change: " -ForegroundColor Magenta
        Write-Host "The 'Use a proxy server' option is 'On' now!" -ForegroundColor Green -BackgroundColor Yellow
        Write-Host " "

        } elseif ($proxy_option -eq 'auto-proxy-on') {

        $Settings[8] = 11

        Set-ItemProperty -path $regKey -name DefaultConnectionSettings -value $Settings

        Write-Host " "
        Write-Host "After Change: " -ForegroundColor Magenta
        Write-Host "Both 'Automatically detect settings' and 'Use a proxy server' option is 'On' now!" -ForegroundColor Green -BackgroundColor Yellow
        Write-Host " "

        } else {

        Write-Host "WARNING: The 'Use setup script' option is 'On' now!" -ForegroundColor Red -BackgroundColor DarkYellow

        }

    }
    End
    {
        Write-Host "****************************************************************************************************" -Foregroundcolor Green -Backgroundcolor Black 
        Write-Host " "
        Write-Host "The 'Use setup script' option has been 'Unchecked' successfully now!" -Foregroundcolor Green -Backgroundcolor Black
        Write-Host " "
        Write-Host "****************************************************************************************************" -Foregroundcolor Green -backgroundcolor Black

    }
}

# GUI Creation
# Load required assemblies 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Your 'setproxy' function
# function setproxy {
#     param (
#         [string]$proxyMode 
#     )

#     # Your actual proxy configuration logic here
#     Write-Host "Setting proxy mode to: $proxyMode"
# }

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Set Proxy Option' 
$form.Size = New-Object System.Drawing.Size(600,300) 
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'

# Create buttons for function parameters
# $buttonParameters = @('default', 'all-off', 'auto-on', 'proxy-on', 'auto-proxy-on')
$buttonParameters = @('all-off', 'auto-on', 'proxy-on', 'auto-proxy-on')
$buttons = @() # Array to store button objects

# Calculate button positioning
$buttonWidth = 100
$buttonHeight = 30
$buttonTop = 20
$buttonSpacing = 10
$buttonLeft = (($form.Width - $buttonWidth) / 2) - (($buttonWidth + $buttonSpacing) * ($buttonParameters.Count - 1) / 2)

# Create each button
$buttonParameters | ForEach-Object {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $_
    $button.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $button.Location = New-Object System.Drawing.Size($buttonLeft, $buttonTop)
    $buttonLeft += $buttonWidth + $buttonSpacing

    # Add click event handler for each button
    if ( $button.Text -eq 'all-off' ) {

         $button.Add_Click({ setproxy 'all-off' })

    } elseif ( $button.Text -eq 'auto-on' ) {

               $button.Add_Click({ setproxy 'auto-on' })

    } elseif ( $button.Text -eq 'proxy-on') {

               $button.Add_Click({ setproxy 'proxy-on' })
    
    } elseif ($button.Text -eq 'auto-proxy-on') {

        $button.Add_Click({ setproxy 'auto-proxy-on' })
    }
    else { 
            Write-Host 'Not click any button!'        
    }
    # $button.Add_Click({ setproxy $button.Text }) 
    $form.Controls.Add($button) 
    $buttons += $button
}

# Create OK and Cancel buttons
# $buttonOK = New-Object System.Windows.Forms.Button
# $buttonOK.Text = 'OK'
# $buttonOK.Location = New-Object System.Drawing.Size(200, 100) 
# $buttonOK.DialogResult = 'OK'
# $form.Controls.Add($buttonOK)

$buttonCancel = New-Object System.Windows.Forms.Button
$buttonCancel.Text = 'Cancel'
$buttonCancel.Location = New-Object System.Drawing.Size(300, 100) 
$buttonCancel.DialogResult = 'Cancel' 
$form.Controls.Add($buttonCancel)

# Display the form
$form.ShowDialog() 
