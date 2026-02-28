#!/data/data/com.termux/files/usr/bin/bash

echo "Cleaning old Vercel link..."
rm -rf .vercel

echo "Creating project structure..."
mkdir -p api

echo "Creating API file..."
cat > api/index.js << 'EOF'
export default function handler(req, res) {
  res.status(200).json({
    status: "online",
    system: "Stable System",
    timestamp: new Date()
  });
}
EOF

echo "Creating vercel.json..."
cat > vercel.json << 'EOF'
{
  "functions": {
    "api/index.js": {
      "runtime": "@vercel/node@3.0.0"
    }
  }
}
EOF

echo "Creating package.json..."
cat > package.json << 'EOF'
{
  "name": "stable-system",
  "version": "1.0.0",
  "type": "module"
}
EOF

echo "Committing changes..."
git add .
git commit -m "auto setup serverless api"

echo "Deploying to Vercel..."
vercel --prod

echo "DONE."
