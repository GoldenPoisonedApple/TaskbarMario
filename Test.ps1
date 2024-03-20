Add-Type -AssemblyName System.Windows.Forms

# ウィンドウの作成
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(50, 50)  # ウィンドウのサイズを設定

# 画面の中央にウィンドウを配置
$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screen_x = $screen.Bounds.Width
$screen_y = $screen.Bounds.Height
Write-Host "Screen size: $screen_x x $screen_y"
$form_width = $form.Width
$form_height = $form.Height
Write-Host "Form size: $form_width x $form_height"

$form.StartPosition = "Manual"

$form.Left = $screen_x - $form_width
$form.Top = $screen_y - $form_height
# $form.Left = 0
# $form.Top = 0

# ウィンドウを表示
$form.ShowDialog()