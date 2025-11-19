Budge site — quick deployment guide

This file contains quick, copy-paste instructions (PowerShell) to publish your static `Budge.html` as a public website.

1) GitHub Pages (recommended for static site)
-------------------------------------------
Prereqs: Git installed. Optional: GitHub CLI (gh) to create a repo from the command line.

Steps (PowerShell):

# Open PowerShell in the project folder
cd "r:\BTECH\FSD\FSD PROJECT"

# Initialize, add, commit
git init
git add Budge.html
git commit -m "Initial commit - Budge site"

# Create remote and push (manual)
# 1) Create a repo on GitHub via the website (https://github.com/new)
# 2) Then run (replace <username> and <repo>):
git branch -M main
git remote add origin https://github.com/<username>/<repo>.git
git push -u origin main

# Enable GitHub Pages
# Go to the GitHub repo → Settings → Pages and choose Branch: main (root).
# After a minute or two, your site will be available at:
# https://<username>.github.io/<repo>/

If you have GitHub CLI (gh) installed, you can create+push automatically:
# Install GitHub CLI: https://cli.github.com/
gh auth login
gh repo create <repo> --public --source="." --remote=origin --push --confirm

2) Netlify (drag & drop — fastest)
----------------------------------
- Zip the project folder (or just Budge.html) and go to https://app.netlify.com/drop
- Drag and drop the zip or file. Netlify will host it and give you a public URL.

Or use continuous deploy:
- Push to GitHub as above.
- In Netlify: New site from Git → connect GitHub → select the repo → deploy (no build command needed for a single HTML file).

3) Vercel (good for static/JAMstack)
-----------------------------------
- Push repo to GitHub.
- Go to https://vercel.com and 'Import Project' from GitHub.
- For a simple static site, no build command is required.

4) Quick share (temporary) — ngrok
----------------------------------
For quick demos you can expose a local dev server with ngrok:

# start a static server (PowerShell)
cd "r:\BTECH\FSD\FSD PROJECT"
# if you have Python 3 installed
python -m http.server 8080
# or if you have node and http-server installed
npx http-server -p 8080

# then open another PowerShell and run ngrok
# download ngrok from https://ngrok.com/ and sign up
ngrok http 8080

ngrok will give you a public https URL that forwards to your local server. Note: free tunnels are temporary.

Notes & tips
- GitHub Pages gives free HTTPS and is reliable for static HTML sites. Use it for a more permanent site.
- Netlify provides a simple drag-and-drop deploy and supports custom domains.
- Vercel is similar to Netlify, great for sites that may get more features later.

If you'd like, I can run the exact Git/GitHub commands for you now (I can create the repo using the GitHub CLI if you authorize/supply the credentials), or I can prepare a ZIP for Netlify drag-and-drop. Tell me which you prefer and I'll proceed.
