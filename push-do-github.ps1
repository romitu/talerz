# Wypycha biezace zmiany z lokalnego repo na GitHub (origin/main)
# Uzycie:  powershell -ExecutionPolicy Bypass -File push-do-github.ps1

$ErrorActionPreference = "Stop"

Write-Host "== Status repozytorium ==" -ForegroundColor Cyan
git status

Write-Host "`n== Dodawanie zmian do commita ==" -ForegroundColor Cyan
git add -A

Write-Host "`n== Zmiany do zacommitowania ==" -ForegroundColor Cyan
git status --short

$wiadomosc = "Import/eksport przepisow, preferencje uzytkownika, instrukcja"

Write-Host "`n== Tworzenie commita ==" -ForegroundColor Cyan
git commit -m $wiadomosc

Write-Host "`n== Wypychanie na GitHub (origin/main) ==" -ForegroundColor Cyan
git push origin main

Write-Host "`nGotowe. Sprawdz: https://github.com/romitu/talerz" -ForegroundColor Green
