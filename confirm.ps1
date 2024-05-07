# Acts as a prompt for makefile executions
$ans = Read-Host "Are you sure? [y/N]"
if ($ans -ne "y") {
    exit 1
}
