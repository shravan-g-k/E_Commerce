import Razorpay from "razorpay";
import express from "express";
import crypto from "crypto";

import { razorPayApiKey, razorPayApiSecret } from "./private.js";

const app = express();
const port = 8000;

app.use(express.json());

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.post("/order", async (req, res) => {
  const { amount, currency, receipt } = req.body;

  console.log(amount, currency, receipt);

  var instance = new Razorpay({
    key_id: razorPayApiKey,
    key_secret: razorPayApiSecret,
  });

  const order = await instance.orders.create({
    amount: parseInt(amount, 10) * 100,
    currency: "INR",
    receipt: receipt,
    partial_payment: false,
    notes: {
      key1: "Test",
    },
  });
  console.log(JSON.stringify(order));
  res.json(order);
});

app.post("/verify-payment", (req, res) => {
  const { razorpay_order_id, razorpay_payment_id, razorpay_signature } =
    req.body;
  const key_secret = razorPayApiSecret;
  if (!razorpay_order_id || !razorpay_payment_id || !razorpay_signature) {
    return res.status(400).json({ error: "Missing required parameters" });
  }

  const hmac = crypto.createHmac("sha256", key_secret);

  hmac.update(razorpay_order_id + "|" + razorpay_payment_id);
  let generatedSignature = hmac.digest("hex");

  let isSignatureValid = generatedSignature == razorpay_signature;

  if (isSignatureValid) {
    // Payment is authentic
    res
      .status(200)
      .json({ success: true, message: "Payment verified successfully" });
  } else {
    // Payment is not authentic
    res
      .status(400)
      .json({ success: false, message: "Payment verification failed" });
  }
});
