const admin = require('firebase-admin');
const functions = require("firebase-functions");
const blacklist = require('./blacklist.json');

admin.initializeApp();
const fcm = admin.messaging();

exports.senddevices = functions.firestore
  .document("orders/{id}")
  .onUpdate((change, context) => {
    const data = change.after.data();
    const previousData = change.before.data();

    const topic = 'general';
    const orderStatus = data.orderStatus;
    const deliveryStatus = data.orderDeliveryStatus;
    const previousDeliveryStatus = previousData.orderDeliveryStatus;

    if(orderStatus=='delivery' && deliveryStatus=='upcoming' && previousDeliveryStatus=='pending'){
        const userName = data.userName;
        const message = {
              notification: {
                title: 'New Order!',
                body: 'New Delivery Order from "' + userName + '" has been added.',
              },
              data: {'route': '/home'},
            };

        return fcm.sendToTopic(topic, message);
    }
  });

exports.onUserUpdate = firestore
.document("users/{userID}")
.onUpdate((change, context) => {
  const {before, after} = change;
  const {userID} = context.params;

  const db = admin.firestore();

  if (before.get("username") !== after.get("username")) {
    const batch = db.batch();

    // delete the old username document from the `usernames` collection
    if (before.get("username")) {
    // new users may not have a username value
      batch.delete(db.collection("usernames")
          .doc(before.get("username")));
    }

    // add a new username document
    batch.set(db.collection("usernames")
        .doc(after.get("username")), {userID});

    return batch.commit();
  }
  return true;
});

exports.userCreated = firestore
.document("users/{userId}")
.onCreate((event) => {
  const data = event.data();
  const username = data.username.toLowerCase().trim();

  if (username !== "") {
    const db = admin.firestore();
    /* just create an empty doc. We don't need any data - just the presence
     or absence of the document is all we need */
    return db.doc(`/usernames/${username}`).set({});
  } else {
    return true;
  }
});

/* Whenever a user document is deleted, if it contained a username, delete
 that from the usernames collection. */
exports.userDeleted = firestore
.document("users/{userId}")
.onDelete((event) => {
  const data = event.data();
  const username = data.username.toLowerCase().trim();

  if (username !== "") {
    const db = admin.firestore();
    return db.doc(`/usernames/${username}`).delete();
  }
  return true;
});

/* Check username http query */
export const checkUsernames =
async (data, _) => {
if (!Object.prototype.hasOwnProperty.call(data, "username")) {
  return {message: "No username provided."};
}

const {username} = data;

// Source: https://stackoverflow.com/a/52850529/2758318
const isValidDocId = (id) => id &&
/^(?!\.\.?$)(?!.*__.*__)([^/]{1,1500})$/
    .test(id);

// Document Ids should be non-empty strings
if (!isValidDocId(username)) {
  return {message: "Invalid username string."};
}

try {
  if (blacklist.usernames.includes(username.toLowerCase())) {
    return {result: false, message: "Username is already taken"};
  }

  const _database = await db
      .collection("usernames")
      .doc(username)
      .get();

  /** If doc exists, the username is unavailable */
  return {result: !_database.exists, message: !_database.exists ?
    "Username is available" : "Username is already taken"};
} catch (error) {
  return {message: error};
}
};


exports.checkUsernames = https.onCall(checkUsernames);
