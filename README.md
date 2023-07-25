# Recon Script
Domain Scanner is a simple Bash script that performs a basic reconnaissance scan of a given domain using nmap, dirsearch, and crt.sh. It generates reports of open ports, identified services, directory listings, and SSL/TLS certificates. The output of each scan is saved to a separate file in a directory named after the specified domain.

## Dependencies

- [nmap](https://nmap.org/)
- [dirsearch](https://github.com/maurosoria/dirsearch)
- [crt.sh](https://crt.sh/)
- [jq](https://stedolan.github.io/jq/)
- [curl](https://curl.se/)

## Usage
- Before anything, make sure that you gave permission `chmod +x recon.bash`

# ./recon.sh <domain> [scan-type]
- `<domain>`: The domain to scan.
- `[scan-type]` (optional): The type of scan to perform. Available options are: `nmap-only`, `dirsearch-only`, `crt-only`, or leave blank to perform all scans.

## Examples

Scan the domain `example.com` with nmap and dirsearch:
./recon.sh example.com

Perform only a crt.sh scan on the domain `example.com`:
./recon.sh example.com crt-only

## Output

The output of each scan is saved to a separate file in a directory named after the specified domain. The output files include:

- nmap scan results saved to a file named "nmap"
- dirsearch scan results saved to a file named "dirsearch.txt"
- crt.sh scan results saved to a file named "crt"

Each of these files is saved to a directory with a name based on the specified domain. For example, if the domain "example.com" is scanned, the output files will be saved to a directory named "example.com_recon".

The script also includes echo statements that print out the URLs where the scan results are stored. These URLs include the directory name and the name of the output file, so users can easily access the scan results.

## Contact

If you have any issues or questions about this script, please contact me at AnasNasseer@hotmail.com.
