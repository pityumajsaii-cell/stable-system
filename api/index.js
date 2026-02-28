export default function handler(req, res) {
  res.status(200).json({
    status: "online",
    message: "Stable System backend is running",
    timestamp: new Date()
  });
}
