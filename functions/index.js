const functions = require("firebase-functions");
// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.deleteUserById = functions.https.onRequest(async (request, response) => {

    const userId = request.body.userId;

  await admin.auth().deleteUser(userId);
  response.send("Hello from Firebase!");
});
