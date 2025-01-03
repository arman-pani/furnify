const functions = require("firebase-functions");
const express = require("express");
const admin = require("firebase-admin");
const paymentRouter = require("./payment_route");

if (!admin.apps.length) {
  admin.initializeApp();
}

const app = express();

app.use(express.json());

app.use("/payments", paymentRouter);

exports.api = functions.https.onRequest(
  { secrets: ["RAZORPAY_KEY_ID", "RAZORPAY_KEY_SECRET"] },
  app,
);
