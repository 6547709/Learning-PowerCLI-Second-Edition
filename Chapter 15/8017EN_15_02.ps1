# The path to the HTML file
$FilePath = 'c:\VMHostsConnectionState.html'

# Create the HTML header
$Header = @"
<!DOCTYPE html>
<html>
  <head>
    <title>VMware vSphere Hosts ConnectionState Report</title>
    <style>
      body  {background-color: lightgray}
      table {background-color: white}
      th    {color: white; background-color: darkgray}
      tr    {background-color: white}
    </style>
  </head>
  <body>
    <h2>VMware vSphere Hosts ConnectionState Report</h2>
"@

# Create the VMHost ConnectionState report table
$Fragment = Get-VMHost |
Select-Object -Property Name,ConnectionState |
Sort-Object -Property Name |
ConvertTo-Html -Fragment

# Create the tail of the HTML page
$Tail = @"
  </body>
</html>
"@

# Combine all of the pieces into one HTML page
$HTML = $Header
$HTML += $Fragment
$HTML += $Tail

# Color Connected green and Disconnected red
$HTML = $HTML.Replace('<td>Connected</td>',
  '<td style="color: green">Connected</td>').Replace('<td>Disconnected</td>',
  '<td style="color: red">Disconnected</td>')

# Save the output in a file
$HTML | Out-File -FilePath $FilePath

# Open a web browser and display the page
Start-Process -FilePath $FilePath