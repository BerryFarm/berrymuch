
Check you have the following programs and free-software libraries installed on your system. 
If you can't ensure usable versions of all necessary libraries be installed, you have to compile Links with user-supplied libraries. Refer to the file INSTALL in such a case.

libpng different from 1.2.20.1 Required to run Links in graphics mode. On package-driven distributions you will need libpng and libpng-dev(el). 
Libpng 1.2.20.1 is buggy and causes Links to crash with "png_do_rgb_to_gray found nongray pixel". PATCH-libpng-1.2.20.1 inside links-*.tar.* allows fixing this and using 1.2.20.1.

IJG libjpeg If you want Links to display JPG pictures. On package-driven distributions you will need libjpeg and libjpeg-dev(el).

TIFF Library If you want Links to display TIFF images. On packaged-driven distributions you will need libtiff and libtiff-dev(el).

SVGAlib if you want to run Links unde SVGAlib. You must be able to compile programs under svgalib. On package-driven distributions, you may need svgalib and svgalib-devel

GPM if you want to use mouse on text console or if you want to display graphics on Linux framebuffer.

zlib if you want Links to accept gzip compression to speed up webpages. On package driven distributions also take zlib-dev(el).

libbzip2 if you want Links to accept bzip2 compression to speed up webpages. On package-driven distributions also take libbzip2-dev(el).

xz if you want Links to be able to decompress LZMA-compressed files.


Download the source archive.
Unpack the source archive: "tar xzvf links-2.20.1.tar.gz" or "tar xjvf links-2.20.1.tar.bz2" Change into the newly-created directory.

Issue "./configure --help" and the run "./configure" with the parameters you want (probably --enable-graphics and maybe some more)

After "configure" ends, check the table if you really get what you want
Type "make". Ignore possible warning about tempnam function, links code is correct.
If you got a root access, log in as root and do "make install" in the same directory.
If you are installing Links as an ordinary user, place the "links" executable file that was created by the "make" command into some suitable place possibly within your $PATH.

If you haven't got a permanent Internet access, copy the whole subdirectory "doc/" into some suitable place (/usr/share/, /usr/local/share/, or in your home...).
Most important is the "doc/links_cal/" subdirectory which contains HTML documents (calibration.html in English and kalibrace.html in Czech) and pictuers that are used for calibration.

If graphics mode is enabled, run "links -g doc/calibration.html" (or "links -g" and point the browser to The Calibration Procedure) and proceed with the calibration of your monitor and Links
Now you can use the browser. Run "links -g" if you want to run in graphics and "links" if you want to run in text mode.
Warning
