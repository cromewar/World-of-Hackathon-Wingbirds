const ABI = [
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_nickname",
                "type": "string"
            },
            {
                "internalType": "string",
                "name": "_imgURL",
                "type": "string"
            }
        ],
        "name": "createNewUser",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
];

const contractAddress = "0x9a2818BaC47119F97Bb01e165945896327002129"

const sendOptions = {
    contractAddress: contractAddress,
    functionName: "createNewUser",
    abi: contractAbi,
    params: {
        _nickName: "Tippi",
        _imgURL: "http:google.com"
    }
}

const transaction = await Moralis.executeFunction(sendOptions);
console.log(transaction.hash);

await transaction.wait();
