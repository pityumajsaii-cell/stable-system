import { NextResponse } from "next/server";

export async function GET(request) {
  const { searchParams } = new URL(request.url);
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

