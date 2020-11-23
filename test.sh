echo '#Sets up listenrs (http, https) with self-signed certificate w/ Basic auth.' >> test
echo '$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"' >> test
echo '$file = "$env:temp\ConfigureRemotingForAnsible.ps1"' >> test
echo '' >> test
echo '(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)' >> test
echo '' >> test
echo 'powershell.exe -ExecutionPolicy ByPass -File $file' >> test
echo '' >> test
echo '' >> test
echo '' >> test