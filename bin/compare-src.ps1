# Compare-TWebSite.ps1
# Searches for all TWebSite.php files and compares them to a reference file

param(
    [string]$SearchRoot = "D:\dev\twoquakers\peanut2\",
    [string]$ReferenceFile = "D:\dev\twoquakers\peanut2\peanut-core\web.root\tq-peanut\src\tops\sys\TWebSite.php",
    [int]$ColumnWidth = 80   # width of each side in the side-by-side diff
)

# ── Helpers ──────────────────────────────────────────────────────────────────

function Truncate([string]$s, [int]$max) {
    if ($s.Length -le $max) { return $s.PadRight($max) }
    return $s.Substring(0, $max - 3) + "..."
}

function Show-SideBySideDiff {
    param(
        [string]$LeftPath,
        [string]$RightPath,
        [int]$Width = 80
    )

    $left  = Get-Content $LeftPath
    $right = Get-Content $RightPath

    $separator = " | "
    $divider   = ("-" * $Width) + "---+-" + ("-" * $Width)
    $header    = (Truncate "<<<  REFERENCE" $Width) + $separator + (Truncate ">>>  $RightPath" $Width)

    Write-Host "`n$divider"
    Write-Host $header -ForegroundColor Cyan
    Write-Host "$divider"

    # Compute LCS-based diff with line numbers using Compare-Object per-line tracking
    # Build indexed arrays
    $maxLines = [Math]::Max($left.Count, $right.Count)

    # Use a simple two-pointer walk after getting the diff hunks
    # Strategy: align by running Compare-Object then reconstruct pairs
    $diff = Compare-Object -ReferenceObject $left -DifferenceObject $right `
                           -IncludeEqual -SyncWindow ($maxLines)

    foreach ($entry in $diff) {
        $indicator = $entry.SideIndicator
        $line      = $entry.InputObject

        switch ($indicator) {
            "==" {
                # identical line — show on both sides, no highlight
                $l = Truncate $line $Width
                $r = Truncate $line $Width
                Write-Host "$l$separator$r"
            }
            "<=" {
                # only in reference (left) — highlight red
                $l = Truncate $line $Width
                $r = " " * $Width
                Write-Host "$l" -ForegroundColor Red -NoNewline
                Write-Host "$separator$r"
            }
            "=>" {
                # only in candidate (right) — highlight green
                $l = " " * $Width
                $r = Truncate $line $Width
                Write-Host $l -NoNewline
                Write-Host "$separator" -NoNewline
                Write-Host "$r" -ForegroundColor Green
            }
        }
    }

    Write-Host "$divider`n"
}

# ── Main ─────────────────────────────────────────────────────────────────────

if (-not (Test-Path $ReferenceFile)) {
    Write-Error "Reference file not found: $ReferenceFile"
    exit 1
}

$refHash  = (Get-FileHash $ReferenceFile -Algorithm MD5).Hash
$refSize  = (Get-Item $ReferenceFile).Length
$refLines = (Get-Content $ReferenceFile).Count

Write-Host "`nReference file : $ReferenceFile"
Write-Host "MD5            : $refHash"
Write-Host "Size           : $refSize bytes  |  Lines: $refLines"
Write-Host "`nSearching for 'TWebSite.php' under $SearchRoot ...`n"
Write-Host ("=" * 100)

$found = Get-ChildItem -Path $SearchRoot -Filter "TWebSite.php" -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -ne $ReferenceFile }

if (-not $found) {
    Write-Host "No other TWebSite.php files found."
    exit 0
}

$identicalCount = 0
$differentCount = 0

foreach ($file in $found) {

    $fileHash  = (Get-FileHash $file.FullName -Algorithm MD5).Hash
    $fileSize  = $file.Length
    $fileLines = (Get-Content $file.FullName).Count
    $identical = $fileHash -eq $refHash

    if ($identical) {
        $identicalCount++
        Write-Host "[IDENTICAL]  $($file.FullName)" -ForegroundColor Green
        Write-Host "             MD5: $fileHash  |  $fileSize bytes  |  $fileLines lines"
    } else {
        $differentCount++

        $refContent   = Get-Content $ReferenceFile
        $fileContent  = Get-Content $file.FullName
        $diff         = Compare-Object $refContent $fileContent
        $added        = ($diff | Where-Object { $_.SideIndicator -eq "=>" }).Count
        $removed      = ($diff | Where-Object { $_.SideIndicator -eq "<=" }).Count

        Write-Host "[DIFFERENT]  $($file.FullName)" -ForegroundColor Yellow
        Write-Host "             MD5   : $fileHash  (ref: $refHash)"
        Write-Host "             Size  : $fileSize bytes  (ref: $refSize bytes)"
        Write-Host "             Lines : $fileLines  (ref: $refLines)  |  +$added / -$removed vs reference"

        Show-SideBySideDiff -LeftPath $ReferenceFile -RightPath $file.FullName -Width $ColumnWidth
    }

    Write-Host ("=" * 100)
}

Write-Host "`nSummary: $(($found | Measure-Object).Count) file(s) found  |  $identicalCount identical  |  $differentCount different`n"