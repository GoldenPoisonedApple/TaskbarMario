Add-Type -AssemblyName System.Windows.Forms

# タスクバーの高さ
$TASKBAR_HEIGHT = 35

# ウィンドウの作成
$form = New-Object System.Windows.Forms.Form
# ControlBox プロパティを使って"×"マークを非表示にする
$form.ControlBox = $false
# ウィンドウのサイズを設定
# 136 x 50 が最小サイズ
$form.MinimumSize = New-Object System.Drawing.Size(136, 50)
$form.Size = New-Object System.Drawing.Size(136, 50)
# ウィンドウの境界スタイルを設定
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle



# 画面の中央にウィンドウを配置
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screen_x = $screen.Bounds.Width
$screen_y = $screen.Bounds.Height - $TASKBAR_HEIGHT
Write-Host "Screen size: $screen_x x $screen_y"
$form_width = $form.Width
$form_height = $form.Height
Write-Host "Form size: $form_width x $form_height"

# ウィンドウの位置を設定
$form.StartPosition = "Manual"
$form.Left = $screen_x - $form_width
$form.Top = $screen_y - $form_height

# ウィンドウを表示
$form.ShowDialog()