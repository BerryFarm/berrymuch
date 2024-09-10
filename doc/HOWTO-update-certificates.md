### FAQ: How to Upgrade BlackBerry 10 (BB10) Certificates

**Question:** How do I upgrade certificates on my BlackBerry 10 device to resolve website access issues?

**Answer:**

If you're encountering problems accessing websites on your BlackBerry 10 device due to expired certificates, follow these steps to update your certificates:

1. **Download the Latest Certificates:**
   - Go to [https://curl.se/ca/cacert.pem](https://curl.se/ca/cacert.pem) and download the latest `cacert.pem` file.
   - Alternatively, you can find more information and download the certificates from [https://curl.se/docs/caextract.html](https://curl.se/docs/caextract.html).

2. **Import the Certificates:**
   - On your BlackBerry 10 device, go to **Settings** > **Security and Privacy** > **Certificates**.
   - Scroll down to the **DST Root CA X3** certificate.
   - Uncheck the **trusted** box to disable the expired root certificate.

3. **Complete the Setup:**
   - Follow any additional on-screen prompts to complete the installation.

After completing these steps, your device should be able to access websites without certificate-related issues.

**Note:** Make sure to keep your certificates up to date by periodically checking for new versions.

