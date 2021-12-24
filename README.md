# Simple Network Templating

> sample `variables.csv` and `template.txt` located in [sample](./sample)

1. Suggested folder structure:

    ```text
    $HOME/simple-network-templates/
    └── project-name/
        ├── configs/
        ├── template.txt
        └── variables.csv
    ```

2. Create a `template.txt` config file, (file extension does not matter, as long as it is a plaintext file)
   
    a. Encapsulate the data you want to replace in double curly braces, __{{LIKE SO}}__

    ```txt
    ! example template

    config t

    hostname {{HOSTNAME}}
    int vlan 1
    ip add {{VLAN1IP}} {{VLAN1MASK}}
    ```

3. Create a `variables.csv` file in the same folder as your `template` file.

> It **must** be called `variables.csv`
>
> The *A1* entry **must** be `VARIABLES`

ex. variables.csv

| VARIABLES | DEVICE1       | DEVICE2       |
| --------- | ------------- | ------------- |
| HOSTNAME  | router1       | router2       |
| VLAN1IP   | 192.168.0.1   | 192.168.1.1   |
| VLAN1MASK | 255.255.255.0 | 255.255.255.0 |

1. Clone this repo, and run the gui

    ```powershell
    git clone https://github.com/Noxsios/Simple-Network-Template.git

    cd Simple-Network-Template

    & .\gui.ps1
    ```

2. Drag and drop your template text file into the empty window, then click __START__.

3. Your template will be applied to the devices listed in the variables file.  The files ending in `_config` located in the `configs` folder are the generated config files. 

4. To overwrite your changes, simply rerun with different values in your `variables.csv`.

---

## Credits

Drag n Drop GUI derived from : [this](https://github.com/rlv-dan/Tutorial-code/blob/master/A%20drag-and-drop%20GUI%20made%20with%20PowerShell/powershell-gui.ps1)

## Testing

```powershell
Invoke-Pester -Output Detailed .\cli.Tests.ps1
```