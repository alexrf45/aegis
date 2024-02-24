#!/bin/bash

function virtual_env() {
	mkdir $1 &&
		cd $1 &&
		virtualenv .venv &&
		source .venv/bin/activate
}
