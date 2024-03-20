Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 画像のパスを指定
$imagePath = "img/1.png"

# タスクバー上にマリオを表示する関数
function Show-MarioOnTaskbar {
	# フォームの作成
	$form = New-Object System.Windows.Forms.Form
	$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
	$form.ShowInTaskbar = $false
	$form.StartPosition = "Manual"
	$form.ClientSize = New-Object System.Drawing.Size(40, 32) # マリオ画像のサイズに合わせる

	# 画像の読み込み
	$image = [System.Drawing.Image]::FromFile($imagePath)

	# ピクチャーボックスの作成
	$pictureBox = New-Object System.Windows.Forms.PictureBox
	$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
	$pictureBox.Image = $image
	$pictureBox.Width = $form.ClientSize.Width
	$pictureBox.Height = $form.ClientSize.Height

	# ピクチャーボックスをフォームに追加
	$form.Controls.Add($pictureBox)

	# フォームの位置を設定して表示
	$form.Location = New-Object System.Drawing.Point(([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $form.ClientSize.Width), ([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height - $form.ClientSize.Height))
	$form.TopMost = $true
	$form.Show()

	# マリオを動かす
	while ($true) {
		$form.Left -= 2  # 速度を調整する場合はこの値を変更
		Start-Sleep -Milliseconds 50  # ウェイト時間を調整する場合はこの値を変更
		if ($form.Right -lt 0) {
			# マリオが画面外に出たらフォームを閉じる
			$form.Close()
			break
		}
	}
}

# マリオを表示
Show-MarioOnTaskbar
