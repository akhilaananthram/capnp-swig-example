#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name="capnp-files",
      version="1.0",
      namespace_packages=["example"],
      description="",
      author="Scott Purdy",
      author_email="scott@fer.io",
      packages=find_packages(),
      package_data={"example.proto": ["*.capnp"]},
      include_package_data=True
     )
