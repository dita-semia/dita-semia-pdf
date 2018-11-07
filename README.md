# DITA-SEMIA PDF 
This DITA-OT plugin is yet another transtype for PDF output.


## Maintainance/Compatibility

I'm using for our commercial publications. Thus, it is continiously maintained when . However, I'm not using github as main versioning system and will only occasionally this repository since I'm not aware of anybody else actually using it. So if you're interested in more frequent updates just let me know.

Also note that I'm not doing any testing with different DITA-OT version. Currently I'm using DITA-OT 2.4 so this is the only version I'm sure it is compatible with. But I expect little to no modification sbeing required to make it work at least with newer versions.


## Features:
- Special treatment for codeph-elements by adding soft-hyphens as suitable places.
- Various outputclasses for the dl-element. Especially the outputclass "tree" might be of interest which can handle nested dlentry-elements to display a hierachical structure and still allign the description for each entry. 
- Using title and version number in footer.
- Highlight new, deleted and changed elements in table of contents etc. 


## Limitations:
- Some text is not taken from a vaiable but directly written in the xsl files (e.g. the title for "table of content" with the Gernam word "Inhaltsverzeichnis").  
