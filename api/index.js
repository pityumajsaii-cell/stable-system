export default function handler(req, res) {
  res.status(200).json({
    status: "online",
    system: "Stable System",
    timestamp: new Date()
  });
}
