from brownie import Wingbird
from scripts.helpful_scripts import (
    get_account,
    get_contract,
    fund_with_link,
    config,
    network,
)
import os
import shutil
import yaml
import json


def deploy_wingbird(update_front_end=False):
    account = get_account()
    wingbird = Wingbird.deploy(
        get_contract("vrf_coordinator").address,
        get_contract("link_token").address,
        config["networks"][network.show_active()]["fee"],
        config["networks"][network.show_active()]["keyhash"],
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )

    tx = fund_with_link(wingbird.address)
    tx.wait(1)

    if update_front_end:
        update_frontend()

    return wingbird


def update_frontend():
    # Send the build folder to the frontend.
    copy_folder_to_frontend("./build", "./front-end/src/chain-info")
    # Send brownie-config to frontend 'src'
    with open("brownie-config.yaml", "r") as brownie_config:
        config_dict = yaml.load(brownie_config, Loader=yaml.FullLoader)
        with open("./front-end/src/brownie-config.json", "w") as brownie_config_json:
            json.dump(config_dict, brownie_config_json)


def copy_folder_to_frontend(src, dest):
    if os.path.exists(dest):
        shutil.rmtree(dest)
    shutil.copytree(src, dest)


def main():
    deploy_wingbird(update_front_end=True)
