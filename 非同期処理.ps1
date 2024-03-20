Add-Type -AssemblyName System.Windows.Forms

# フォームを作成
$form = New-Object Windows.Forms.Form
$form.Text = "Incremental Counter"
$form.Size = New-Object System.Drawing.Size(200, 100)

# ラベルを作成
$label = New-Object Windows.Forms.Label
$label.Text = "0"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(50, 20)
$form.Controls.Add($label)

# カウンターの初期化
$counter = 20

# タイマーを作成
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 10

# イベントハンドラを定義
$eventHandler = {
	# カウンターをインクリメントしてラベルのテキストを更新
	$counter++
	$label.Text = $counter.ToString()
}

# イベントハンドラを追加
$timer.add_Tick($eventHandler)


#$timer.add_Tick({
    # カウンターをインクリメントしてラベルのテキストを更新
#    $counter++
#    $label.Text = $counter.ToString()
#})

# タイマーを開始
$timer.Start()

# フォームを表示
$form.ShowDialog() | Out-Null
