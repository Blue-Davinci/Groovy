# Acts as a prompt for make executions
$ans = Read-Host "Are you sure? [y/N]"
if ($ans -ne "y") {
    exit 1
}
