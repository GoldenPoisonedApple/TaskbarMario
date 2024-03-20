Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


$PYPE = "img/pipe.png"
$TASKBAR_HEIGHT = 35

class TypeConverter {
	static [type] GetType([string] $typeName) {
		return $typeName -as [type]
	}
}

class Mario {
	# タスクバーの高さ
	static $TASKBAR_HEIGHT = 35
	# 画像のパスを指定
	static [string[]] $imagePath = @("img/1.png", "img/2.png", "img/3.png", "img/4.png")

	# ウィンドウ
	$form
	# ピクチャーボックス
	$pictureBox
	# 画像
	$images = @()
	# 画面の幅
	$screen_x
	# 画像のインデックス
	$index = 0
	# タイマー
	$timer

	Mario() {
		$this.Create()
	}

	[void] Create () {
		# ウィンドウの作成
		$this.form = New-Object System.Windows.Forms.Form
		# ControlBox プロパティを使って"×"マークを非表示にする
		$this.form.ControlBox = $false
		# タスクバーに表示しないようにする
		$this.form.ShowInTaskbar = $false
		# ウィンドウの境界スタイルを設定
		$this.form.FormBorderStyle = [TypeConverter]::GetType("System.Windows.Forms.FormBorderStyle")::None
		# ウィンドウを透明にする
		$this.form.TransparencyKey = $this.form.BackColor
		# カーソルをデフォルトに設定
		#$this.form.Cursor = [TypeConverter]::GetType("System.Windows.Forms.Cursors")::Cross
  

		# ウィンドウのサイズを設定
		# 136 x 50 が最小サイズ
		$this.form.MinimumSize = New-Object System.Drawing.Size(136, 50)
		$this.form.Size = New-Object System.Drawing.Size(136, 50)
		# クライアント領域のサイズを設定
		# 50 x 50 だと画像がはみ出るので 45 x 45
		$this.form.ClientSize = New-Object System.Drawing.Size(45, 45)

		# 透過処理済みの画像を読み込み
		for ($i = 0; $i -lt $this::imagePath.Count; $i++) {
			$this.images += [TypeConverter]::GetType("System.Drawing.Image")::FromFile($this::imagePath[$i])
		}
		# ピクチャーボックスの作成
		$this.pictureBox = New-Object System.Windows.Forms.PictureBox
		$this.pictureBox.SizeMode = [TypeConverter]::GetType("System.Windows.Forms.PictureBoxSizeMode")::Zoom
		$this.pictureBox.Width = $this.form.ClientSize.Width
		$this.pictureBox.Height = $this.form.ClientSize.Height
		# 画像を表示
		$this.ChangeImage()
		# ピクチャーボックスをフォームに追加
		$this.form.Controls.Add($this.pictureBox)

		# 画面の中央にウィンドウを配置
		$screen = [TypeConverter]::GetType("System.Windows.Forms.Screen")::PrimaryScreen
		$this.screen_x = $screen.Bounds.Width - $this.form.Width
		Write-Host "Screen Width: $($this.screen_x)"
		$screen_y = $screen.Bounds.Height - $this::TASKBAR_HEIGHT
		$this.form.StartPosition = "Manual"
		$this.form.Left = 0
		$this.form.Top = $screen_y - $this.form.Height
	}

	[void] Show() {
		# ウィンドウを表示
		$this.form.Show();
		# ウィンドウを最前面に表示
		$this.form.TopMost = $true
		# マリオを動かす
		while ($true) {
			# 移動
			$this.form.Left += 20
			Write-Host "Left: $($this.form.Left)"
			# 画像の切り替え
			$this.ChangeImage()

			# 画面外に出たら左端に戻る
			if ($this.form.Left -ge $this.screen_x) {
				Write-Host "To the left end."
				# 左端に戻る
				$this.form.Left = 0
			}

			# ウェイト時間
			Start-Sleep -Milliseconds 100
		}
	}

	[void] Test () {
		# タイマーを作成
		$this.timer = New-Object System.Windows.Forms.Timer
		$this.timer.Interval = 1000

		# タイマーのTickイベントハンドラ
		$this.timer.add_Tick({
			Write-Host "Tick"
		})
	}

	[void] ChangeImage() {
		$this.index++
		if ($this.index -ge $this::imagePath.Length) {
			$this.index = 0
		}
		# Write-Host "ChangeImage: $($this.index)"
		$this.pictureBox.Image = $this.images[$this.index]
		$this.form.Refresh()
	}
}

function PutClayPipe () {
	# ウィンドウの作成
	$form = New-Object System.Windows.Forms.Form
	# ControlBox プロパティを使って"×"マークを非表示にする
	$form.ControlBox = $false
	# タスクバーに表示しないようにする
	$form.ShowInTaskbar = $false
	# ウィンドウの境界スタイルを設定
	$form.FormBorderStyle = [TypeConverter]::GetType("System.Windows.Forms.FormBorderStyle")::None
	# ウィンドウを透明にする
	$form.TransparencyKey = $form.BackColor
	# 大きさを設定
	$form.Size = New-Object System.Drawing.Size(120, 80)
	$form.ClientSize = New-Object System.Drawing.Size(120, 80)
	# ピクチャーボックスの作成
	$pictureBox = New-Object System.Windows.Forms.PictureBox
	$pictureBox.SizeMode = [TypeConverter]::GetType("System.Windows.Forms.PictureBoxSizeMode")::Zoom
	$pictureBox.Width = $form.ClientSize.Width
	$pictureBox.Height = $form.ClientSize.Height
	$pictureBox.Image = [TypeConverter]::GetType("System.Drawing.Image")::FromFile($PYPE)
	# クリックイベント作成
	$onClick = {
		Write-Host "Clicked"
	}
	# ウィンドウにクリックイベントをバインド
	$pictureBox.Add_Click($onClick)
	# ピクチャーボックスをフォームに追加
	$form.Controls.Add($pictureBox)
	# 位置を設定して表示
	$form.StartPosition = "Manual"
	$screen = [TypeConverter]::GetType("System.Windows.Forms.Screen")::PrimaryScreen
	$form.Left = $screen.Bounds.Width - $form.Width
	$form.Top = $screen.Bounds.Height - $form.Height - $TASKBAR_HEIGHT
	# ウィンドウを表示
	$form.ShowDialog()
	# ウィンドウを最前面に表示
	$form.TopMost = $true
}

# マリオを表示
$mario = [Mario]::new()
$mario.Test()

# パイプを表示
PutClayPipe