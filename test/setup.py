
from setuptools import setup, find_packages

setup(
    name='aegis',
    version='0.1.0',
    packages=find_packages(),
    install_requires=[
        'docker==7.1.0',
        'questionary==2.0.1',
        'pycryptodome==3.21.0',
        'fabric==3.2.2',
    ],
    entry_points={
        'console_scripts': [
            'aegis = aegis.cli:main',
        ],
    },
)
