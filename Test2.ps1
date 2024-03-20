Add-Type -AssemblyName System.Windows.Forms

# 画像のパスを指定
$imagePaths = @("img/1.png", "img/2.png", "img/3.png", "img/4.png")

# フォームを作成
$form = New-Object Windows.Forms.Form
$form.Text = "Animated Image Viewer"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(400, 300)

# PictureBoxを作成
$pictureBox = New-Object Windows.Forms.PictureBox
$pictureBox.Dock = [System.Windows.Forms.DockStyle]::Fill
$form.Controls.Add($pictureBox)
# フォームを表示
$form.Show() | Out-Null

while ($true) {
	foreach ($path in $imagePaths) {
		Write-Host "Switching Image to $path"
			$image = [System.Drawing.Image]::FromFile($path)
			$pictureBox.Image = $image
			$form.Refresh()
			Start-Sleep -Milliseconds 100
	}
}
