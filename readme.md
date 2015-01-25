# tfinvoice
_tfinvoice_ is a LaTeX class for simple invoices with built-in calculation.

## Uh, German?
Since I am German and all of my clients so far have been German, too, the class is configured German (e.g., DIN format, babel settings, texts).
Of course, it shouldn't be hard to adapt it to meet your individual requirements.

## Customization
Almost everything you have to change in order to provide your personal data can be found in the `options.lco` file.
Anything client-specific is defined in the `invoice.tex` file then.

## ! LaTeX Error: File 'logo' not found.
The class is set up to use a logo in the header of the first page.
In order to fit into the available space, which is 155.34mm in width and 30mm in height, the image will be scaled, while keeping its aspect ratio.

Depending on whether you use _latex_ or _pdflatex_, a valid logo file would be one of the following:

* `logo.eps` (_latex_)
* `logo.jpg` (_pdflatex_)
* `logo.pdf` (_pdflatex_)
* `logo.png` (_pdflatex_)

If you don't want to use a logo, either comment out or completely remove the line `\logo{logo}`, which you can find in the `options.lco` file.
