#!/bin/bash

echo "=== STABLE SYSTEM FULL INSTALL ==="

# 1️⃣ Check web folder
if [ ! -d "web" ]; then
  echo "❌ web folder not found. Abort."
  exit 1
fi

if [ ! -d "web/app" ]; then
  echo "❌ Not an App Router Next.js project. Abort."
  exit 1
fi

# 2️⃣ Create API route
echo "Creating API route..."

mkdir -p web/app/api/check-access

cat <<EOF > web/app/api/check-access/route.ts
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const email = searchParams.get("email");

  if (!email) {
    return NextResponse.json({ error: "Email required" }, { status: 400 });
  }

  return NextResponse.json({
    email,
    active: false,
    system: "stable-system",
    status: "operational"
  });
}
EOF

# 3️⃣ Commit
echo "Committing..."
git add .
git commit -m "FULL INSTALL - api route added" || echo "Nothing to commit"

# 4️⃣ Push
echo "Pushing..."
git push

# 5️⃣ Deploy
echo "Deploying to production..."
vercel --prod

echo "=== DONE ==="
