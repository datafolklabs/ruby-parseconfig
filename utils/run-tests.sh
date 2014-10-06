#!/bin/bash

pushd tests
    rspec test_parseconfig.rb
popd
