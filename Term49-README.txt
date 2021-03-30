#
# To compile Term49 from cli
#

  first, obtain your debug token and signing key by using the method taken from
github.com/mordak/Term48 and re-printed below;

#
# Generating a Debug Token
#

* Use this form to obtain your `bbidtoken.csk` file: https://developer.blackberry.com/codesigning/
* Copy `bbidtoken.csk` to `signing/bbidtoken.csk`
* In `signing/bbpass`, fill in:
  - `CNNAME`: the Common Name for your signing cert (usually your name)
  - `KEYSTOREPASS`: CSK password you entered in step 1 signup
  - `BBPIN`: target device's PIN
  - `BBPASS`: target device's password
* Run `make` in `signing/Makefile` to request and deploy the token to your device.


	then, put your author.p12, bbidtoken.csk and debugtoken.bar in the ~/.rim folder (linux)

	then, setup your BB development environment and go top the project folder and using blackberry-nativepackager you can compile and sign the bar.
	
an example would be

blackberry-nativepackager -sign -storepass <keystorepass> -package Term48_original.bar bar-descriptor.xml


You can type "blackberry-nativepackager -help" to print the help screen

https://developer.blackberry.com/native/documentation/dev/tools/package_and_deploy_app.html

this might help you

oh and you will find many cli tools under bbndk/host_10_3_1_12/linux/x86/usr/bin directory
just after installing momentics, you will have to download the sdk and when you first launch momentics, it will try to download them and it'll fail. So you have to download them by going to "help>update api levels" and selecting sdk 10.3.1
