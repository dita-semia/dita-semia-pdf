# DITA-SEMIA PDF 
This DITA-OT plugin is yet another transtype for PDF output.


## Features:
- Special treatment for codeph-elements by adding soft-hyphens as suitable places.
- Various outputclasses for the dl-element. Especially the outputclass "tree" might be of interest which can handle nested dlentry-elements to display a hierachical structure and still allign the description for each entry. 
- Using title and version number in footer.
- Highlight new, deleted and changed elements in table of contents etc. 


## Limitations:
- Some text is not taken from a vaiable but directly written in the xsl files (e.g. the title for "table of content" with the Gernam word "Inhaltsverzeichnis").  