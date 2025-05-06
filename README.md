# 👨🏻‍💻 Subdub
This is a powerful Bash script designed to automate the process of subdomain enumeration for bug bounty and penetration testing. It uses multiple tools to gather subdomains, remove duplicates, and check for live subdomains.

---

## 🚀 Features
- Uses tools like `subfinder`, `sublist3r`, `assetfinder`, `shuffledns`, `chaos`, `findomain` And Other Custom made tool
- Automatically installs missing tools
- Collects and merges all subdomains
- Filters only alive subdomains with `httpx-toolkit`

---

## 🛠️ Requirements

** First Clone The Repsitory

=========>>> Dependency Setup for Running the Subdub Tool <<<=========

Step 1: Install Golang v1.22.2

Download and extract:

    1. wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
    2. sudo rm -rf /usr/local/go
    3. sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz

Set environment variables:
    Add the following line to your ~/.bashrc or ~/.zshrc:
    
        1. echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc   (or ~/.zshrc)
        2. source ~/.bashrc   (or source ~/.zshrc)

Verify the installation:
    go version

------------------------------------------------------------

Step 2: Install Required Tools - sublist3r, findomain, massdns and subevigil

subevigil (Custom made Tool by me):

    0. chmod +x subevigil.sh
    1. Go to: https://bevigil.com/login
    2. Create an account
    3. Click your profile (top-right corner) > API Access
    4. Copy your API key (You get 50 credits/month)
    5. nano subevigil.sh
    6. Paste the API key in place of <enter_api_key>
    7. Press Ctrl+O, Enter, then Ctrl+X
    8. sudo cp subevigil.sh /usr/local/bin/subevigil

------------------------------------------------------------

Step 3: Install Sublist3r

    python3 required
    1. git clone https://github.com/aboul3la/Sublist3r.git
    2. cd Sublist3r
    3. pip3 install -r requirements.txt
    4. sudo cp sublist3r.py /usr/local/bin/sublist3r
    5. sudo cp -r subbrute /usr/local/bin/subbrute
    

------------------------------------------------------------

Step 4: Install Findomain

    1. curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux.zip
    2. unzip findomain-linux.zip
    3. chmod +x findomain
    4. sudo mv findomain /usr/bin/findomain
    5. findomain --help

------------------------------------------------------------

Step 5: Install massdns

    1. git clone https://github.com/blechschmidt/massdns.git
    2. cd massdns
    3. make
    4. echo 'export PATH=$PATH:$HOME/massdns/bin' >> ~/.bashrc or ~/.zshrc
    5. source ~/.bashrc or ~/.zshrc

Step 6: ProjectDiscovery Chaos Tool API Key

    1. Visit: https://cloud.projectdiscovery.io/
    2. Create an account
    3. Go to your profile > API Key
    4. Copy the key and paste it when the Subdub tool asks for PDCP_API_KEY

------------------------------------------------------------

Step 7: Copy resolvers.txt to your home directory

    cp resolvers.txt /home/<your-username>

Step 8: Copy subdomains-top1million-110000.txt to yout home directory

    cp subdomains-top1million-110000.txt /home/<your-username>

------------------------------------------------------------

Step 9: Final Setup for Subdub Script

    chmod +x subdub.sh
    sudo cp subdub.sh /usr/local/bin/subdub

=========>>> Setup Complete! <<<=========

------------------------------------------------------------

⚙️ Usage:
     
     subdub example.com

------------------------------------------------------------

📸 Screenshot

    ***********
   

🧑‍💻 Author
      
Name: Jahid Hasan

**GitHub:** [@AntorDOS](https://github.com/AntorDOS)

**LinkedIn:** [jahid-hasan](https://www.linkedin.com/in/jahid-hasan-antor/)

🔑 License
    
This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

🙋‍♂️ Contributing
    
    Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

📬 Contact

    Feel free to reach out via GitHub or LinkedIn if you have any feedback or suggestions.

⭐ Give a Star

    If you like this project, don’t forget to ⭐ the repo!

Credits
Thanks to:

    ProjectDiscovery team

    TomNomNom

    OWASP

    Bug bounty community
