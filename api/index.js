export default function handler(req, res) {
  res.status(200).json({
    status: "online",
    system: "Stable System",
    node: process.version,
    timestamp: new Date()
  });
}
