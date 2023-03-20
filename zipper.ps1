<#
# 直接zip圧縮しようとしても、下の階層では除外ファイルが上手く機能しない。
# また、使用中のファイルへのアクセスができない。
# これらの特別な処理を行うよりもコピーしてしまった方が簡単だった。
#>

# 引数必須
param([parameter(Mandatory = $true)] [string] $path)

# 現在年月日時分秒
[String] $now = (Get-Date -Format "yyyyMMddHHmmss")

# 一時ファイル名
[String] $temp = "temp_" + $now + "_" + $path

# 除外ファイル
[Array] $exclude = @( "node_modules", "bkup", "screencap", "*.apk", "*.sqlite", "*.mp4")

# 一時フォルダ作成
Copy-Item $path -Recurse $temp -Exclude $exclude

# 出力ファイル名
[String] $destination = $now + "_" + $path + ".zip"

# 対象となるファイル
[IO.FileSystemInfo] $files = Get-ChildItem -Path $temp -Exclude $exclude

# ファイル(directory)を圧縮
Compress-Archive -Path $files -DestinationPath $destination

# 一時フォルダを削除
Remove-Item $temp -Recurse -Force
