# Wypycha biezace zmiany z lokalnego repo na GitHub (origin/main)
# Uzycie:
#   powershell -ExecutionPolicy Bypass -File push-do-github.ps1
#   powershell -ExecutionPolicy Bypass -File push-do-github.ps1 -Wiadomosc "Opis zmian"

param(
    [string]$Wiadomosc = "Aktualizacja $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
)

$ErrorActionPreference = "Stop"

Write-Host "== Status repozytorium ==" -ForegroundColor Cyan
git status

$doZacommitowania = git status --porcelain
if (-not $doZacommitowania) {
    Write-Host "`nBrak lokalnych zmian do zacommitowania." -ForegroundColor Yellow
} else {
    Write-Host "`n== Dodawanie zmian do commita ==" -ForegroundColor Cyan
    git add -A

    Write-Host "`n== Zmiany do zacommitowania ==" -ForegroundColor Cyan
    git status --short

    Write-Host "`n== Tworzenie commita ==" -ForegroundColor Cyan
    git commit -m $Wiadomosc
    if ($LASTEXITCODE -ne 0) {
        Write-Host "`nCommit sie nie powiodl (kod $LASTEXITCODE)." -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

$przedPush = git rev-parse HEAD
$naZdalnym = git rev-parse origin/main 2>$null

if ($przedPush -eq $naZdalnym) {
    Write-Host "`nGalaz jest juz zsynchronizowana z origin/main -- nic do wypchniecia." -ForegroundColor Yellow
} else {
    Write-Host "`n== Wypychanie na GitHub (origin/main) ==" -ForegroundColor Cyan
    git push origin main
    if ($LASTEXITCODE -ne 0) {
        Write-Host "`nPush sie nie powiodl (kod $LASTEXITCODE)." -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

Write-Host "`nGotowe. Sprawdz: https://github.com/romitu/talerz" -ForegroundColor Green
