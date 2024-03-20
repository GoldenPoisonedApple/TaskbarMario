Add-Type -AssemblyName System.Windows.Forms

#Install-Module ThreadJob -Scope CurrentUser


# ウィンドウ1の定義
$Form1 = New-Object System.Windows.Forms.Form
$Form1.Text = "Window 1"
$Form1.Size = New-Object System.Drawing.Size(300, 200)
$Form1.StartPosition = "CenterScreen"

# ウィンドウ2の定義
$Form2 = New-Object System.Windows.Forms.Form
$Form2.Text = "Window 2"
$Form2.Size = New-Object System.Drawing.Size(300, 200)
$Form2.StartPosition = "CenterScreen"

# ウィンドウ表示用のスレッド1
$thread1 = [System.Threading.Thread]::new({
    param($Form)
    $Form.ShowDialog()
})

# ウィンドウ表示用のスレッド2
$thread2 = [System.Threading.Thread]::new({
    param($Form)
    $Form.ShowDialog()
})

# スレッドを開始する
$thread1.Start($Form1)
$thread2.Start($Form2)

# 両方のスレッドが終了するまで待機
while ($thread1.IsAlive -or $thread2.IsAlive) {
    Start-Sleep -Milliseconds 100
}

# 全てのウィンドウを閉じる
$Form1.Dispose()
$Form2.Dispose()
