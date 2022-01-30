from scripts.deploy import get_account

from brownie import Wingbird

import brownie


def test_can_create_user():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    tx = wingbird.createNewUser("Cromewar", account.address, 2, "http://test.com")
    tx.wait(1)
    user = wingbird.getUser(account.address)
    print(user)
    assert user[0] == "Cromewar"


def test_can_add_seeds_to_user():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    wingbird.giveInitialSeeds(account.address, 10)
    user_balance = wingbird.getUserBalance(account.address)

    assert user_balance == 10


def test_can_send_honors():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    wingbird.giveInitialSeeds(account.address, 10)
    wingbird.giveHonors(1, {"from": account})
    user_balance = wingbird.getUserBalance(account.address)
    print(user_balance)

    assert user_balance == 9


def test_can_set_honors():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    wingbird.giveInitialSeeds(account.address, 10)
    wingbird.setFinalHonors(10, 20, 30, 40, 50, account.address)
    honors = wingbird.getFinalHonors(account.address)
    print(honors)
    assert honors[0] == 10


def test_get_total_birds():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    tx = wingbird.createNewUser("Cromewar", account.address, 2, "http://test.com")
    tx.wait(1)
    total_users = wingbird.getTotalBirds()
    print(total_users)
    assert total_users == 1


def test_sync_senses():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    fake_cid = "ajsdlqjweoqwiueqwohflkj"
    accounts = [account.address, get_account(1), get_account(2)]
    wingbird.syncSenses(fake_cid, accounts)
    ipfs_object = wingbird.getIpfsObject(fake_cid)
    assert ipfs_object[1][0] == account.address


def test_reach_consensus():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})
    consensus = True
    fake_cid = "ajsdlqjweoqwiueqwohflkj"
    accounts = [account.address, get_account(1), get_account(2)]
    wingbird.reachConsensus(consensus, fake_cid, accounts)
    ipfs_object = wingbird.getIpfsObject(fake_cid)
    assert ipfs_object[1][0] == account.address
