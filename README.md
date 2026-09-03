# Sentinel

Sentinel er et overvågningsprojekt skrevet i både Bash og PowerShell for at forstå sprogene. 
Formålet er at indsamle og præsentere information om systemet 

## Funktionalitet

Sentinel indsamler følgende information:

* Brugere
* Kørende services
* Lyttende TCP-porte
* Medlemmer af sudo-/administratorgruppen

Hver indsamling ligger i sin egen funktion. Bash-versionen bruger `main()` som entry point, mens PowerShell-versionen bruger `Invoke-SentinelMain`.

## Logging

Logging er placeret i separate biblioteker, så logging-koden ikke duplikeres i Sentinel-scripts.

Bash bruger:

```text
lib/lib_log.sh
```

PowerShell bruger:

```text
lib/Sentinel.Logging.psm1
```

data output:
- `err` = logs/sektioner
- `out` = selve dataene
(Logs på stderr, data på stdout.)

## Bash

Bash-versionen findes i:

```text
bash/sentinel.sh
```

Scriptet bruger strict mode:

```bash
set -euo pipefail
```

Det anvender blandt andet følgende kommandoer:

```bash
awk
systemctl list-units --type=service --state=running
ss -tlnp
getent group sudo
```

Kør Bash-versionen fra projektets rodmappe:

```bash
./bash/sentinel.sh
```

## PowerShell

PowerShell-versionen findes i:

```text
powershell/Sentinel.ps1
```

Scriptet bruger:

```powershell
$ErrorActionPreference = 'Stop'
```

Logging-modulet importeres fra `lib/Sentinel.Logging.psm1`.

PowerShell-versionen indsamler systeminformation ved hjælp af PowerShell-kommandoer til brugere, services, TCP-forbindelser og administratorgruppen.

Kør PowerShell-versionen:

```powershell
.\powershell\Sentinel.ps1
```

Hvis terminalen allerede står i `powershell`-mappen:

```powershell
.\Sentinel.ps1
```

## Output

Sentinel holder logs og data adskilt:

* `stdout` bruges til de indsamlede data.
* `stderr` bruges til logs og sektionsoverskrifter.

Bash-output kan eksempelvis opdeles med:

```bash
./bash/sentinel.sh > out 2> err
```

Herefter kan logs vises med:

```bash
cat err
```

og data med:

```bash
cat out
```

## Version

Sentinel v0.2
