$code = @'
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public class IconRotator
{
    public static void Process(string inputPath, string output1, string output2)
    {
        using (var original = Image.FromFile(inputPath))
        {
            // 1024x1024 캔버스 생성 (투명 배경)
            using (var canvas = new Bitmap(1024, 1024))
            using (var g = Graphics.FromImage(canvas))
            {
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = SmoothingMode.HighQuality;
                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                g.CompositingQuality = CompositingQuality.HighQuality;
                g.Clear(Color.Transparent);

                // 이미지를 캔버스 중앙으로 이동
                g.TranslateTransform(512, 512);

                // 10도 시계방향 회전 (기울어진 것을 보정)
                g.RotateTransform(10);

                // 다시 원점으로
                g.TranslateTransform(-512, -512);

                // 여백 80px - 864x864 크기로 배치
                int maxSize = 864;
                float scale = (float)maxSize / Math.Max(original.Width, original.Height);
                int newW = (int)(original.Width * scale);
                int newH = (int)(original.Height * scale);
                int x = (1024 - newW) / 2;
                int y = (1024 - newH) / 2;

                Console.WriteLine("크기: " + newW + "x" + newH + " @ (" + x + "," + y + ")");

                g.DrawImage(original, x, y, newW, newH);

                canvas.Save(output1, ImageFormat.Png);
                canvas.Save(output2, ImageFormat.Png);

                Console.WriteLine("완료!");
            }
        }
    }
}
'@

Add-Type -TypeDefinition $code -ReferencedAssemblies System.Drawing

$input = Join-Path $PSScriptRoot "docs\td4.jpg"
$output1 = Join-Path $PSScriptRoot "assets\icon\app_icon.png"
$output2 = Join-Path $PSScriptRoot "assets\icon\app_icon_foreground.png"

[IconRotator]::Process($input, $output1, $output2)
