#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name="capnp-helper-files",
      version="1.0",
      namespace_packages=["example"],
      description="",
      author="Scott Purdy",
      author_email="scott@fer.io",
      packages=find_packages(),
      include_package_data=True
     )
