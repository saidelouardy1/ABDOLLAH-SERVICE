const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

// إعداد nodemailer
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'your-email@gmail.com', // بريدك الإلكتروني
    pass: 'your-email-password'  // كلمة المرور لبريدك
  }
});

// Cloud Function لإرسال OTP
exports.sendOtpToEmail = functions.https.onCall(async (data, context) => {
  const email = data.email;
  const otp = data.otp;

  const mailOptions = {
    from: 'your-email@gmail.com',
    to: email,
    subject: 'رمز التحقق (OTP)',
    text: `رمز التحقق الخاص بك هو: ${otp}`
  };

  try {
    await transporter.sendMail(mailOptions);
    return { message: 'تم إرسال OTP بنجاح' };
  } catch (error) {
    console.error('فشل في إرسال OTP:', error);
    throw new functions.https.HttpsError('internal', 'فشل في إرسال البريد الإلكتروني');
  }
});
