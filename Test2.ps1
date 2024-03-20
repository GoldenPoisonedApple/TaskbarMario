Add-Type -AssemblyName System.Windows.Forms

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
$job1 = Start-ThreadJob -ScriptBlock {
	param($Form)
	$Form.ShowDialog()
} -ArgumentList $Form1




# ウィンドウ表示用のスレッド2
$job2 = Start-ThreadJob -ScriptBlock {
	class Myclass {
		Myclass () {
		}
		[void] Create () {
			$form = New-Object System.Windows.Forms.Form
			$form.ShowDialog();
		}
	}
	
	$myclass = [Myclass]::new()
	$myclass.Create()
}

# 両方のスレッドが終了するまで待機
$job1 | Wait-Job
$job2 | Wait-Job

# 全てのウィンドウを閉じる
$Form1.Dispose()
$Form2.Dispose()
