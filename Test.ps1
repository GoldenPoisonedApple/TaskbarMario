Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


class TypeConverter {
	static [type] GetType([string] $typeName) {
		return $typeName -as [type]
	}
}

class Mario {
	# タスクバーの高さ
	static $TASKBAR_HEIGHT = 35
	# 画像のパスを指定
	static $imagePath = "img/1.png"
	# ウィンドウ
	$form

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

		# ウィンドウのサイズを設定
		# 136 x 50 が最小サイズ
		$this.form.MinimumSize = New-Object System.Drawing.Size(136, 50)
		$this.form.Size = New-Object System.Drawing.Size(136, 50)
		# クライアント領域のサイズを設定
		# 50 x 50 だと画像がはみ出るので 45 x 45
		$this.form.ClientSize = New-Object System.Drawing.Size(45, 45)

		# 画像の読み込み
		$image = [TypeConverter]::GetType("System.Drawing.Image")::FromFile($this::imagePath)
		# ピクチャーボックスの作成
		$pictureBox = New-Object System.Windows.Forms.PictureBox
		$pictureBox.SizeMode = [TypeConverter]::GetType("System.Windows.Forms.PictureBoxSizeMode")::Zoom
		$pictureBox.Image = $image
		$pictureBox.Width = $this.form.ClientSize.Width
		$pictureBox.Height = $this.form.ClientSize.Height
		# ピクチャーボックスをフォームに追加
		$this.form.Controls.Add($pictureBox)

		# 画面の中央にウィンドウを配置
		$screen = [TypeConverter]::GetType("System.Windows.Forms.Screen")::PrimaryScreen
		$screen_x = $screen.Bounds.Width
		$screen_y = $screen.Bounds.Height - $this::TASKBAR_HEIGHT
		$form_width = $this.form.Width
		$form_height = $this.form.Height
		$this.form.StartPosition = "Manual"
		$this.form.Left = $screen_x - $form_width
		$this.form.Top = $screen_y - $form_height
	}

	[void] Show() {
		# ウィンドウを表示
		$this.form.ShowDialog()
	}
}

# マリオを表示
$mario = [Mario]::new()
$mario.Show()
