@echo off
chcp 65001 >nul
title Talerz - naprawa
cd /d "%~dp0"

echo.
echo   ==========================================
echo     TALERZ - naprawa
echo   ==========================================
echo.
echo   Ten plik uruchamia aplikacje z wyczyszczona pamiecia podreczna.
echo.
echo   Uzyj go, gdy:
echo     - zmienil sie plik .env
echo     - aplikacja pokazuje bledy, ktorych wczesniej nie bylo
echo     - zmiany w kodzie nie sa widoczne mimo zapisania
echo.
echo   ------------------------------------------------------
echo.

where node >nul 2>nul
if errorlevel 1 (
  echo   BLAD: nie znaleziono Node.js. Pobierz go ze strony https://nodejs.org
  echo.
  pause
  exit /b 1
)

if not exist ".env" (
  echo   BLAD: brak pliku .env z danymi polaczenia z baza.
  echo   Skopiuj .env.example jako .env i uzupelnij wartosci.
  echo.
  pause
  exit /b 1
)

echo   Czy pobrac biblioteki od nowa?
echo.
echo     [1] Nie - tylko wyczysc pamiec podreczna  (szybko, zwykle wystarcza)
echo     [2] Tak - usun node_modules i pobierz ponownie  (5 minut, ostatecznosc)
echo.
set /p wybor="   Wpisz 1 albo 2 i nacisnij Enter: "

if "%wybor%"=="2" (
  echo.
  echo   Usuwam node_modules...
  if exist "node_modules" rmdir /s /q "node_modules"
  echo   Pobieram biblioteki od nowa...
  echo.
  call npm.cmd install
  if errorlevel 1 (
    echo.
    echo   BLAD: nie udalo sie pobrac bibliotek.
    echo.
    pause
    exit /b 1
  )
)

if not exist "node_modules" (
  echo.
  echo   Brak bibliotek - pobieram.
  echo.
  call npm.cmd install
)

echo.
echo   Uruchamiam z czyszczeniem pamieci podrecznej.
echo   Pierwsze wczytanie potrwa dluzej niz zwykle.
echo.

call npx.cmd expo start --web --clear

echo.
echo   Aplikacja zatrzymana.
echo.
pause
