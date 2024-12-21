# Tvoje logo
Write-Output "PPPPPPPPPPPPPPPPPPP     ZZZZZZZZZZZZZZZZZZZZZ
P::::::::::::::::P     Z:::::::::::::::::::Z
P::::::PPPPPP:::::P   ZZZZZZZZZZZZZ::::ZZZZ
PP:::::P     P:::::P              Z::::Z
  P::::P     P:::::P             Z::::Z
  P::::P     P:::::P            Z::::Z
  P::::PPPPPP:::::P            Z::::Z
  P:::::::::::::PP            Z::::Z
  P::::PPPPPPPPP             Z::::Z
  P::::P                    Z::::Z
  P::::P                   Z::::Z
  P::::P                  Z::::Z
PP::::::PP               Z::::Z
P::::::::P            ZZZZ::::ZZZZZZZZZZZZZZ
P::::::::P           Z::::::::::::::::::::Z
PPPPPPPPPPP         ZZZZZZZZZZZZZZZZZZZZZZ

--------------------------------------------
                ProgramZelva
--------------------------------------------"

# Funkce pro zobrazeni napovedy
function Show-Help {
    Write-Output "`nPouziti: Do pole Zadejte text k zahashovani zadejte text co chcete zahashovat.`n"
    Write-Output "Do pole Zadejte algoritmus zadejte jeden z Podporovanych algoritmu`n"
    Write-Output "Priklady:"
    Write-Output "Zadej text k zahashovani (nebo 'exit' pro ukonceni): 1234"
    Write-Output "Zadej algoritmus (MD5, SHA1, SHA256, SHA384, SHA512) md5`n"
    Write-Output "Podporovane algoritmy: MD5, SHA1, SHA256, SHA384, SHA512`n"
}

# Funkce pro hasovani textu
function Hash-Text {
    param (
        [string]$text,
        [string]$algorithm
    )

    # Preved text na bajty
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $hashBytes = $null

    # Generovani hashe podle algoritmu
    switch ($algorithm) {
        "md5" { $hashBytes = [System.Security.Cryptography.MD5]::Create().ComputeHash($bytes) }
        "sha1" { $hashBytes = [System.Security.Cryptography.SHA1]::Create().ComputeHash($bytes) }
        "sha256" { $hashBytes = [System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes) }
        "sha384" { $hashBytes = [System.Security.Cryptography.SHA384]::Create().ComputeHash($bytes) }
        "sha512" { $hashBytes = [System.Security.Cryptography.SHA512]::Create().ComputeHash($bytes) }
        default { Show-Help; return }
    }

    # Vypis vysledku
    if ($hashBytes -ne $null) {
        $hash = [BitConverter]::ToString($hashBytes) -replace "-", ""
        Write-Output "$($algorithm.ToUpper()): $hash"
    } else {
        Show-Help
    }
}

# Zobrazeni napovedy
Show-Help

# Hlavni smycka pro interaktivni zadavani
while ($true) {
    # Zadani textu a algoritmu
    $text = Read-Host "Zadej text k zahashovani (nebo 'exit' pro ukonceni)"
    if ($text.ToLower() -eq "exit") {
        Write-Output "Ukoncuji program..."
        break
    }

    $algorithm = Read-Host "Zadej algoritmus (MD5, SHA1, SHA256, SHA384, SHA512)"
    
    # Overeni vstupu
    if ([string]::IsNullOrEmpty($text) -or [string]::IsNullOrEmpty($algorithm)) {
        Write-Output "Neplatny vstup. Zkuste to znovu."
        continue
    }

    # Zavolani funkce pro hasovani
    Hash-Text -text $text -algorithm $algorithm
}
