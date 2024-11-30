
from setuptools import setup, find_packages

setup(
    name="aegis",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "docker==7.1.0",
        "tqdm==4.67.0",
        "questionary==2.0.1",
        "pycrypto==2.6.1",
        "fabric==3.2.2",
        "paramiko==3.5.0",
        "paramiko-jump==0.1.3"
    ],
    entry_points={
        "console_scripts": [
            "aegis=aegis.main:main"
        ]
    },
    author="Sean Fontaine",
    author_email="aegis@f0nzy.com",
    description="A Docker wrapper/TUI for managing aegis containers",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    url="https://github.com/alexrf45/aegis.git",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.6",
)
