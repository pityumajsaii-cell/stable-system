#!/bin/bash

echo "=== CLEANING PROJECT ==="
rm -rf api
rm -f package-lock.json
rm -f vercel.json

echo "=== CREATING STRUCTURE ==="
mkdir api

echo "=== CREATING API ==="
cat <<EOF > api/check-access.js
export default async function handler(req, res) {
  const { email } = req.query;

  if (!email) {
    return res.status(400).json({ error: "Email required" });
  }

  try {
    const response = await fetch(
      process.env.EVERYMOMENT_API + "/check-subscription?email=" + email
    );

    if (!response.ok) {
      return res.status(500).json({ error: "Subscription check failed" });
    }

    const data = await response.json();

    if (data.active === true) {
      return res.status(200).json({ access: "granted" });
    }

    return res.status(403).json({ access: "denied" });

  } catch (err) {
    return res.status(500).json({ error: "Server error" });
  }
}
EOF

echo "=== CREATING ROOT API ==="
cat <<EOF > api/index.js
export default function handler(req, res) {
  res.status(200).json({
    status: "online",
    system: "stable-system",
    runtime: process.version
  });
}
EOF

echo "=== CREATING PACKAGE.JSON ==="
cat <<EOF > package.json
{
  "name": "stable-system",
  "private": true,
  "type": "module",
  "engines": {
    "node": "24.x"
  }
}
EOF

echo "=== CREATING VERCEL CONFIG ==="
cat <<EOF > vercel.json
{
  "functions": {
    "api/*.js": {
      "runtime": "nodejs24.x"
    }
  }
}
EOF

echo "=== COMMITTING ==="
git add .
git commit -m "PRO INSTALL - full bridge setup"
git push

echo "=== DEPLOYING ==="
vercel --prod

echo "=== DONE ==="
