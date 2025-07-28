import { Razorpay } from "razorpay";
import { express } from "express";
import { razorPayApiKey,razorPayApiSecret } from "./private.js";

const app = express();
const port = 3000;

app.post("/order", (req, res) => {
  var instance = new Razorpay({
    key_id: razorPayApiKey,
    key_secret: razorPayApiSecret,
  });

  instance.orders.create({
    amount: 50000,
    currency: "INR",
    receipt: "receipt#1",
    partial_payment: false,
    notes: {
      key1: "Test 1",
    },
  });
});
