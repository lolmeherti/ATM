# ATM
### About the app

This app was built for fun! The code is free to take and use for anyone who wants it.

### Walkthrough

When the app first opens, the user is greeted with a Login view and a Registration link.

Here is what the registration process looks like:

![](https://i.ibb.co/3RVCKqr/vlc-Ho-Du-Gx-RCAD.gif)

The registration process generated a random card number and a random pin number. Those get saved into our NO-SQL Firebase Database.

### Login

We can use the generated credentials to authenticate ourselves to the app.

![](https://i.ibb.co/mBqQDnH/vlc-7-U6-XAy-Hw-LW.gif)

### Withdraw

When we register, we get a sign-up bonus of $50. Let's see how to withdraw some of our bonus funds.

![](https://i.ibb.co/hBmLmr2/vlc-ZHay-Qo-Cv8-H.gif)

### Deposit
Let's say we have cash in surplus and we want to deposit some of that.

![](https://i.ibb.co/nwRDmXJ/vlc-d6-Wy1-Jx-I26.gif)

### Transfer

Finally, we have the transfer feature. If a valid account number is entered, we can transfer funds to it.

![](https://i.ibb.co/Y8JN71n/vlc-Ya-Ul3dstgl.gif)

### Technical details

The app works with Firebase and does all the normal CRUD operations + joint custom queries are built on firebase.
We also have thorough form input validaiton.
The app is built using SwiftUI and Swift.
No libraries or any other dependencies are used or required to run the app.
