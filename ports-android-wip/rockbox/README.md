
# Rockbox firmware is available as an android app. Might work for bb10 as rockbox is quite an old project

FROM http://rasher.dk/rockbox/android

# The following binary releases (4f03c56-170324) have been tested, installation is fine on Classic, but run fails

QmUes6M2qwWawTMZB1okAEUbSgnTBgGwFfN4iM2CpsstnS rockbox-240x320.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480.apk
QmbWPGLQNVpeN7hoeQGT9rk4hWA59ZLqbQGFCr7MzXhRET rockbox-480x272.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800.apk
QmQXLgFAprD1ZDi7o2oyBN1jA61LCibUGFimndJ8z9xcrE rockbox-540x960.apk
QmRsovfvAnbVuNNwzTyChn2Uyf4mucYcsmfuKvQmvdraZc rockbox-600x1024.apk
QmY6CdRGiFHMmVQyBLAbR3NTnzbDsut7SmJajd5YTMe2UZ rockbox-720x1280.apk
QmUWa1RgXi39J4dRVS4Crrkmr8o7ScaKgdDZRSjbtGrHdE rockbox-800x480.apk
QmYBhbXoT6hA6PngGC7KPg1rTYbBr77Y7yUyV6DWKn5o32 rockbox-1024x600.apk


FROM git://git.rockbox.org/rockbox.git
