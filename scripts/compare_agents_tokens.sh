#!/usr/bin/env bash
set -euo pipefail

DEFAULT_FILES=(
  "AGENTS.original.md"
  "AGENTS.md"
  "AGENTS.compact.md"
  "AGENTS.classical.md"
  "AGENTS.compact.classical.md"
)

if [[ $# -gt 0 ]]; then
  FILES=("$@")
else
  FILES=("${DEFAULT_FILES[@]}")
fi

estimate_tokens() {
  local file="$1"
  # Approximation strategy:
  # 1) One CJK character ~= one token
  # 2) One ASCII word chunk ~= one token
  # 3) One non-space symbol ~= one token
  perl -CSDA -ne 'while(/([\x{3400}-\x{9FFF}]|[A-Za-z0-9_]+|[^\s])/g){$count++} END{print $count+0}' "$file"
}

count_lines() {
  awk 'END{print NR+0}' "$1"
}

count_non_empty_lines() {
  awk 'NF{count++} END{print count+0}' "$1"
}

tmp_rows="$(mktemp "${TMPDIR:-/tmp}/compare_agents_tokens.XXXXXX")"
trap 'rm -f "$tmp_rows"' EXIT

for file in "${FILES[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "File not found: $file" >&2
    exit 1
  fi

  lines="$(count_lines "$file")"
  non_empty_lines="$(count_non_empty_lines "$file")"
  chars="$(wc -m < "$file" | tr -d '[:space:]')"
  bytes="$(wc -c < "$file" | tr -d '[:space:]')"
  estimated_tokens="$(estimate_tokens "$file")"

  printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$file" "$lines" "$non_empty_lines" "$chars" "$bytes" "$estimated_tokens" >> "$tmp_rows"
done

baseline_tokens="$(awk -F '\t' '$1=="AGENTS.original.md"{print $6; found=1; exit} END{if(!found) print ""}' "$tmp_rows")"
if [[ -z "$baseline_tokens" ]]; then
  baseline_tokens="$(awk -F '\t' 'NR==1{print $6}' "$tmp_rows")"
fi

echo "Token comparison (estimated, approximation only):"

awk -F '\t' -v base="$baseline_tokens" '
BEGIN {
  h1 = "File";
  h2 = "EstimatedTokens";
  h3 = "SavedVsOriginal";
  h4 = "SavedPctVsOriginal";
  h5 = "NonEmptyLines";
  h6 = "Bytes";
  w1 = length(h1); w2 = length(h2); w3 = length(h3);
  w4 = length(h4); w5 = length(h5); w6 = length(h6);
}
{
  file = $1;
  non_empty = $3;
  bytes = $5;
  tokens = $6 + 0;

  saved = base - tokens;
  saved_int = int(saved >= 0 ? saved + 0.5 : saved - 0.5);
  pct = (base == 0 ? 0 : (saved / base) * 100);
  pct_str = sprintf("%.2f%%", pct);

  files[NR] = file;
  tok_vals[NR] = tokens;
  saved_vals[NR] = saved_int;
  pct_vals[NR] = pct_str;
  non_empty_vals[NR] = non_empty;
  byte_vals[NR] = bytes;

  if (length(file) > w1) w1 = length(file);
  if (length(tok_vals[NR]) > w2) w2 = length(tok_vals[NR]);
  if (length(saved_vals[NR]) > w3) w3 = length(saved_vals[NR]);
  if (length(pct_str) > w4) w4 = length(pct_str);
  if (length(non_empty) > w5) w5 = length(non_empty);
  if (length(bytes) > w6) w6 = length(bytes);
}
END {
  fmt = "%-" w1 "s  %" w2 "s  %" w3 "s  %" w4 "s  %" w5 "s  %" w6 "s\n";
  printf fmt, h1, h2, h3, h4, h5, h6;
  for (i = 1; i <= NR; i++) {
    printf fmt, files[i], tok_vals[i], saved_vals[i], pct_vals[i], non_empty_vals[i], byte_vals[i];
  }
}
' "$tmp_rows"
