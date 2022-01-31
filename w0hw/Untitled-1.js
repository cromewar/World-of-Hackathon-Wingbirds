/** Connect to Moralis server */
const serverUrl = "https://7jqtpuxa3nih.usemoralis.com:2053/server";
const appId = "rL4NxKtkOFg4QBAwcZktAk5uWKmXTNtli8UMocBv";
Moralis.start({ serverUrl, appId });

/** Add from here down */
async function login() {
  let user = Moralis.User.current();
  console.log("logging in");
  if (!user) {
    try {
      user = await Moralis.authenticate({ signingMessage: "Hello World!" });
      console.log(user);
      console.log(user.get("ethAddress"));
    } catch (error) {
      console.log(error);
    }
  }
}

async function logOut() {
  await Moralis.User.logOut();
  console.log("logged out");
}

const ABI = [
  {
    inputs: [
      {
        internalType: "string",
        name: "_nickname",
        type: "string",
      },
      {
        internalType: "string",
        name: "_imgURL",
        type: "string",
      },
    ],
    name: "createNewUser",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

console.log("running script for rinkeby");
const contractAddress = "0xf63Fc77D9884862AB90d5b9A1B6495Eb0e053BAa";

const sendOptions = {
  contractAddress: contractAddress,
  functionName: "createNewUser",
  abi: ABI,
  params: {
    _nickname: "Tippi",
    _imgURL:
      "https://ipfs.io/ipfs/QmUdAvkZwZM8qoqmDdQV3EYmmHZt9zu9bpNwXHJg9QkTMx",
  },
};

const enableWeb = async () => {
  await Moralis.enableWeb3();
  console.log("Moralis web3 enabled");
};

const sendTransaction = async () => {
  const transaction = await Moralis.executeFunction(sendOptions);
  console.log(transaction.hash);

  await transaction.wait();
};

const Run = async () => {
  await login();
  console.log("await login()");
  await enableWeb();
  console.log("await enableWeb()");
  await sendTransaction();
  console.log("await sendTransaction()");

  var a = await prompt("Enter some text", contractAddress);
};

Run();

/** Useful Resources  */

// https://docs.moralis.io/moralis-server/users/crypto-login
// https://docs.moralis.io/moralis-server/getting-started/quick-start#user
// https://docs.moralis.io/moralis-server/users/crypto-login#metamask

/** Moralis Forum */

// https://forum.moralis.io/
