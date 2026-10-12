# ============================================================
# downloadCSV.ps1
# Telecharge le CSV Scribus le plus recent depuis le serveur
# et le renomme en scribus-dump.csv (nom fixe pour le SSIS)
# ============================================================

$destinationFolder = "C:\BI\Data"
$sourceUrl         = "http://teachingse.hevs.ch/csvFiles/"
$fixedFileName     = "scribus-dump.csv"
$destinationPath   = Join-Path $destinationFolder $fixedFileName

# Creer le dossier de destination s'il n'existe pas
if (-not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
    Write-Host "Dossier cree : $destinationFolder"
}

# Recuperer la page web et extraire tous les liens .csv
Write-Host "Connexion a $sourceUrl ..."
$page = Invoke-WebRequest -Uri $sourceUrl -UseBasicParsing

$csvLinks = $page.Links |
    Where-Object { $_.href -match "\.csv$" } |
    Select-Object -ExpandProperty href |
    Sort-Object -Descending

if ($csvLinks.Count -eq 0) {
    Write-Error "Aucun fichier CSV trouve sur $sourceUrl"
    exit 1
}

# Prendre le fichier le plus recent (premier apres tri decroissant)
$latestFile = $csvLinks[0]
$downloadUrl = $sourceUrl + $latestFile
Write-Host "Fichier le plus recent : $latestFile"

# Supprimer l'ancien fichier si existant
if (Test-Path $destinationPath) {
    Remove-Item $destinationPath -Force
    Write-Host "Ancien fichier supprime."
}

# Telecharger dans un fichier temporaire puis renommer
$tempPath = Join-Path $destinationFolder ("_temp_" + $latestFile)
Write-Host "Telechargement vers $tempPath ..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $tempPath -UseBasicParsing

Rename-Item -Path $tempPath -NewName $fixedFileName
Write-Host "Fichier disponible : $destinationPath"
