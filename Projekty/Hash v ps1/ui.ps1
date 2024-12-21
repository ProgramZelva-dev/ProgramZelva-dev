Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"

# Vytvořeni formulaře
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Hashovani Textu | ProgramZelva'
$form.Size = New-Object System.Drawing.Size(500, 290)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.BackColor = [System.Drawing.Color]::White
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

# Moderni font
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Vytvořeni textového pole pro zadani textu
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Size = New-Object System.Drawing.Size(400, 30)
$textBox.Location = New-Object System.Drawing.Point(50, 50)
$textBox.Font = New-Object System.Drawing.Font("Segoe UI", 12)

# Vytvořeni ComboBoxu pro vyběr algoritmu
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Items.AddRange(@("MD5", "SHA1", "SHA256", "SHA384", "SHA512"))
$comboBox.Location = New-Object System.Drawing.Point(50, 100)
$comboBox.Size = New-Object System.Drawing.Size(200, 30)
$comboBox.Font = New-Object System.Drawing.Font("Segoe UI", 12)
$comboBox.SelectedItem = "MD5"  # Automaticky vybere MD5

# Vytvořeni tlačitka pro spuštěni hasovani
$button = New-Object System.Windows.Forms.Button
$button.Text = "Hashuj Text"
$button.Size = New-Object System.Drawing.Size(100, 40)
$button.Location = New-Object System.Drawing.Point(50, 150)
$button.Font = New-Object System.Drawing.Font("Segoe UI", 12)
$button.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)  # Tlačitko v barvě Windows 11
$button.ForeColor = [System.Drawing.Color]::White
$button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button.FlatAppearance.BorderSize = 0
$button.Cursor = [System.Windows.Forms.Cursors]::Hand

# Vytvořeni label pro zobrazeni vysledku hasovani
$resultLabel = New-Object System.Windows.Forms.Label
$resultLabel.Size = New-Object System.Drawing.Size(400, 30)
$resultLabel.Location = New-Object System.Drawing.Point(50, 200)
$resultLabel.Text = ""
$resultLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12)

# Funkce pro hasovani textu
function Hash-Text {
    param (
        [string]$text,
        [string]$algorithm
    )

    # Převeď text na bajty
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $hashBytes = $null

    # Generovani hashe podle algoritmu
    switch ($algorithm.ToLower()) {
        "md5" { $hashBytes = [System.Security.Cryptography.MD5]::Create().ComputeHash($bytes) }
        "sha1" { $hashBytes = [System.Security.Cryptography.SHA1]::Create().ComputeHash($bytes) }
        "sha256" { $hashBytes = [System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes) }
        "sha384" { $hashBytes = [System.Security.Cryptography.SHA384]::Create().ComputeHash($bytes) }
        "sha512" { $hashBytes = [System.Security.Cryptography.SHA512]::Create().ComputeHash($bytes) }
        default { $resultLabel.Text = "Neplatny algoritmus."; return }
    }

    # Vypis vysledku
    if ($hashBytes -ne $null) {
        $hash = [BitConverter]::ToString($hashBytes) -replace "-", ""
        $resultLabel.Text = "${algorithm}: $hash"
    } else {
        $resultLabel.Text = "Chyba pri generovani hashe."
    }
}

# Akce po kliknuti na tlačitko
$button.Add_Click({
    $text = $textBox.Text
    $algorithm = $comboBox.SelectedItem

    # Ověřeni vstupu
    if ([string]::IsNullOrEmpty($text)) {
        $resultLabel.Text = "Prosim, zadejte text k zahashovani."
        return
    }

    if ([string]::IsNullOrEmpty($algorithm)) {
        $resultLabel.Text = "Prosim, vyberte algoritmus."
        return
    }

    # Zavolani funkce pro hasovani
    Hash-Text -text $text -algorithm $algorithm
})

# Přidani ovladacich prvků do formulaře
$form.Controls.Add($textBox)
$form.Controls.Add($comboBox)
$form.Controls.Add($button)
$form.Controls.Add($resultLabel)

# Zobrazeni formulaře
[void]$form.ShowDialog()
