Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Image]::FromFile('d:\dev\tubedeck\docs\icon\td801.png')
$newImg = New-Object System.Drawing.Bitmap 512, 512
$g = [System.Drawing.Graphics]::FromImage($newImg)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.DrawImage($img, 0, 0, 512, 512)
$g.Dispose()
$newImg.Save('d:\dev\tubedeck\docs\icon\td801_512.png', [System.Drawing.Imaging.ImageFormat]::Png)
$newImg.Dispose()
$img.Dispose()
Write-Host 'Done: td801_512.png created'
