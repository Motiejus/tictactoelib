from os.path import join, dirname
from pip.req import parse_requirements
from setuptools import setup, find_packages

reqs_file = join(dirname(__file__), "requirements.txt")
install_reqs = list(parse_requirements(reqs_file))

setup(
    name='tictactoelib',
    version='0.0.1',
    author="Motiejus Jakštys",
    author_email='desired.mta@gmail.com',
    description="Ultimate Tic Tac Toe game logic (Lua and Python bindings)",
    long_description=open(join(dirname(__file__), 'README.rst')).read().strip(),
    url="http://github.com/Motiejus/ultimate-tic-tac-toe",
    license='Apache2',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Intended Audience :: Education',
        'Natural Language :: English',
        'License :: OSI Approved :: Apache Software License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Lua',
        'Topic :: Games/Entertainment :: Board Games',
    ],
    packages=['tictactoelib'],
    install_requires=[str(ir.req) for ir in install_reqs],
    include_package_data=True,
    entry_points={
        'console_scripts': [
            'tictactoelib = tictactoelib.run:main'
        ]
    },
)
