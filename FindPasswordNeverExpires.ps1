Function Select-FolderDialog
{
    param([string]$Description="Vælg hvor filen skal gemmes",[string]$RootFolder="MyComputer")

  #[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
  #   Out-Null   

   $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
        $objForm.Rootfolder = $RootFolder
        $objForm.Description = $Description
        $Show = $objForm.ShowDialog()
        If ($Show -eq "OK")
        {
            Return $objForm.SelectedPath
        }
        Else
        {
            Write-Host "Operation cancelled by user."
        }
}
$answer = read-host -Prompt "Vil du gemme denne fil som csv? [Yes/No] "
$scope = Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $True}
#Export-csv "C:\Users\explmm\Documents\CSV-filer\test.csv" -Delimiter ";"
$ht = @{}
[regex]$regex = '[0-9]{6,7}|EXP[A-Z]{3,}|IBM[A-Z]{3,}'
$users = $regex.Matches($scope) | ForEach-Object{$_.Value}
try{
foreach($user in $users){
    $fulluser = $user + "*"
    $d = Get-ADuser -Filter {Samaccountname -like $fulluser} -Properties Passwordneverexpires,Department, Description | Select-Object SamAccountName, Department, Description, Passwordneverexpires -ErrorAction SilentlyContinue
    foreach($f in $d.samaccountname){
    $d = Get-ADuser -Identity $f -Properties Passwordneverexpires,Department, Description | Select-Object SamAccountName, Department, Description, Passwordneverexpires -ErrorAction SilentlyContinue
    $ht.add($f,$d)                                
    }
    }
}catch{}


try
{
    if($answer -eq "No")
    {
    
    $ht.Values.GetEnumerator()
        
    }
    else{
        $folder = Select-FolderDialog
        $filename = Read-Host 'Hvad vil du kalde filen?'
        $ht.Values.GetEnumerator() | Export-Csv -NoTypeInformation -Path "$folder\$filename.csv" -Delimiter ";"
        Write-Host "Filen er placeret her : '$folder\$filename.csv'" -ForegroundColor Green
    }

}
catch
{
    Write-Host " "
    Write-Host "Fejl" -ForegroundColor Red
    Write-Host " "
   
}
