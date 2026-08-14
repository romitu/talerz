@echo off
chcp 65001 >nul
title Talerz
cd /d "%~dp0"

echo.
echo   ==========================================
echo     TALERZ
echo   ==========================================
echo.

rem --- czy Node.js jest zainstalowany ---
where node >nul 2>nul
if errorlevel 1 (
  echo   BLAD: nie znaleziono Node.js.
  echo.
  echo   Pobierz wersje LTS ze strony https://nodejs.org
  echo   i zainstaluj, a potem uruchom ten plik ponownie.
  echo.
  pause
  exit /b 1
)

rem --- czy sa dane polaczenia z baza ---
if not exist ".env" (
  echo   BLAD: brak pliku .env z danymi polaczenia z baza.
  echo.
  echo   Skopiuj plik .env.example, nazwij kopie .env
  echo   i wpisz w niej adres projektu oraz klucz z panelu Supabase.
  echo.
  pause
  exit /b 1
)

rem --- czy biblioteki sa pobrane ---
if not exist "node_modules" (
  echo   Pierwsze uruchomienie - pobieram biblioteki.
  echo   Potrwa 2-5 minut, ale tylko ten jeden raz.
  echo.
  call npm.cmd install
  if errorlevel 1 (
    echo.
    echo   BLAD: nie udalo sie pobrac bibliotek.
    echo   Sprawdz polaczenie z internetem i sprobuj ponownie.
    echo.
    pause
    exit /b 1
  )
  echo.
)

echo   Uruchamiam aplikacje.
echo.
echo   PRZEGLADARKA otworzy sie sama za chwile.
echo   TELEFON: zeskanuj kod QR aplikacja Expo Go
echo            (telefon i komputer w tej samej sieci Wi-Fi).
echo.
echo   Zakonczenie pracy: Ctrl+C albo zamkniecie tego okna.
echo   ------------------------------------------------------
echo.

call npx.cmd expo start --web

echo.
echo   Aplikacja zatrzymana.
echo.
pause
