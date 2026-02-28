#!/data/data/com.termux/files/usr/bin/bash

echo "=== CLEANING OLD CONFIG ==="
rm -rf .vercel
rm -f vercel.json
rm -f package.json
rm -rf api

echo "=== CREATING PROJECT STRUCTURE ==="
mkdir -p api

cat > api/index.js << 'EOF'
export default function handler(req, res) {
  res.status(200).json({
    status: "online",
    system: "Stable System",
    node: process.version,
    timestamp: new Date()
  });
}
EOF

cat > package.json << 'EOF'
{
  "name": "stable-system",
  "version": "1.0.0",
  "private": true,
  "type": "module",
  "engines": {
    "node": "24.x"
  }
}
EOF

echo "{}" > vercel.json

echo "=== COMMITTING ==="
git add .
git commit -m "one click clean deploy setup"

echo "=== DEPLOYING ==="
vercel --prod

echo "=== DONE ==="
