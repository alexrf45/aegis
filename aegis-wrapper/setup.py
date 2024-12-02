from setuptools import setup, find_packages

setup(
    name='aegis',
    version='1.0.0',
    packages=find_packages(),
    install_requires=[
        'docker==7.1.0',
        'questionary==2.0.1',
        'pycryptodome==3.21.0',
        'fabric==3.2.2',
        'requests~=2.32.3',
        'rich~=13.7.1',
        'GitPython~=3.1.43',
        'PyYAML>=6.0.2',
        'argcomplete~=3.5.0',
        'tzlocal~=5.2',
        'ifaddr~=0.2.0',
    ],
    entry_points={
        'console_scripts': [
            'aegis=aegis.cli:main',
        ],
    },
)
