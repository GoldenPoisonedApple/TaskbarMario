Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 画像のパス
$imagePaths = @("img/1.png", "img/2.png", "img/3.png", "img/4.png")
$pipeImagePath = "img/pipe.png"
$taskbarHeight = 35

class TypeConverter {
	static [type] GetType([string] $typeName) {
		return $typeName -as [type]
	}
}

# マリオのクラス
class Mario {
		# 画像のパス
		[string[]]$imagePaths = @("img/1.png", "img/2.png", "img/3.png", "img/4.png")

		# ウィンドウ
		$form
		# ピクチャーボックス
		$pictureBox
		# 画像
		$images = @()
		# 画面の幅
		[int]$screenWidth
		# インデックス
		[int]$index = 0
		# タイマー
		$timer

		Mario([string[]]$imagePaths) {
				#$this.imagePaths = $imagePaths
				$this.Create()
		}

		[void] Create() {
				$this.form = New-Object System.Windows.Forms.Form
				$this.form.FormBorderStyle =  [TypeConverter]::GetType("System.Windows.Forms.FormBorderStyle")::None
				$this.form.TransparencyKey = $this.form.BackColor
				$this.form.StartPosition = "Manual"
				$this.form.TopMost = $true

				# 画像を読み込む
				foreach ($path in $this.imagePaths) {
						$this.images += [TypeConverter]::GetType("System.Drawing.Image")::FromFile($path)
				}

				# ピクチャーボックスの作成
				$this.pictureBox = New-Object System.Windows.Forms.PictureBox
				$this.pictureBox.SizeMode = [TypeConverter]::GetType("System.Windows.Forms.PictureBoxSizeMode")::Zoom
				$this.pictureBox.Width = 45
				$this.pictureBox.Height = 45
				$this.pictureBox.Image = $this.images[0]

				# フォームにピクチャーボックスを追加
				$this.form.Controls.Add($this.pictureBox)

				# 画面の幅を取得
				$this.screenWidth = [TypeConverter]::GetType("System.Windows.Forms.Screen")::PrimaryScreen.Bounds.Width
		}

		[void] Start () {
			# タイマーを作成
			$this.timer = New-Object System.Windows.Forms.Timer
			$this.timer.Interval = 100
			# イベントハンドラを定義
			$eventHandler = {
				param($form)
				# マリオを移動
				$using:form.Left += 20
				#$this.form = $tmp
				# 画像の切り替え
				#$this.index = ($this.index + 1) % $this.imagePaths.Count
				#this.pictureBox.Image = $this.images[$this.index]

				# 画面外に出たら左端に戻る
				#if ($this.form.Left -ge $this.screenWidth) {
				#		$this.form.Left = 0
				#}
			}
			$this.timer.Add_Tick({$eventHandler}) 

			# タイマーを開始
			$this.timer.Start()

			# ウィンドウを表示
			$this.form.Show()
		}
}

# マリオのインスタンスを作成
$mario = [Mario]::new($imagePaths)
$mario.Start()

Write-Host "Mario Created"

# パイプのウィンドウを作成
$formPipe = New-Object System.Windows.Forms.Form
$formPipe.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$formPipe.TransparencyKey = $formPipe.BackColor
$formPipe.StartPosition = "Manual"
$formPipe.Size = New-Object System.Drawing.Size(120, 80)
$formPipe.Location = New-Object System.Drawing.Point((([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width) - $formPipe.Width), (([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height) - $formPipe.Height - $taskbarHeight))
$pictureBoxPipe = New-Object System.Windows.Forms.PictureBox
$pictureBoxPipe.Size = New-Object System.Drawing.Size(120, 80)
$pictureBoxPipe.Image = [System.Drawing.Image]::FromFile($pipeImagePath)
$formPipe.Controls.Add($pictureBoxPipe)

# パイプのクリックイベント
$pictureBoxPipe.Add_Click({
		Write-Host "Pipe Clicked"
})

# パイプのウィンドウを表示
$formPipe.ShowDialog()
