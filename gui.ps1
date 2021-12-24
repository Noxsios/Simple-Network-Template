. $PSCommandPath.Replace('gui', 'cli')

function main {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

    # initial form creation
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Template Drag n Drop"
    $form.Size = New-Object System.Drawing.Size(475, 195)
    $form.StartPosition = "CenterScreen"
    $form.MinimizeBox = $False
    $form.MaximizeBox = $False
    $form.Topmost = $True
    $form.FormBorderStyle = 'Fixed3D'
    $form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#100d1d")
    $form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#cc3700")
    $iconBase64 = 'iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAABA0lEQVR4Ae3YAQTCUBRG4fAQIEAIAUIIAUJAgBAAQgAYYAhDCBAAQoAQAgQIEABCCCEECCGEdfCCR65yt1vs54Or7JBBJcU1scQOQ5hvg9R7oIbXGujBIbelgdjfx0i9Q1ZRDhUhKPH3S3DvQ3V9nHHHXAh6c9fdPnhA2zpIfrBwF95KgyD5rTQJCu/xrwUlRVARVAT9S9AWicJdLUhHEfRFkMMMV2zQsgxyWAUfeGCOqkVQD+kbV8Qo5/2TRcIXjhjkGSRHweItiyyDLKOEIPuoBOIi8yAhyj7Ib5pD0AgfbZZxUAd+9lEnODCjKO1/RCZKITeMoLIu1rh/EbLHAvVSsCd0ANBznaxxuQAAAABJRU5ErkJggg=='
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
    $stream.Write($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

    # start button
    $button = New-Object System.Windows.Forms.Button
    $button.Left = 320
    $button.Top = 30
    $button.Size = New-Object System.Drawing.Size(95, 95)
    $button.Width = 120
    $button.Text = "START"
    $button.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#111622")

    # instructions label
    $label = New-Object Windows.Forms.Label
    $label.Left = 10
    $label.Top = 5
    $label.AutoSize = $True
    $label.Text = "Drop network template files here, config files will output in same directory."

    # files listbox
    $listBox = New-Object Windows.Forms.ListBox
    $listBox.Left = 15
    $listBox.Top = 30
    $listBox.Height = 100
    $listBox.HorizontalScrollbar = $True
    $listBox.Width = 300
    $listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)
    $listBox.IntegralHeight = $False
    $listBox.AllowDrop = $True
    $listBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#111622")
    $listBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DCDCDC")

    # progress bar
    $statusBar = New-Object System.Windows.Forms.StatusBar
    $statusBar.Text = "Ready"

    # add controls to form
    $form.SuspendLayout()
    $form.Controls.Add($button)
    $form.Controls.Add($label)
    $form.Controls.Add($listBox)
    $form.Controls.Add($statusBar)
    $form.ResumeLayout()

    # "START" button click event
    $button_Click = {
        foreach ($item in $listBox.Items) {
            Invoke-SNT -TemplateFile $item
            $form_FormClosed
            $form.Close()
        }
    }

    # list box dragover event
    $listBox_DragOver = [System.Windows.Forms.DragEventHandler] {
        if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
            $_.Effect = 'Copy'
        }
        else {
            $_.Effect = 'None'
        }
    }

    # list box drop event
    $listBox_DragDrop = [System.Windows.Forms.DragEventHandler] {
        foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) {
            $listBox.Items.Add($filename)
        }
    }

    # form close event, performs cleanup
    $form_FormClosed = {
        try {
            $listBox.remove_Click($button_Click)
            $listBox.remove_DragOver($listBox_DragOver)
            $listBox.remove_DragDrop($listBox_DragDrop)
            $listBox.remove_DragDrop($listBox_DragDrop)
            $form.remove_FormClosed($Form_Cleanup_FormClosed)
        }
        catch [Exception] { 
            "Exception thrown closing form." 
        }
    }

    # wire event listeners to controls
    $button.Add_Click($button_Click)
    $listBox.Add_DragOver($listBox_DragOver)
    $listBox.Add_DragDrop($listBox_DragDrop)
    $form.Add_FormClosed($form_FormClosed)

    # show form
    [void] $form.ShowDialog()
}

# call main function
main