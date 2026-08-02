#!/data/data/com.termux/files/usr/bin/bash

mkdir -p ~/bin

cat > ~/bin/lh <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash
cd ~/EarnTask/LearnEarnHub
node server.js
CMD

cat > ~/bin/lh-test <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash
curl http://localhost:3000/api/status
CMD

cat > ~/bin/lh-deploy <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash
cd ~/EarnTask/LearnEarnHub
vercel --prod
CMD

cat > ~/bin/lh-update <<'CMD'
#!/data/data/com.termux/files/usr/bin/bash
cd ~/EarnTask/LearnEarnHub
git pull
CMD

chmod +x ~/bin/lh ~/bin/lh-test ~/bin/lh-deploy ~/bin/lh-update

if ! grep -q 'HOME/bin' ~/.bashrc; then
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
fi

source ~/.bashrc

echo "LearnEarnHub commands installed:"
echo "lh          - start server"
echo "lh-test     - test API"
echo "lh-deploy   - deploy to Vercel"
echo "lh-update   - update Git code"
