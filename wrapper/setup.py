from setuptools import setup, find_packages

setup(
    name="aegis",
    version="0.2.0",
    packages=find_packages(),
    install_requires=[
        "docker==7.1.0",
        "tqdm==4.67.0",
        "questionary==2.0.1",
        "pycryptodome==3.18.0",
        "fabric==3.2.2",
        "paramiko==3.5.0",
        "paramiko-jump==0.1.3",
        "pyyaml==6.0",
    ],
    entry_points={
        "console_scripts": [
            "aegis=aegis.main:main"
        ]
    },
    python_requires=">=3.6",
)
