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
