const express = require("express");
const crypto = require("crypto");
const admin = require("firebase-admin");
const axios = require("axios");

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();
const paymentRouter = express.Router();

const createOrder = async (amount, currency, notes) => {
  const keyId = process.env.RAZORPAY_KEY_ID;
  const keySecret = process.env.RAZORPAY_KEY_SECRET;
  const auth = Buffer.from(`${keyId}:${keySecret}`).toString("base64");
  const url = "https://api.razorpay.com/v1/orders";

  try {
    const response = await axios.post(
      url,
      {
        amount: amount,
        currency: currency,
        notes: notes || {},
      },
      {
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Basic ${auth}`,
        },
      },
    );
    console.log("Order created successfully:", response.data);
    return response.data;
  } catch (error) {
    console.error(
      "Error creating order:",
      (error.response && error.response.data) || error.message,
    );
    throw new Error("Failed to create order");
  }
};

paymentRouter.post("/create-order", async (req, res) => {
  try {
    const { amount, currency, notes } = req.body;

    if (!amount || !currency ) {
      return res.status(400).json({
        error: "Invalid input. Amount and currency are required.",
      });
    }

    const response = await createOrder(amount, currency, notes);

    res.status(200).json({
      success: true,
      orderId: response.id,
    });
  } catch (error) {
    console.error("Error creating order:", error.message);
    res.status(500).json({
      success: false,
      error: error.message || "Internal Server Error",
    });
  }
});

paymentRouter.post("/payment-success", async (req, res) => {
  try {
    const keySecret = process.env.RAZORPAY_KEY_SECRET;

    const { razorpay_payment_id, razorpay_order_id, razorpay_signature } =
      req.body;

    if (!razorpay_payment_id || !razorpay_order_id || !razorpay_signature) {
      return res.status(400).json({ error: "Missing payment details" });
    }

    const generated_signature = crypto
      .createHmac("sha256", keySecret)
      .update(`${razorpay_order_id}|${razorpay_payment_id}`)
      .digest("hex");

    if (generated_signature !== razorpay_signature) {
      return res.status(400).json({ error: "Signature verification failed" });
    }

    const paymentDetails = {
      razorpay_order_id,
      razorpay_payment_id,
      razorpay_signature,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    };

    await db.collection("receipts").add(paymentDetails);

    res.status(200).json({
      success: true,
      message: "Payment verified and stored successfully",
    });
  } catch (error) {
    console.error("Error verifying payment:", error.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = paymentRouter;
