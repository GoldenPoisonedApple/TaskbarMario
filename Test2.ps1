Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# タスクバーの高さ
$TASKBAR_HEIGHT = 35
# 画像のパスを指定
$imagePath = "img/1.png"

# ウィンドウの作成
$form = New-Object System.Windows.Forms.Form
# ControlBox プロパティを使って"×"マークを非表示にする
$form.ControlBox = $false
# タスクバーに表示しないようにする
$form.ShowInTaskbar = $false
# ウィンドウの境界スタイルを設定
$sys_windows_forms_formBorderstyle = "System.Windows.Forms.FormBorderStyle" -as [type]
$form.FormBorderStyle = $sys_windows_forms_formBorderstyle::None

# ウィンドウのサイズを設定
# 136 x 50 が最小サイズ
$form.MinimumSize = New-Object System.Drawing.Size(136, 50)
$form.Size = New-Object System.Drawing.Size(136, 50)
# クライアント領域のサイズを設定
# 50 x 50 だと画像がはみ出るので 45 x 45
$form.ClientSize = New-Object System.Drawing.Size(45, 45)

# 画像の読み込み
$sys_drawing_image = "System.Drawing.Image" -as [type]
$image = $sys_drawing_image::FromFile($imagePath)
# ピクチャーボックスの作成
$pictureBox = New-Object System.Windows.Forms.PictureBox
		
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$pictureBox.Image = $image
$pictureBox.Width = $form.ClientSize.Width
$pictureBox.Height = $form.ClientSize.Height
# ピクチャーボックスをフォームに追加
$form.Controls.Add($pictureBox)

# 画面の中央にウィンドウを配置
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screen_x = $screen.Bounds.Width
$screen_y = $screen.Bounds.Height - $TASKBAR_HEIGHT
$form_width = $form.Width
$form_height = $form.Height
$form.StartPosition = "Manual"
$form.Left = $screen_x - $form_width
$form.Top = $screen_y - $form_height



# ウィンドウを表示
$form.ShowDialog()