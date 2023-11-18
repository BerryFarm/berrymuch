
# Source code

FROM git://git.rockbox.org/rockbox.git


# Binary releases for android


# Rockbox firmware is available as an android app. Might work for bb10 as rockbox is quite an old project

FROM http://rasher.dk/rockbox/android

# The following binary releases (4f03c56-170324) have been tested, installation is fine on Classic, but run fails

ipfs add 4f03c56-170324/*

QmUes6M2qwWawTMZB1okAEUbSgnTBgGwFfN4iM2CpsstnS rockbox-240x320.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480.apk
QmbWPGLQNVpeN7hoeQGT9rk4hWA59ZLqbQGFCr7MzXhRET rockbox-480x272.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800.apk
QmQXLgFAprD1ZDi7o2oyBN1jA61LCibUGFimndJ8z9xcrE rockbox-540x960.apk
QmRsovfvAnbVuNNwzTyChn2Uyf4mucYcsmfuKvQmvdraZc rockbox-600x1024.apk
QmY6CdRGiFHMmVQyBLAbR3NTnzbDsut7SmJajd5YTMe2UZ rockbox-720x1280.apk
QmUWa1RgXi39J4dRVS4Crrkmr8o7ScaKgdDZRSjbtGrHdE rockbox-800x480.apk
QmYBhbXoT6hA6PngGC7KPg1rTYbBr77Y7yUyV6DWKn5o32 rockbox-1024x600.apk


# The following binary releases (67b4b2a-120313) have been tested, installation is fine on Classic, splash screen appears and stay, but nothing *** seems to work ***

ipfs add 67b4b2a-120313/*

QmXUEqvk9zkhZ2z6ADQDhdEYdiJvVMzebXNHBWvzsPdok7 rockbox-1024x600.apk
QmfKeJfeF4fhGkCjc5sH1QpTnxsMV4eLb6wFSiwZZZLhZX rockbox-240x320.apk
QmZSqExWW8n1V1Kbtpft3U8X8PieDubv7tj8WUekVZ1qLN rockbox-320x480.apk
QmZzpuYwgr7ENFQUPdftwmhzn4QTLUd8j6F3wuSzZ1iDkf rockbox-480x800.apk
QmYhLzJcmvuX7ZMFriKV1UjSpCSpktSUqgeNc8Xd2jCQqz rockbox-540x960.apk
QmZyXLSDFCWiYMXAoexvvbBT2XosbzA1TZuCWXkaiUbKdb rockbox-600x1024.apk
QmPhEahpXryTqQgKmNsGYPDnd7Jjv9Sv5PDYm6s1gB5oqi rockbox-720x1280.apk
QmcSMRWvfpkvHAgA9fGN5ucYT1bn2p6RyQra8JqS3SyRmq rockbox-800x480.apk


# The screen of Classic is 720x720, so testing in priority smaller or equal size apps

ipfs add 320x480/*


# This one almost works, on 1/4 of the screen, menus working, music play not tested
QmSP1uD77MoUFzRNvrs23skneixBPrqJqWQ9o3tyDakb2C rockbox-320x480-2011-06-23.apk

QmZSqExWW8n1V1Kbtpft3U8X8PieDubv7tj8WUekVZ1qLN rockbox-320x480-2011-10-17.apk
QmU6SSDTvgJgngRaUZW31EBG6bpjv98x9WntxYHRNYE4an rockbox-320x480-2011-10-23.apk

# Install ok, run KO
QmP9PzQo1fvCkR8RHxf5zZjjwR7vNMMft7AMF9Ud5oG6Q9 rockbox-320x480-2015-03-01.apk

QmQKiwPX2T9WjXP98pynaXguriEikAhvEuxBR88nYVFP26 rockbox-320x480-2015-09-08.apk
QmT26EVLcnbkuh8Vi18DMCeDYfA79L9jwDSpuvp1zf8818 rockbox-320x480-2016-05-04.apk
QmR13ExCDpx5oHNJmt9M6y27B1Hh9NCR5hgPWE77oPGmQm rockbox-320x480-2016-08-11.apk

# Install KO
QmUay2wM3o5HhQf5JrvwpieeyRCdY48r23HcQ5LiVDNXMu rockbox-320x480-2016-12-08.apk

QmNa5bMgnX7PqfGkwAPqmwPimCSAJYorLwW7to8JB4owZL rockbox-320x480-2017-02-25.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480-2017-09-23.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480-2017-11-24.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480-2018-03-14.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480-2018-08-27.apk
QmYAeWh1Mh9HqXEvm84b2Pf2TSLcrA7Jys1QcupaCu2KwS rockbox-320x480-2021-01-31.apk



# Let's try bigger

ipfs add 480x800/*

# Install ok. When run, does not go beyond splash screen
QmZzpuYwgr7ENFQUPdftwmhzn4QTLUd8j6F3wuSzZ1iDkf rockbox-480x800-2011-10-17.apk

# Works !!! ( but right part of the screen is black due to size mismatch )
QmeSub13Tht8vwde9aHUqNdPAQ6RXUpdxSCZMLKSzjcBR4 rockbox-480x800-2013-06-23.apk

Qmc2EDhZW6noM7z8ioHMLqWG1nr7NTAj7mnSDyNHkRDnjx rockbox-480x800-2013-10-23.apk
QmXwq7eVp2YfJjsFbCWhnH6nMXqnZhfbfaJsipnGW292qY rockbox-480x800-2015-03-01.apk
Qma5BWqe6bvXkSJnaW6MEWhnTyN8FuvAdLDSXsKvuBdwXD rockbox-480x800-2015-09-08.apk
QmaEoUXmFKkDiBSfwwHgsxvFJepjgWb5Qv5YUUskG64XRi rockbox-480x800-2016-05-04.apk
QmcX2WeaFiouPX83fZ5ibpUkhQohr1P6rTm61KxRWhrG3r rockbox-480x800-2016-08-11.apk
QmS4myxZjQyBFTF2MhZLKRi3L2iu8jdoUZqtL9BYydW9be rockbox-480x800-2016-12-08.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2017-04-26.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2017-09-23.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2017-10-21.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2017-11-24.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2018-03-14.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2018-08-27.apk
QmNghbhVcP2SZbq6KsC2cgLzXpnjs7SskLYbTizYRrRj2d rockbox-480x800-2021-01-31.apk



# More to explore test and report

https://web.archive.org/web/20230000000000*/http://rasher.dk/rockbox/android/rockbox-1024x600.apk

https://web.archive.org/web/20230000000000*/http://rasher.dk/rockbox/android/rockbox-600x1024.apk

https://web.archive.org/web/20230000000000*/http://rasher.dk/rockbox/android/rockbox-540x960.apk

https://web.archive.org/web/20230000000000*/http://rasher.dk/rockbox/android/rockbox-720x1280.apk

https://web.archive.org/web/20230000000000*/http://rasher.dk/rockbox/android/rockbox-800x480.apk
