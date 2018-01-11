#!/usr/bin/env bash

gem uninstall kele

rm kele-0.0.1.gem

gem build kele.gemspec

gem install ./kele-0.0.1.gem