# Quick Notes for Ubuntu WSL Installation and Config

Update Local Packages and install Brew
```
apt update && apt install build-essentials -y
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Oh-My-Posh
```
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```

Download Simon's Theme
```
wget https://gist.githubusercontent.com/smoonlee/437a1a69a658a704928db5e8bd13a5b5/raw/44c5e75016bef8f4ab2a9fff7d7be810569fc60c/quick-term-smoon.omp.json -O $(brew --prefix oh-my-posh)/themes/quick-term-smoon.omp.json
```
Edit Profile 
```
nano ~/.profile
```

add this to the last line

```
eval "$(oh-my-posh init bash --config $(brew --prefix oh-my-posh)/themes/quick-term-smoon.omp.json)"
```

Close and reload profile