#!/bin/sh
if which brew >/dev/null 2>&1; then
	brew install nano || brew upgrade nano
fi
