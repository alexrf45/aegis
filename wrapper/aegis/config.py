import yaml


def load_profiles():
    with open("aegis/profiles.yaml", "r") as file:
        return yaml.safe_load(file)["profiles"]
