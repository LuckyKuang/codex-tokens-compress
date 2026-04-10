param(
    [string[]]$Files = @(
        "AGENTS.original.md",
        "AGENTS.md",
        "AGENTS.compact.md",
        "AGENTS.classical.md",
        "AGENTS.compact.classical.md"
    )
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-EstimatedTokens {
    param([string]$Text)

    # Approximation strategy:
    # 1) One CJK character ~= one token
    # 2) One ASCII word chunk ~= one token
    # 3) One non-space symbol ~= one token
    $pattern = '(?<cjk>[\u3400-\u9FFF])|(?<word>[A-Za-z0-9_]+)|(?<symbol>[^\s])'
    return [regex]::Matches($Text, $pattern).Count
}

$rows = @()
foreach ($file in $Files) {
    if (-not (Test-Path -LiteralPath $file)) {
        throw "File not found: $file"
    }

    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $file
    $lines = (Get-Content -Encoding UTF8 -LiteralPath $file).Count
    $nonEmptyLines = (Get-Content -Encoding UTF8 -LiteralPath $file | Where-Object { $_.Trim() -ne "" }).Count
    $chars = $content.Length
    $bytes = [System.Text.Encoding]::UTF8.GetByteCount($content)
    $estimatedTokens = Get-EstimatedTokens -Text $content

    $rows += [PSCustomObject]@{
        File            = $file
        Lines           = $lines
        NonEmptyLines   = $nonEmptyLines
        Characters      = $chars
        Bytes           = $bytes
        EstimatedTokens = $estimatedTokens
    }
}

$baseline = $rows | Where-Object { $_.File -eq "AGENTS.original.md" } | Select-Object -First 1
if (-not $baseline) {
    $baseline = $rows | Select-Object -First 1
}

$baselineTokens = [double]$baseline.EstimatedTokens
$rowsWithSavings = foreach ($row in $rows) {
    $saved = $baselineTokens - [double]$row.EstimatedTokens
    $savedPct = if ($baselineTokens -eq 0) { 0 } else { ($saved / $baselineTokens) * 100 }
    [PSCustomObject]@{
        File                 = $row.File
        EstimatedTokens      = $row.EstimatedTokens
        SavedVsOriginal      = [int][math]::Round($saved, 0)
        SavedPctVsOriginal   = ("{0:N2}%" -f $savedPct)
        NonEmptyLines        = $row.NonEmptyLines
        Bytes                = $row.Bytes
    }
}

Write-Output "Token comparison (estimated, approximation only):"
$rowsWithSavings | Format-Table -AutoSize
