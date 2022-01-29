from brownie import network, accounts, config

NON_FORKED_LOCAL_BLOCKCHAINS = ["hardhat", "development", "ganache"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = NON_FORKED_LOCAL_BLOCKCHAINS + [
    "mainnet-fork",
    "binance-fork",
    "avax-fork",
]


def get_account(index=None, id=None):
    if id:
        return accounts.load(id)
    if index:
        return accounts[index]
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        return accounts[0]
    return accounts.add(config["wallets"]["from_key"])
