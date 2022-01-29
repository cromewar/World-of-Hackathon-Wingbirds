from brownie import Wingbird
from scripts.helpful_scripts import get_account


def deploy_wingbird():
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})


def main():
    deploy_wingbird()
