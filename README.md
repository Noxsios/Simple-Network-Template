### How to Use this Templating Program

First, clone this repo with `git clone https://github.com/Noxsios/Simple-Network-Template.git `

1. Create a `template` config file
   
    a. Encapsulate the data you want to replace in double square brackets, [[LIKE SO]], a sample template is provided : [template_sample.txt](https://github.com/Noxsios/Simple-Network-Template/blob/master/sample/template_sample.txt)

2. Create a `variables.csv` file in the same folder as your `template` file.

> It **must** be called `variables.csv`
>
> The *A1* entry **must** be `WORD`, view [variables.csv](https://github.com/Noxsios/Simple-Network-Template/blob/master/sample/variables.csv) for an example

3. Take that same placeholder name, and without the square brackets place it in *Column A* of the csv spreadsheet.
   
    a. Immediately to the right of that, in *Column B*, type what to replace that value with.
    
    b. Use *Columns C+* for different variants of the information from *Column B*.

    b. To reiterate, the value(s) in *Column B+* will replace the value of *Column A* in the final config file(s).

4. **Double Click** to run the `engine.bat` file

> If nothing happens, right click on `dragndrop_template.ps1`, and respond **A** for **[YES TO ALL]** to the execution policy popup.
>
> If the script is blocked due to downloading from a web source, 

1. Drag and Drop your template text file into the empty window, then click **START**.

2. Your new file(s) with name ending in `_config` and your *Column Headers* will be generated in your config template's folder.

3. To make more copies, copy the values in *Column B* into *Columns C+* and rerun.

> The data in **Row 1** of each *Column* (the *Column Header*) is added to the end of the generated config file,
> 
> So make sure you have a name for each column aside from the first, otherwise the script will fail 

8. To overwrite your changes, simply rerun with different values in your `variables.csv`.
