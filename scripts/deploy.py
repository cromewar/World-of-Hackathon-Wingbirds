from brownie import Wingbird
from scripts.helpful_scripts import get_account
import os
import shutil
import yaml
import json


def deploy_wingbird(update_front_end=False):
    account = get_account()
    wingbird = Wingbird.deploy({"from": account})

    if update_frontend:
        update_frontend()


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
    deploy_wingbird()
